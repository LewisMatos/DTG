class UserEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event


  before_create do
  	if self.liked == 'yes'

  		if UserEvent.all.select { |e| e.user_id == self.shown_user_id && e.shown_user_id == self.user_id && e.event_id == self.event_id}.length > 0
  			self.not_alerted = 'yes'
  		end
  	end
    # open_conversation_1
    # open_conversation_2
    #binding.pry
  end



  # This method allows me to match myself with another facebook account
  def self.match_me
    UserEvent.create(user_id: 22, shown_user_id: 23, event_id: 1, liked: 'yes')
    UserEvent.create(user_id: 23, shown_user_id: 22, event_id: 1, liked: 'yes')
  end

  def convo
    Mailboxer::Conversation.count
  end

  def last_convo
    Mailboxer::Conversation.count
  end

  def last_notification
    Mailboxer::Notification.count
  end

  def last_receipt
    Mailboxer::Receipt.count
  end


  def open_conversation_1 
    Mailboxer::Conversation.create(id: last_convo + 1, subject: "You've been matched", created_at: Time.now, updated_at: Time.now)
    Mailboxer::Notification.create(id: last_notification + 1, type: "Mailboxer::Message", sender_id: 0, sender_type: "User", body: "", subject: "You've been matched", updated_at: Time.now, created_at: Time.now, conversation_id: last_convo)
    Mailboxer::Receipt.create(id: last_receipt + 1, mailbox_type: "inbox", receiver_id: user_id, receiver_type: "User", is_read: "t", notification_id: last_notification, created_at: Time.now, updated_at: Time.now)
  end

  def open_conversation_2
    Mailboxer::Receipt.create(id: last_receipt + 1, mailbox_type: "inbox", receiver_id: shown_user_id, receiver_type: "User", is_read: "t", notification_id: last_notification, created_at: Time.now, updated_at: Time.now)
    # Mailboxer::Notification.create(id: last_notification + 1, type: "Mailboxer::Message", sender_id: 0, sender_type: "User", body: "", subject: "You've been matched", updated_at: Time.now, created_at: Time.now, conversation_id: last_convo)
  end


end
