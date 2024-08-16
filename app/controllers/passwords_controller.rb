class PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_password, except: [:index, :new, :create]
  before_action :require_editor_permissions, only: [:edit, :update]
  before_action :require_owner_permissions, only: [:destroy]

  def index
    @passwords = current_user.passwords
  end

  def show
  end

  def new
    @password = Password.new
  end

  def create
    @password = Password.new(password_params)
    @password.user_passwords.new(user: current_user, role: :owner)

    if @password.save
      redirect_to @password
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @password.update(password_params)
      redirect_to @password
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @password.destroy
    redirect_to root_path
  end

  private

  def password_params
    params.require(:password).permit(:url, :username, :password)
  end

  def set_password
    @password = current_user.passwords.find(params[:id])
  end

  def require_editor_permissions
    redirect_to @password unless @password.editable_by?(current_user)
  end

  def require_owner_permissions
    redirect_to @password unless @password.deletable_by?(current_user)
  end
end
