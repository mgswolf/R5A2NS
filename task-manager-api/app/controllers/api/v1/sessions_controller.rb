class Api::V1::SessionsController < Api::V1::BaseController

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.valid_password?(user_params[:password])
      sign_in user, store: false
      user.generate_auth_token!
      user.save
      render json: user, status: 200
    else
      render json: { errors: 'Invalid password or email' }, status: 401
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_auth_token!
    user.save
    head 204
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end
end
