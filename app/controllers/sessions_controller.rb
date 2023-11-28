class SessionsController < Devise::SessionsController
    skip_before_action :authenticate_request, only: [:create]

    def create
      user = User.find_by_email(params[:user][:email])
      if user && user.valid_password?(params[:user][:password])
        render json: { token: user.generate_jwt }
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
  