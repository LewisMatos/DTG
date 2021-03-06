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

  def taginbox(conversation)
    conversation.recipients.delete_if do |i|
      i.name == current_user.name
    end
  end


end
