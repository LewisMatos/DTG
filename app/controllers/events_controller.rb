class EventsController < ApplicationController
	before_action :auth_user
	
	before_action :set_event, only: [:show, :edit, :update, :destroy, :pin_event, :unpin_event]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
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
    event = Event.find_by_id(params["id"]) 
    current_user.events << event unless current_user.events.find_by_id(event.id)
    redirect_to "/events/#{params["id"]}"
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
