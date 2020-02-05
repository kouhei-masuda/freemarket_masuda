# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def select  ##登録方法の選択ページ
    redirect_to root_path, alert: "ログインしています。" if user_signed_in?
    @auth_text = "で登録する"
    session.delete(:"devise.sns_auth") if session["devise.sns_auth"]
  end

  def new 
    super
  end

  def create
    build_resource(sign_up_params)
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist?data"][:encrypted_password] = nil
    session["devise/regist_data"][:user][:password] = params[:user][:password]
    redirect_to confirm_phone_path
  end
  
  def confirm_phone ## userのcreateに成功したらここに来る
    @progress = 2
  end

  def new_address ## 電話番号認証ページのボタンを押したらここに来る
    ## address登録済の時はリダイレクト
    redirect_to new_regist_payment_path if session["devise.regist_data"][:address] || current_user&.address
    @progress = 3
    @address = Address.new
  end

  def create_address
    @address = Address.new(address_params)
    if @address.save
      redirect_to new_regist_payment_path
    else
      redirect_to new_regist_address_path, alert: @address.errors.full_messages
    end
  end

  def new_payment ## addressのcreateに成功したらここに来る
    ## card登録済の時はリダイレクト
    redirect_to regist_completed_path and return if current_user.card
    @progress = 4
    @card = Card.new
    render template: "cards/new"
  end

  def completed ## cardのcreateに成功したらここに来る
    @progress = 5
  end
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end
  
  def after_sign_up_path_for(resource)
    ## 電話番号認証ページのパスを指定
    confirm_phone_path
  end
  # The path used after sign up for inactive account

  private

  def sign_up_params
    params.require(:user).permit(:nickname, :avatar, :introduction, :first_name, :first_name_reading, :last_name, :last_name_reading, :birthday)
  end
end
