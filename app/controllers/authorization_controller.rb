class AuthorizationController < ApplicationController
    def create
      hmac_secret = 'my$ecretK3y'
      payload = { email: params[:email], password: params[:password] }
      token = JWT.encode payload, hmac_secret, 'HS256'
      render json: { token: token }
    end
end
