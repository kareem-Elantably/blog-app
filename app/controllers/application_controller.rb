class ApplicationController < ActionController::API
    before_action :authenticate_request
  
    private
  
    def authenticate_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JWT.decode(header, Rails.application.secret_key_base)[0]
        @current_user = User.find(@decoded['id'])
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render json: { error: 'Unauthorized1' }, status: :unauthorized
      end
      begin
        decoded = JWT.decode(header, Rails.application.secret_key_base, true, { algorithm: 'HS256', exp_leeway: 30 })
        @current_user = User.find(decoded[0]['id'])
      rescue JWT::ExpiredSignature
        render json: { error: 'Token has expired' }, status: :unauthorized
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render json: { error: 'Unauthorized2' }, status: :unauthorized
      end
    end
  end
  