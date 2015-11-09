class ApplicationController < ActionController::Base
	include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
#  before_action :authenticate_user!
 # before_action :auth_user
  
	helper_method :mailbox, :conversation,:resource_name, :resource, :devise_mapping, :auth_user

	private

  def auth_user
    redirect_to 'dashboard/index' unless user_signed_in?
  end


	def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  protected
end
