# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BirdsController do
  describe 'GET nodes' do
    let(:subject) { get :index, params: { node_ids: } }

    let(:node_ids) { nil }

    context 'without params' do
      it { expect(subject.status).to eq(200) }
      it { expect(JSON.parse(subject.body).symbolize_keys[:birds]).to be_empty }
    end

    context 'with invalid node ids' do
      let(:node) { create(:node) }
      let(:node_ids) { [node.id, nil] }

      it { expect(subject.status).to eq(200) }
      it { expect(JSON.parse(subject.body).symbolize_keys[:birds]).to be_empty }
    end

    context 'with 2 valid node params' do
      let(:root) { create(:node, parent_id: nil) }                              #        |-r-
      let(:child_a) { create(:node, parent_id: root.id) }                       #     |-ca-|
      let(:grandchild_aa) { create(:node, parent_id: child_a.id) }              #    gca   |
      let(:grandchild_ab) { create(:node, parent_id: child_a.id) }              #         gcb -|
      let(:great_grandchild_aba) { create(:node, parent_id: grandchild_ab.id) } #             gcba

      let!(:root_bird) { create(:bird, node_id: root.id) }                                 #        |-r-
      let!(:child_a_bird) { create(:bird, node_id: child_a.id) }                           #     |-ca-|
      let!(:grandchild_aa_bird) { create(:bird, node_id: grandchild_aa.id) }               #    gca   |
      let!(:grandchild_ab_bird) { create(:bird, node_id: grandchild_ab.id) }               #         gcb -|
      let!(:great_grandchild_aba_bird) { create(:bird, node_id: great_grandchild_aba.id) } #             gcba
      let(:bird_ids) do
        [root_bird, child_a_bird, grandchild_aa_bird, grandchild_ab_bird, great_grandchild_aba_bird].map(&:id)
      end

      let(:node_ids) do
        [
          root_bird.node_id,
          child_a_bird.node_id,
          grandchild_aa_bird.node_id,
          grandchild_ab_bird.node_id,
          great_grandchild_aba_bird.node_id
        ].join(',')
      end

      it { expect(subject.status).to eq(200) }
      it { expect(JSON.parse(subject.body).symbolize_keys[:birds]).to include(*bird_ids) }
    end
  end
end
