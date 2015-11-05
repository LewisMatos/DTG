class MailboxController < ApplicationController
  #before_action :authenticate_user!
	 before_action :auth_user
  def inbox
    @inbox = mailbox.inbox
    @active = :inbox
    @chat = mailbox.conversations
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
