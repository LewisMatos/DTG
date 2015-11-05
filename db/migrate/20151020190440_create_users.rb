class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
			t.integer :age			
			t.string :gender
      t.string :interested_in
			t.string :image
			t.string :cover
			t.text :bio
			t.string :instagram_url
      t.boolean :real, default: false, null: false
      t.timestamps null: false
    end
  end
end
