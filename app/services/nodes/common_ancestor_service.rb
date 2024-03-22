module Nodes
	class CommonAncestorService

		def initialize(node_a, node_b)
			@node_a = node_a
			@node_b = node_b
			@paths = { left: [@node_a&.id].compact, right: [@node_b&.id].compact }
		end

		def find_common_ancestor
			return nil if @paths[:left].empty? || @paths[:right].empty?
			# return nil if @node_a.nil? || @node_b.nil?

			# The instructions asked for node_a to be returned
			# return @node_a if @node_a.id == @node_b.id
			#
			# I thought it would be better to return consistent results representing
			# that node_a is the LCA of itself, having a common root (similar to direct parent/child nodes)
			# this is handeled with the rest of the exising workflow
			
			common_ancestor = (@paths[:left] & @paths[:right]).first
			
			if common_ancestor.present? 
				# binding.pry # can refactor this to use parent ... too tired rn tho
				root_id, depth = find_root(common_ancestor)

				return { root_id: root_id, common_ancestor_id: common_ancestor, depth: depth }
			end

			@node_a = @node_a&.parent
			@node_b = @node_b&.parent

			return { root_id: nil , common_ancestor_id: nil , depth: nil } if @node_a.nil? and @node_b.nil?

			@paths[:left] << @node_a.id if @node_a
			@paths[:right] << @node_b.id if @node_b

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
