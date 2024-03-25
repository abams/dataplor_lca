# frozen_string_literal: true

# # frozen_string_literal: true

# class CreateNodes < ActiveRecord::Migration[7.1]
#   def change
#     create_table :nodes do |t|
#       t.references :parent, index: true
#       t.timestamps
#     end
#   end
# end

class CreateNodes < ActiveRecord::Migration[7.1]
  def change
    binding.pry
    create_table :nodes do |t|
      t.string :ancestry, collation: 'C', null: false
      t.index :ancestry
      t.timestamps
    end
  end
end
