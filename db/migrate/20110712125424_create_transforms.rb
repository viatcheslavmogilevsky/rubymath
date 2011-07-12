class CreateTransforms < ActiveRecord::Migration
  def self.up
    create_table :transforms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :transforms
  end
end
