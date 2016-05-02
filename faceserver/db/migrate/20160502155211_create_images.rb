class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.integer :attachment_id
      t.string  :attachment_type
      t.attachment :content
    end
  end
end