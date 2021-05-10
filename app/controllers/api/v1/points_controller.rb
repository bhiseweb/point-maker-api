class Api::V1::PointsController < ApplicationController

  before_action :find_point, only: [:show, :update, :destroy]

  def index
    points = Point.all
    render json: points, status: :ok
  end

  def create
    point = Point.new(point_params)
    if point.save
      render json: point, status: :ok
    else
      render json: {errors: { message: 'Unable to create record please try again later' }}, status: :unprocessable_entity
    end
  end

  def show
    render json: @point, status: :ok
  end

  def update
    if @point.update(point_params)
      render json: @point, status: :ok
    else
      render json: {errors: { message: 'Unable to update record please try again later' }}, status: :unprocessable_entity
    end
  end

  def destroy
    if @point.destroy
      render json: @point, status: :ok
    else
      render json: {errors: { message: 'Unable to delete record please try again later' }}, status: :unprocessable_entity
    end
  end

  private

    def point_params
      ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:name, :latitude, :longitude])
    end

    def find_point
      @point = Point.find_by id: params[:id]
      render json: {errors: { message: 'Not Found' }}, status: :not_found and return unless @point
    end

end