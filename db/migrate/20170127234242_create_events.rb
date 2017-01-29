class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.belongs_to :organization, index: true
      t.string :message
      t.string :hostname
      t.timestamp :timestamp
      t.timestamps
    end
  end
end
