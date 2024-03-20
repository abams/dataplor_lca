# frozen_string_literal: true

class CreateNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :nodes do |t|
      t.references :parent, index: true
      t.timestamps
    end
  end
end
