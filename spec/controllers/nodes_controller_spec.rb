require 'rails_helper'

RSpec.describe NodesController do 
	let(:node) { create(:node) }

	describe "GET common_ancestor" do 

		context "without params" do 
			it "returns 404" do 
				get :common_ancestor
				
				expect(response.status).to eq(404)
			end
		end

		context "with only 1 valid node param" do
			it "returns 404" do 
				get :common_ancestor, params: { a: node.id }

				expect(response.status).to eq(404)
			end
		end

		context "with 2 valid node params" do
			let(:other_node) { create(:node) }

			it "returns 200" do 
				get :common_ancestor, params: { a: node.id, b: other_node.id }

				expect(response.status).to eq(200)
			end

			it "returns proper json" do 

			end
		end

		context "with both params having the same node id" do 
		end

		context "with valid node parameters" do 
		end

		# These should be "service" specs IMO
		# same node
		# one node no parent
		# one node referencing 2nd node parent
		# two unique nodes no ancestor
		# two unique nodes common ancestor
	end
end
