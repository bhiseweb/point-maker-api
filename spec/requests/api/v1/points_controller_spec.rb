require 'rails_helper'

describe 'API::V1::PointsController', :type => :request do
  let!(:application) { FactoryBot.create(:application) }
  let!(:awesome_creator) { FactoryBot.create(:creator) }
  let!(:awesome_points) { FactoryBot.create_list(:point, 20, creator: awesome_creator) }
  let(:token) { FactoryBot.create(:access_token, application: application, resource_owner_id: awesome_creator.id) }
  let!(:funny_creator) { FactoryBot.create(:creator) }
  let!(:funny_points) { FactoryBot.create_list(:point, 20, creator: funny_creator) }

  describe 'unauthorized access' do
    before { get '/api/v1/points' }
    it 'fails when token is not provided' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'get all points' do
    before { get '/api/v1/points', headers: { 'Authorization': 'Bearer ' + token.token } }

    it 'returns all points of creator' do
      expect(JSON.parse(response.body)['data'].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create point' do
    before { post '/api/v1/points', params: { data: { type: 'Point', attributes: {
        name: 'point1', latitude: '44.23232', longitude: '38.73733'}}}, headers: { 'Authorization': 'Bearer ' + token.token } }

    it 'return new point' do
      expect(Point.last.name).to eq('point1')
    end

    it 'is created by awesome_creator' do
      expect(Point.last.creator).to eq(awesome_creator)
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
      before { get "/api/v1/points/#{awesome_points.last.id}", headers: { 'Authorization': 'Bearer ' + token.token } }

      it 'return point with given id' do
        expect(JSON.parse(response.body)['data']['id']).to eq awesome_points.last.id.to_s
        expect(JSON.parse(response.body)['data']['attributes']['name']).to eq awesome_points.last.name
      end

      it 'return success response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'access others points' do
      before { get "/api/v1/points/#{funny_points.last.id}", headers: { 'Authorization': 'Bearer ' + token.token } }

      it 'return success response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'update point' do
    context 'update own point' do
      before { put "/api/v1/points/#{awesome_points.last.id}", params: { data: { type: 'Point', attributes: {
          name: 'update point', latitude: '44.23232', longitude: '38.73733'}}}, headers: { 'Authorization': 'Bearer ' + token.token } }

      it 'return updated point' do
        expect(awesome_points.last.reload.name).to eq 'update point'
      end

      it 'return success response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'update others point' do
      before { put "/api/v1/points/#{funny_points.last.id}", params: { data: { type: 'Point', attributes: {
          name: 'update point', latitude: '44.23232', longitude: '38.73733'}}}, headers: { 'Authorization': 'Bearer ' + token.token } }

      it 'return success response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'delete point' do
    context 'delete own points' do
      before { delete "/api/v1/points/#{awesome_points.last.id}", headers: { 'Authorization': 'Bearer ' + token.token } }

      it 'delete given point' do
        expect(Point.all.size).to eq(39)
      end

      it 'return success response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'delete others points' do
      before { delete "/api/v1/points/#{funny_points.last.id}", headers: { 'Authorization': 'Bearer ' + token.token } }

      it 'return success response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
