class CreateWysiwygs < ActiveRecord::Migration
  def self.up
    create_table :wysiwygs do |t|
      t.string :name
      t.string :content
      t.timestamps
    end
  end

  def self.down
    drop_table :wysiwygs
  end
end