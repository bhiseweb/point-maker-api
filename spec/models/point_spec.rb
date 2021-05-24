# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Point, type: :model do
  describe '#with_name' do
    let!(:creator) { FactoryBot.create(:creator) }
    let!(:point1) { FactoryBot.create(:point, name: 'New Delhi', creator: creator) }
    let!(:point2) { FactoryBot.create(:point, name: 'Goa', creator: creator) }

    it 'gives points matching with given name' do
      expect(Point.with_name('New')).to eq [point1]
    end

    it 'does not give points that do not match with given name' do
      expect(Point.with_name('Goa')).not_to eq [point1]
    end
  end
end
