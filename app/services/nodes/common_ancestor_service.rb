module Nodes
	class CommonAncestorService

		def initialize(node_a, node_b)
			@node_a = node_a
			@node_b = node_b
			@paths = { left: [@node_a&.id], right: [@node_b&.id] }
		end

		def find_common_ancestor
			return nil if @node_a.nil? || @node_b.nil? 

			# The instructions asked for node_a to be returned
			# return @node_a if @node_a.id == @node_b.id
			#
			# I thought it would be better to return consistent results representing
			# that node_a is the LCA of itself, having a common root (similar to direct parent/child nodes)
			# this is handeled with the rest of the exising workflow
			
			common_ancestor = (@paths[:left] & @paths[:right]).first
			
			if common_ancestor.present? 
				root_id, depth = find_root(common_ancestor)

				return { root_id: root_id, common_ancestor_id: common_ancestor, depth: depth }
			end

			left_parent_id = Node.find(@paths[:left].last).parent_id
			right_parent_id = Node.find(@paths[:right].last).parent_id

			return { root_id: nil , common_ancestor_id: nil , depth: nil } if left_parent_id.nil? and right_parent_id.nil?

			@paths[:left] << left_parent_id if left_parent_id
			@paths[:right] << right_parent_id if right_parent_id

			find_common_ancestor
		end

		private

		def find_root(node_id)
			root_id = node_id
			depth = 0

			until node_id.nil?
				depth += 1

				root_id = node_id
				node_id = Node.find(node_id).parent_id
			end

			[root_id, depth]
		end
	end
end
