class EventsController < ApplicationController
	before_action :auth_user, except: [:notloggedin]
	
	# before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  def myevents
    @events = Event.find_by_sql("select * from events where events.id in (select user_events.event_id from user_events where user_events.user_id = #{current_user.id} and user_events.id not in (select user_events.id from user_events where user_events.user_id = #{current_user.id} and user_events.liked = 'yes' or user_events.liked = 'no')) order by events.date")
    render :events_index, layout: false 
  end
  def allevents
    @events = Event.all.order('date')
    render :events_index, layout: false
  end
  def notloggedin
    render :not_logged_in
  end

  # GET /events/1
  # GET /events/1.json
  def show

    if current_user && current_user.events.include?(@event)
      @shown_user = current_user.get_user(@event)
      if !@shown_user
        @message = "There are no Users to display at this time."
      else
        @shown_user_image = @shown_user[0].user_image
      end
    else
        @message = "Please pin event to continue."
    end

  end

  # GET /events/new
  def new
	if current_user.admin?
    @event = Event.new
	else
	render :file => "#{Rails.root}/public/not_found.html"
	end
	end
  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pin_event
    # when a user clicks the pin event button, this will find that event, (the id is passed in the route)
    # and will add them to the users list of events/user_events table, unless that user has already pinned the event
    # it redirects back to the events page
    event = Event.find_by_id(params["event_id"].to_i)
    if UserEvent.all.select{ |e| e.event_id == event.id && e.user_id == current_user.id && e.liked == nil}.length > 0
      data = {"event_pinned" => false}
    else
      UserEvent.create(event_id: event.id, user_id: current_user.id)
      data = {"event_pinned" => true}
    end
    render json: data
  end

  def tinder_logic
    @event = Event.find_by_id(params['event_id'].to_i)
      if params['like']
        UserEvent.create( user_id: current_user.id, event_id: params["event_id"].to_i, shown_user_id: params["shown_user"].to_i, liked: params["like"])
      elsif params['pin_event']
        if UserEvent.all.select{ |e| e.event_id == @event.id && e.user_id == current_user.id && e.liked == nil}.length > 0
          UserEvent.all.select{ |e| e.event_id == @event.id && e.user_id == current_user.id && e.liked == nil}.each{|e| e.destroy}
        else
          UserEvent.create(event_id: @event.id, user_id: current_user.id)
        end
      end
    if current_user.interested_in == nil
      @no_profile = true
      @message = "Please update your profile to continue"
    else
    if current_user && UserEvent.all.select{ |e| e.event_id == @event.id && e.user_id == current_user.id && e.liked == nil}.length > 0

      @shown_user = current_user.get_user(@event)
      if !@shown_user
        @message = "There are no Users to display at this time."
      else
        @shown_user_image = @shown_user[0].user_image
      end

    else
        @message = "Please pin event to continue."
    end
  end

    render layout: false

  end

  def have_match
    matches = UserEvent.find_by_sql("select * from user_events where user_events.shown_user_id = #{current_user.id} and user_events.not_alerted = 'yes'")
    if matches.length > 0
      json = {matches: []}
      matches.each do |match|
      json[:matches] << {'name' => User.find(match.user_id).name, 'event' => Event.find(match.event_id).title  }
      match.update(not_alerted: 'no')
     end
    else
      json = { has_match: 'no'}
    end
    render :json => json
  end


  def unpin_event

    # this will remove the event from the users list of events and redirect to the users page.
    event = Event.find_by_id(params["id"]) 
    current_user.events.delete(event)
    redirect_to "/dashboards/index/#t2"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_event
    #   @event = Event.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :venue, :street_number, :city, :state, :zip, :description, :url, :image, :category)
    end
end
