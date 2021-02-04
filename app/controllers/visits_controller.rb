class VisitsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_user, only: [:create]
  before_action :set_visit, except: %i[index create]

  # GET /visits
  def index
    @visits = Visit.all

    expires_in 1.hour, public: true
    render json: @visits
  end

  # GET /visits/1
  def show
    expires_in 1.hour, public: true
    render json: @visit
  end

  # POST /visits
  def create
    @visit = Visit.new(visit_params)

    if @visit.date >= Date.today
      if @visit.save
        render json: @visit, status: :created, location: @visit
      else
        render json: @visit.errors, status: :unprocessable_entity
      end
    else
      render json: { date: 'Por favor, agende uma data mais avançada.' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /visits/1
  def update
    if @visit.update(visit_params)
      render json: @visit
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end

  # GET /checkin/1
  def checkin_at
    Time.zone = 'America/Sao_Paulo'
    if @visit.checkin_at.nil?
      if Time.now.to_time >= @visit.date.to_time
        @visit.checkin_at = Time.current
        @visit.save
        render json: @visit
      else
        render json: { checkin: "Desculpe essa visita está agendada para o dia #{@visit.date}." }, status: :forbidden
      end
    else
      if !@visit.checkout_at.nil?
        render json: { checkin: 'Essa visita já foi finalizada.' }, status: :forbidden
      else
        render json: { checkin: 'Essa visita já foi iniciada.' }, status: :forbidden
      end
    end
  end

  # GET /checkout/1
  def checkout_at
    Time.zone = 'America/Sao_Paulo'
    if !@visit.checkin_at.nil?
      if @visit.checkout_at.nil?
        if Time.current.to_time > @visit.checkin_at.to_time
          @visit.checkout_at = Time.current
          @visit.save
          render json: @visit
        else
          render json: {checkout: 'Essa visita ainda não foi realizada.'}, status: :forbidden
        end
      else
        render json: {checkout: 'Essa visita já foi finalizada.'}, status: :forbidden
      end
    else
      render json: {checkout: 'Essa visita ainda não foi realizada.'}, status: :forbidden
    end
  end

  # DELETE /visits/1
  def destroy
    @visit.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_visit
    # @visit = Visit.find(params[:user_id])
    if params[:user_id]
      @visit = User.find(params[:user_id]).visits
      return @visit
    end
    @visit = Visit.find(params[:id])
  end

  # Only allow a trusted parameter 'white list' through.
  def visit_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end

  def authenticate_user
    # Getting user_id for validation with JWT
    hmac_secret = 'my$ecretK3y'
    @user = User.find(ActiveModelSerializers::Deserialization.jsonapi_parse(params)[:user_id])
    payload = { email: @user.email, password: @user.password }
    token = JWT.encode payload, hmac_secret, 'HS256'

    # Authenticating user_id
    JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
  end
end
