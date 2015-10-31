class MailboxController < ApplicationController
  #before_action :authenticate_user!
	 before_action :auth_user
  def inbox
    @inbox = mailbox.inbox
    @active = :inbox
    #binding.pry
  end

  def sent
    @sent = mailbox.sentbox
    @active = :sent
  end

  def trash
    @trash = mailbox.trash
    @active = :trash
  end


end
