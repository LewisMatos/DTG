module ApplicationHelper	
	def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-success"
      when :info then "alert alert-info"
      when :alert then "alert alert-danger"
      when :warning then "alert alert-warning"
    end
  end

  def active_page(active_page)
    @active == active_page ? "active" : ""
	end
	
	def resource_class
  devise_mapping.to
	end
	
	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def bubble(user)
    current_user.name == user ? "from-me" : "from-them"
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

#make sure that the inbox column is set to inbox for both users.
  def open_conversation 
    Mailboxer::Conversation.create(id: last_convo + 1, subjects: "You've been matched", created_at: Time.now, updated_at: Time.now)
    Mailboxer::Notification.create(id: last_notification + 1, type: "Mailboxer::Message", sender_id: 0, sender_type: "User", body: "", subject: "You've been matched", updated_at: Time.now, created_at: Time.now)
    Mailboxer::Notification.create(id: last_notification + 1, type: "Mailboxer::Message", sender_id: 0, sender_type: "User", body: "", subject: "You've been matched", updated_at: Time.now, created_at: Time.now)
    Mailboxer::Receipt.create(id: last_receipt + 1, mailbox_type: "inbox", receiver_id: user_id, receiver_type: "User", is_read: "t", notification_id: last_notification, created_at: Time.now, updated_at: Time.now)
    Mailboxer::Receipt.create(id: last_receipt + 1, mailbox_type: "inbox", receiver_id: shown_user_id, receiver_type: "User", is_read: "t", notification_id: last_notification, created_at: Time.now, updated_at: Time.now)
  end
end
