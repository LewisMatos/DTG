class UserEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event


  before_create do
  	if self.liked == 'yes'
  		if UserEvent.all.select { |e| e.user_id == self.shown_user_id && e.shown_user_id == self.user_id && e.event_id == self.event_id}.length > 0
  			self.not_alerted = 'yes'
  		end
  	end
  end

  def self.match_me
    UserEvent.create(user_id: 22, shown_user_id: 23, event_id: 1, liked: 'yes')
    UserEvent.create(user_id: 23, shown_user_id: 22, event_id: 1, liked: 'yes')
  end


end
