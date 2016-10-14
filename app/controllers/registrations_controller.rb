class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.create(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'User was successfully created.' }
        format.json { render :json => {:state => {:code => 0}, :data => @user } }
      else
        render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} }
      end
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
