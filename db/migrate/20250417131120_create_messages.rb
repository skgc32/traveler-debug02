class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.text :body
      t.boolean :read

      t.timestamps
    end
  end
end
