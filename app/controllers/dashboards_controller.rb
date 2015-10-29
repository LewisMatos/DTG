class DashboardsController < ApplicationController
  def index
    @events = Event.all
    everyone_loves_me
  end

  def everyone_loves_me 
   # randomly assign all users except me to events, users all like current user                     
    if UserEvent.all[3].nil?	
      User.all.each do |user| 
            Event.all.each do |event|
              if (user.id != current_user.id)  && (current_user)
                user.events << event
              	UserEvent.create(user_id: user.id, event_id: event.id, shown_user_id: current_user.id, liked: 'yes') 
              end
            end  
      end   
    end
  end


  def pin_event
    # when a user clicks the pin event button, this will find that event, (the id is passed in the route)
    # and will add them to the users list of events/user_events table, unless that user has already pinned the event
    # it redirects back to the events page
    event = Event.find_by_id(params["id"]) 
    current_user.events << event unless current_user.events.find_by_id(event.id)
    redirect_to "/dashboards/index#t2"
  end



  def unpin_event

    # this will remove the event from the users list of events and redirect to the users page.
    event = Event.find_by_id(params["id"]) 
    current_user.events.delete(event)
    redirect_to "/dashboards/index#t2"
  end


end
