class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show update destroy]

  # GET /questions
  def index
    @questions = Question.all

    expires_in 1.hour, public: true
    render json: @questions, include: [:answer]
  end

  # GET /questions/1
  def show
    expires_in 1.hour, public: true
    render json: @question, include: [:answer]
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, include: [:answer], status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    if params[:formulary_id]
      @question = Formulary.find(params[:formulary_id]).questions
      return @question
    end
    @question = Question.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def question_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
