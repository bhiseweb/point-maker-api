require 'rails_helper'

describe "API::V1::PointsController", :type => :request do

  describe 'get all points' do

    let!(:points) { FactoryBot.create_list(:point, 20) }

    before {get '/api/v1/points'}

    it 'returns all points' do
      expect(JSON.parse(response.body)["data"].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

  end

  describe 'create point' do

    before {post '/api/v1/points', params: { data: { type: 'Point', attributes: { 
        name: 'point1', latitude: '44.23232', longitude: '38.73733'}}}}

    it 'return new point' do
      expect(Point.all.size).to eq(1)
    end

    it 'return success response' do
      expect(response).to have_http_status(:success)
    end

    it 'return create point with values' do
      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq 'point1'
      expect(JSON.parse(response.body)["data"]["attributes"]["latitude"]).to eq 44.23232
      expect(JSON.parse(response.body)["data"]["attributes"]["longitude"]).to eq 38.73733
    end
  end
  
  describe 'get point with id' do
    let!(:points) { FactoryBot.create_list(:point, 5) }

    before { get "/api/v1/points/#{points.last.id}" }

    it 'return point with given id' do
      expect(JSON.parse(response.body)["data"]["id"]).to eq points.last.id.to_s
      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq points.last.name
    end

    it 'return success response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'update point' do
    let!(:points) { FactoryBot.create_list(:point, 5) }

    before {put "/api/v1/points/#{points.last.id}", params: { data: { type: 'Point', attributes: { 
        name: 'update point', latitude: '44.23232', longitude: '38.73733'}}}}

    it 'return updated point' do
      expect(Point.last.name).to eq 'update point'
    end

    it 'return success response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'delete point' do
    let!(:points) { FactoryBot.create_list(:point, 5) }

    before {delete "/api/v1/points/#{points.last.id}"}

    it 'delete given point' do
      expect(Point.all.size).to eq(4)
    end

    it 'return success response' do
      expect(response).to have_http_status(:success)
    end
  end

end
