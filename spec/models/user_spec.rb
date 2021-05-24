# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#authenticate' do
    let!(:user) { FactoryBot.create(:user, email: 'user@example.com', password: 'mypassword') }

    context 'valid credentials' do
      it 'returns users' do
        expect(User.authenticate('user@example.com', 'mypassword')).to eq user
      end
    end

    context 'invalid credentials' do
      it 'returns nil' do
        expect(User.authenticate('user@example.com', 'password')).to be nil
      end
    end
  end
end
