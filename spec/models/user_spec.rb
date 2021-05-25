# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#authenticate' do
    let!(:user) { FactoryBot.create(:user, email: 'user@example.com', password: 'mypassword') }

    context 'with valid credentials' do
      it 'returns users' do
        expect(described_class.authenticate('user@example.com', 'mypassword')).to eq user
      end
    end

    context 'with invalid credentials' do
      it 'returns nil' do
        expect(described_class.authenticate('user@example.com', 'password')).to be nil
      end
    end
  end
end
