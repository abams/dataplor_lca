require 'rails_helper'

RSpec.describe Nodes::CommonAncestorService do 
	subject { Nodes::CommonAncestorService.new(node_a, node_b) }

  # TODO: Maybe rename to example numbers given in csv
  # Exlpain it's for ease of evaluation
	describe "#find_common_ancestor" do 
    let(:root) { create(:node, parent_id: nil) }                                    #        |-r-
    let(:child_a) { create(:node, parent_id: root.id) }                             #     |-ca-|
    let(:grandchild_aa) { create(:node, parent_id: child_a.id) }                    #    gca   |
    let(:grandchild_ab) { create(:node, parent_id: child_a.id) }                    #         gcb -|
    let(:great_grandchild_aba) { create(:node, parent_id: grandchild_ab.id) }       #             gcba

    context "when a given node is nil" do
			let(:node_a) { root }
			let(:node_b) { nil }

			it { expect(subject.find_common_ancestor).to be_nil }
		end

		context "when given nodes are the same node" do
			let(:node_a) { child_a }
			let(:node_b) { node_a.clone }
      let(:expected_result) { { root_id: root.id, common_ancestor_id: child_a.id, depth: 2 } }

			it { expect(subject.find_common_ancestor).to eq(expected_result) }
		end

    context "when nodes have no common anscestor" do
      let(:node_a) { child_a }
      let(:node_b) { create(:node) }

      let(:expected_result) { { root_id: nil, common_ancestor_id: nil, depth: nil} }

      it { expect(subject.find_common_ancestor).to eq(expected_result) }
    end

    context "when nodes are direct descendent of LCA, but not root" do
      let(:node_a) { grandchild_aa }
      let(:node_b) { grandchild_ab }
      let(:expected_result) { { root_id: root.id, common_ancestor_id: child_a.id, depth: 2 } }

      it { expect(subject.find_common_ancestor).to eq(expected_result) }
    end

    context "when nodes are have varying levels from LCA" do
      # TODO: Move parent_id to factory?
      let(:node_a) { great_grandchild_aba }
      let(:node_b) { grandchild_aa}
      let(:expected_result) { { root_id: root.id, common_ancestor_id: child_a.id, depth: 2 } }

      it { expect(subject.find_common_ancestor).to eq(expected_result) }
    end

    context "when given node is root of other node" do
      let(:node_a) { great_grandchild_aba }
      let(:node_b) { root }
      let(:expected_result) { { root_id: root.id, common_ancestor_id: root.id, depth: 1 } }

      it { expect(subject.find_common_ancestor).to eq(expected_result) }
    end

    context "when node_a is direct child of node_b, but node_b is not root"  do
      let(:node_a) { great_grandchild_aba }
      let(:node_b) { grandchild_ab }
      let(:expected_result) { { root_id: root.id, common_ancestor_id: grandchild_ab.id, depth: 3 } }

      it { expect(subject.find_common_ancestor).to eq(expected_result) }
    end
	end
end
