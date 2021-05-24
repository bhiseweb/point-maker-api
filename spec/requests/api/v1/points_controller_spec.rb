# frozen_string_literal: true

require 'rails_helper'

describe 'API::V1::PointsController', type: :request do
  let!(:awesome_user) { FactoryBot.create(:user) }
  let!(:awesome_points) { FactoryBot.create_list(:point, 20, created_by: awesome_user) }
  let(:token) { FactoryBot.create(:access_token, resource_owner_id: awesome_user.id) }
  let!(:funny_user) { FactoryBot.create(:user) }
  let!(:funny_points) { FactoryBot.create_list(:point, 20, created_by: funny_user) }

  describe 'unauthorized access' do
    before { get '/api/v1/points' }
    it 'fails when token is not provided' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'get all points' do
    before { get '/api/v1/points', headers: { 'Authorization': "Bearer #{token.token}" } }

    it 'returns all points of user' do
      expect(JSON.parse(response.body)['data'].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'search points by name' do
    before do
      get '/api/v1/points', params: { name: awesome_points.first.name },
                            headers: { 'Authorization': "Bearer #{token.token}" }
    end

    it 'returns points with matching name' do
      expect(JSON.parse(response.body)['data'].map { |p| p['id'] }).to include(awesome_points.first.id.to_s)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create point' do
    before do
      post '/api/v1/points', params: { data: { type: 'Point', attributes: {
        name: 'point1', latitude: '44.23232', longitude: '38.73733'
      } } }, headers: { 'Authorization': "Bearer #{token.token}" }
    end

    it 'return new point' do
      expect(Point.last.name).to eq('point1')
    end

    it 'is created by awesome_user' do
      expect(Point.last.created_by).to eq(awesome_user)
    end

    it 'return success response' do
      expect(response).to have_http_status(:success)
    end

    it 'return create point with values' do
      expect(JSON.parse(response.body)['data']['attributes']['name']).to eq 'point1'
      expect(JSON.parse(response.body)['data']['attributes']['latitude']).to eq 44.23232
      expect(JSON.parse(response.body)['data']['attributes']['longitude']).to eq 38.73733
    end
  end

  describe 'get point with id' do
    context 'access own points' do
      before { get "/api/v1/points/#{awesome_points.last.id}", headers: { 'Authorization': "Bearer #{token.token}" } }

      it 'return point with given id' do
        expect(JSON.parse(response.body)['data']['id']).to eq awesome_points.last.id.to_s
        expect(JSON.parse(response.body)['data']['attributes']['name']).to eq awesome_points.last.name
      end

      it 'return success response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'access others points' do
      before { get "/api/v1/points/#{funny_points.last.id}", headers: { 'Authorization': "Bearer #{token.token}" } }

      it 'return success response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'update point' do
    context 'update own point' do
      before do
        put "/api/v1/points/#{awesome_points.last.id}", params: { data: { type: 'Point', attributes: {
          name: 'update point', latitude: '44.23232', longitude: '38.73733'
        } } }, headers: { 'Authorization': "Bearer #{token.token}" }
      end

      it 'return updated point' do
        expect(awesome_points.last.reload.name).to eq 'update point'
      end

      it 'return success response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'update others point' do
      before do
        put "/api/v1/points/#{funny_points.last.id}", params: { data: { type: 'Point', attributes: {
          name: 'update point', latitude: '44.23232', longitude: '38.73733'
        } } }, headers: { 'Authorization': "Bearer #{token.token}" }
      end

      it 'return success response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'delete point' do
    context 'delete own points' do
      before do
        delete "/api/v1/points/#{awesome_points.last.id}", headers: { 'Authorization': "Bearer #{token.token}" }
      end

      it 'delete given point' do
        expect(Point.all.size).to eq(39)
      end

      it 'return success response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'delete others points' do
      before { delete "/api/v1/points/#{funny_points.last.id}", headers: { 'Authorization': "Bearer #{token.token}" } }

      it 'return success response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
