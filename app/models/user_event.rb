class UserEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event



  before_create do
  	if self.liked == 'yes'
  		if UserEvent.all.select { |e| e.user_id == self.shown_user_id && e.shown_user_id == self.user_id && e.event_id == self.event_id}.length > 0
  			self.not_alerted = 'yes'
        open_conversation
  		end
  	end
  end

  # This method allows me to match myself with another facebook account
  def self.match_me
    UserEvent.create(user_id: 22, shown_user_id: 23, event_id: 1, liked: 'yes')
    UserEvent.create(user_id: 23, shown_user_id: 22, event_id: 1, liked: 'yes')
  end


  # Helper methods for open_conversation method 
  def last_convo
    Mailboxer::Conversation.count
  end

  def last_notification
    Mailboxer::Notification.count
  end

  def last_receipt
    Mailboxer::Receipt.count
  end

  # Creates the state of an open conversation between two users when a match is made. Method implemented in the before_do callback
  def open_conversation 
    Mailboxer::Conversation.create!(subject: "You've been matched")
    Mailboxer::Notification.create!(type: "Mailboxer::Message", sender_id: user_id, sender_type: "User", body: "You've been matched", subject: "You've been matched", conversation_id: last_convo)
    Mailboxer::Receipt.create!(mailbox_type: "inbox", receiver_id: shown_user_id, receiver_type: "User", is_read: "t", notification_id: last_notification)
    Mailboxer::Receipt.create!(mailbox_type: "inbox", receiver_id: user_id, receiver_type: "User", is_read: "t", notification_id: last_notification)
  end


end
