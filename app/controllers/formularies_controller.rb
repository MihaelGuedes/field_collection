class FormulariesController < ApplicationController
  before_action :set_formulary, only: %i[show update destroy]

  # GET /formularies
  def index
    @formularies = Formulary.all

    expires_in 1.hour, public: true
    render json: @formularies, include: [:questions]
  end

  # GET /formularies/1
  def show
    expires_in 1.hour, public: true
    render json: @formulary, include: [:questions]
  end

  # POST /formularies
  def create
    @formulary = Formulary.new(formulary_params)

    if @formulary.save
      render json: @formulary, include: [:questions], status: :created, location: @formulary
    else
      render json: @formulary.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /formularies/1
  def update
    if @formulary.update(formulary_params)
      render json: @formulary
    else
      render json: @formulary.errors, status: :unprocessable_entity
    end
  end

  # DELETE /formularies/1
  def destroy
    @formulary.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_formulary
    @formulary = Formulary.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def formulary_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
