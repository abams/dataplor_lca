# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nodes::AncestorsController do
  describe 'GET index' do
    let(:subject) { get :common_ancestor, params: { a: node&.id, b: other_node&.id } }

    let(:node) { nil }
    let(:other_node) { nil }

    context 'without params' do
      it { expect(subject.status).to eq(404) }
    end

    context 'with only 1 valid node param' do
      let(:node) { create(:node) }

      it { expect(subject.status).to eq(404) }
    end

    context 'with 2 valid node params' do
      let(:root) { create(:node) }
      let(:node) { create(:node, parent_id: root.id) }
      let(:other_node) { create(:node, parent_id: root.id) }
      let(:expected_response) do
        {
          root_id: root.id,
          lowest_common_ancestor: root.id,
          depth: 0
        }
      end

      it { expect(subject.status).to eq(200) }
      it { expect(JSON.parse(subject.body).symbolize_keys).to eq(expected_response) }
    end

    context 'when common ancestor is not found' do
      let(:root) { create(:node) }
      let(:other_root) { create(:node) }
      let(:node) { create(:node, parent_id: root.id) }
      let(:other_node) { create(:node, parent_id: other_root.id) }
      let(:expected_response) do
        {
          root_id: nil,
          lowest_common_ancestor: nil,
          depth: nil
        }
      end

      it { expect(subject.status).to eq(200) }
      it { expect(JSON.parse(subject.body).symbolize_keys).to eq(expected_response) }
    end
  end
end
