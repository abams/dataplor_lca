# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Node, type: :model do
  describe '# children' do
    let!(:root) { create(:node, parent_id: nil) }                              #        |-r-
    let!(:child_a) { create(:node, parent_id: root.id) }                       #     |-ca-|
    let!(:grandchild_aa) { create(:node, parent_id: child_a.id) }              #    gca   |
    let!(:grandchild_ab) { create(:node, parent_id: child_a.id) }              #         gcb -|
    let!(:great_grandchild_aba) { create(:node, parent_id: grandchild_ab.id) } #             gcba
    let(:children_ids) { [child_a, grandchild_aa, grandchild_ab, great_grandchild_aba].map(&:id) }

    let!(:other_root) { create(:node, parent_id: nil) }
    let!(:other_child_a) { create(:node, parent_id: other_root.id) }
    let(:other_children_ids) { other_child_a.id }

    it { expect(root.all_children.map(&:id)).to include(*children_ids) }
    it { expect(root.all_children.map(&:id)).not_to include(*other_children_ids) }
  end
end
