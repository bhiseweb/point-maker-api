# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Point, type: :model do
  describe '#with_name' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:point1) { FactoryBot.create(:point, name: 'New Delhi', created_by: user) }
    let!(:point2) { FactoryBot.create(:point, name: 'Goa', created_by: user) }

    it 'gives points matching with given name' do
      expect(Point.with_name('New')).to eq [point1]
    end

    it 'does not give points that do not match with given name' do
      expect(Point.with_name('Goa')).not_to eq [point1]
    end
  end
end
