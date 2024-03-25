# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nodes::LeastCommonAncestorService do
  subject { Nodes::LeastCommonAncestorService.new(node_a, node_b) }

  describe '#common_ancestor' do
    let(:root) { create(:node, parent_id: nil) }                              #        |-r-
    let(:child_a) { create(:node, parent_id: root.id) }                       #     |-ca-|
    let(:grandchild_aa) { create(:node, parent_id: child_a.id) }              #    gca   |
    let(:grandchild_ab) { create(:node, parent_id: child_a.id) }              #         gcb -|
    let(:great_grandchild_aba) { create(:node, parent_id: grandchild_ab.id) } #             gcba

    context 'when a given node is nil' do
      let(:node_a) { root }
      let(:node_b) { nil }

      it { expect(subject.common_ancestor).to be_nil }
    end

    context 'when given nodes are the same node' do
      let(:node_a) { child_a }
      let(:node_b) { node_a.clone }

      it { expect(subject.common_ancestor.id).to eq(child_a.id) }
    end

    context 'when nodes have no common anscestor' do
      let(:node_a) { child_a }
      let(:node_b) { create(:node) }

      it { expect(subject.common_ancestor).to be_nil }
    end

    context 'when nodes are direct descendent of LCA, but not root' do
      let(:node_a) { grandchild_aa }
      let(:node_b) { grandchild_ab }

      it { expect(subject.common_ancestor.id).to eq(child_a.id) }
    end

    context 'when nodes are have varying levels from LCA' do
      let(:node_a) { great_grandchild_aba }
      let(:node_b) { grandchild_aa }

      it { expect(subject.common_ancestor.id).to eq(child_a.id) }
    end

    context 'when given node is root of other node' do
      let(:node_a) { great_grandchild_aba }
      let(:node_b) { root }

      it { expect(subject.common_ancestor.id).to eq(root.id) }
    end

    context 'when node_a is direct child of node_b, but node_b is not root' do
      let!(:node_a) { great_grandchild_aba }
      let!(:node_b) { grandchild_ab }

      it { expect(subject.common_ancestor.id).to eq(grandchild_ab.id) }
    end
  end
end
