class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show update destroy]

  # GET /answers
  def index
    @answers = Answer.all

    expires_in 1.hour, public: true
    render json: @answers
  end

  # GET /answers/1
  def show
    expires_in 1.hour, public: true
    render json: @answer
  end

  # POST /answers
  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      render json: @answer, status: :created, location: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    if params[:question_id]
      @answer = Question.find(params[:question_id]).answer
      return @answer
    end
    @answer = Answer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def answer_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
