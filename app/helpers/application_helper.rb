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


  def open_conversation 
    Mailboxer::Conversation.create!(subjects: "You've been matched")
    Mailboxer::Notification.create!(type: "Mailboxer::Message", sender_id: 0, sender_type: "User", body: "You've been matched", subject: "You've been matched")
    Mailboxer::Receipt.create!(mailbox_type: "inbox", receiver_id: user_id, notification_id: last_notification)
  end

end
