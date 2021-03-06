class CountriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_country, only: [:show , :update, :destroy]
  respond_to :json

  def index
    @countries = Country.order(:id)
    render json: @countries
  end

  def show
    render json: @country
  end

  def create
    @country = Country.new(country_params)
    if @country.save
      render json: @country, status: :created
    else
      head :unprocessable_entity
    end
  end

  def update
    if @country.update(country_params)
      render json: @country, status: :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @country.destroy
    head :no_content
  end

  private

    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.permit(:id, :title)
    end
end
