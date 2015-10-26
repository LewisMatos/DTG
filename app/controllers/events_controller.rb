class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :pin_event, :unpin_event]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show


  # this is a sequel query which will eliminate the users who have liked you, and you have also liked.
  # it will then filter out the same gender as you (should be change dto reflect your sexual preference)
  # and will only find the users who have pinned this event.
  my_matched_folk = %Q(
    SELECT * FROM users WHERE users.id IN 
    (SELECT also_likes_me.user_id FROM user_events INNER JOIN user_events AS also_likes_me
      ON user_events.user_id = also_likes_me.shown_user_id 
      AND also_likes_me.liked = 'yes' AND also_likes_me.event_id = #{@event.id} AND user_events.event_id = #{@event.id}
      WHERE user_events.user_id = #{current_user.id} AND user_events.liked = 'yes' AND user_events.event_id = #{@event.id}) AND users.gender != "#{current_user.gender}" AND users.id IN (SELECT user_events.user_id FROM user_events 
      WHERE user_events.event_id = #{@event.id})
    )
  
  # this query will filter out any user you have liked or disliked, and is opposite gender and pinned this event.
  folk_i_liked = %Q(
    SELECT * FROM users WHERE users.id NOT IN
    (SELECT user_events.shown_user_id FROM user_events 
      WHERE user_events.user_id = #{current_user.id} AND liked != 'nil' AND user_events.event_id = #{@event.id})
      AND users.id IN (SELECT users.id FROM users WHERE users.gender != "#{current_user.gender}") AND users.id IN (SELECT user_events.user_id FROM user_events 
      WHERE user_events.event_id = #{@event.id})
    )
  
  # this will run the query to filter out likes and dislikes.
  tinder = User.find_by_sql(folk_i_liked)

  # this will run the query to find your matches
  matches = User.find_by_sql(my_matched_folk) 

  # checks if there is a match. if so it will assign the @user variable to the match.
  if matches.length > 0
    @user = matches.first
    @match = true
  # if there is no match we will check if there are any users that you have not liked/disliked yet, if so will assign to @user.
  else
    if tinder.length > 0
       @user = tinder.first
     end
   end
  # will create a image var for the user, based on whether it's a facebook user, or our fake users. it uses a model method called .real. 
  if @user
    if @user.real
      @user_image = @user.image + "?type=large"
    else
      @user_image = @user.image[66..-1]
    end
  end

  end

  # GET /events/new
  def new
    @event = Event.new
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
    event = Event.find_by_id(params["id"]) 
    current_user.events << event unless current_user.events.find_by_id(event.id)
    redirect_to "/events"
  end



  def unpin_event

    # this will remove the event from the users list of events and redirect to the users page.
    event = Event.find_by_id(params["id"]) 
    current_user.events.delete(event)
    redirect_to "/users/#{current_user.id}"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :venue, :street_number, :city, :sttate, :zip, :description, :url, :image, :category)
    end
end
