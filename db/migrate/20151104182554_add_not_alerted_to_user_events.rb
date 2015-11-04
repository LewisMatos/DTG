class AddNotAlertedToUserEvents < ActiveRecord::Migration
  def change
  	add_column :user_events, :not_alerted, :string
  end
end
