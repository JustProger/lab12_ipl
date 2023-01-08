# frozen_string_literal: true

class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[login create]

  def login; end

  def create
    user = User.find_by(username: params[:login])

    if user&.authenticate(params[:password])
      sign_in user
      redirect_to calcs_path # calcs#index
    else
      # flash.now[:danger] = 'Неверный логин или пароль'
      redirect_to root_path, notice: 'Неверный логин или пароль'
    end
  end

  def logout
    sign_out
    redirect_to root_path
  end
end
