class MailboxController < ApplicationController
  #before_action :authenticate_user!
	 before_action :auth_user
  def inbox
    @inbox = mailbox.inbox
    @active = :inbox
  end

  def sent
    @sent = mailbox.sentbox
    @active = :sent
  end

  def trash
    @trash = mailbox.trash
    @active = :trash
  end

  def show
  end


end
