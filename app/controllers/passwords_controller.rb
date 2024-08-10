class PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_password, except: [:index, :new, :create]

  def index
    @passwords = current_user.passwords
  end

  def show
  end

  def new
    @password = Password.new
  end

  def create
    @password = current_user.passwords.create(password_params)

    if @password.persisted?
      redirect_to @password
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:password).permit(:url, :username, :password)
  end

  def set_password
    @password = current_user.passwords.find(params[:id])
  end
end
