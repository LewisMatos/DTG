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




end
