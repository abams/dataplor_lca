# frozen_string_literal: true

require 'rails_helper'

# Testing the gem is not necessary,
# but wrote these tests to navigate the gem in development
RSpec.describe Node, type: :model do
  let!(:root) { create(:node, parent_id: nil) }                              #        |-r-
  let!(:child_a) { create(:node, parent_id: root.id) }                       #     |-ca-|
  let!(:grandchild_aa) { create(:node, parent_id: child_a.id) }              #    gca   |
  let!(:grandchild_ab) { create(:node, parent_id: child_a.id) }              #         gcb -|
  let!(:great_grandchild_aba) { create(:node, parent_id: grandchild_ab.id) } #             gcba
  let(:children_ids) { [child_a, grandchild_aa, grandchild_ab, great_grandchild_aba].map(&:id) }

  let!(:other_root) { create(:node, parent_id: nil) }
  let!(:other_child_a) { create(:node, parent_id: other_root.id) }
  let(:other_children_ids) { other_child_a.id }

  describe '# descendents' do
    it { expect(root.descendants.map(&:id)).to include(*children_ids) }
    it { expect(root.descendants.map(&:id)).not_to include(*other_children_ids) }
  end

  describe '# ancestors' do
    let(:expected_ancestry) { [grandchild_ab.id, child_a.id, root.id] }

    it { expect(great_grandchild_aba.ancestry.split('/').map(&:to_i).compact).to include(*expected_ancestry) }
  end
end
