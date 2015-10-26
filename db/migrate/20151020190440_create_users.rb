class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
			t.integer :age			
			t.string :gender
			t.string :image
			t.string :cover
      t.boolean :real, default: false, null: false
      t.timestamps null: false
    end
  end
end
