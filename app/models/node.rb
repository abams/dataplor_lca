class Node < ApplicationRecord
	has_many :children, class_name: 'Node', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Node', foreign_key: 'parent_id', :optional => true

	has_many :birds

	# https://medium.com/@_ArtOfCode/working-with-hierarchical-data-structures-in-rails-8e5c093341ca
	def all_children
		query = File.read(Rails.root.join('lib/queries/node_children_cte.sql'))
	  query = query.gsub('PARENTID', id.to_s) # has this node_id as parent id in chain
	  children_ids = ActiveRecord::Base.connection.execute(query).to_a.map(&:first).map(&:last)
	  Node.where(id: children_ids)
	end
end
