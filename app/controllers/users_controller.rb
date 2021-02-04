class UsersController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate, only: %i[show delete]
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all

    expires_in 1.hour, public: true
    render json: @users, include: [:visits], status: :ok
  end

  # GET /users/1
  def show
    expires_in 1.hour, public: true
    render json: @user, include: [:visits], status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, include: [:visits], status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    # params.require(:user).permit(:name, :password, :email, :cpf)
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      hmac_secret = 'my$ecretK3y'
      JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
    end
  end
end
