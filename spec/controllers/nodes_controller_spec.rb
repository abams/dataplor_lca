require 'rails_helper'

RSpec.describe NodesController do
	describe "GET common_ancestor" do
		let(:subject) { get :common_ancestor, params: { a: node&.id, b: other_node&.id } }

		let(:node) { nil }
		let(:other_node) { nil }

		context "without params" do
			it { expect(subject.status).to eq(404) }
		end

		context "with only 1 valid node param" do
			let(:node) { create(:node) }

			it { expect(subject.status).to eq(404) }
		end

		context "with 2 valid node params" do
			let(:root) { create(:node) }
			let(:node) { create(:node, parent_id: root.id) }
			let(:other_node) { create(:node, parent_id: root.id) }
			let(:expected_response) { Nodes::CommonAncestorService.new(node, other_node).find_common_ancestor }

			it { expect(subject.status).to eq(200) }
			it { expect(JSON.load(subject.body).symbolize_keys).to eq(expected_response) }
		end
	end
end
