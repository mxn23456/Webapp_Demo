class SessionsController < Devise::SessionsController

  # POST /resource/sign_in
  # Resets the authentication token each time! Won't allow you to login on two devices
  # at the same time (so does logout).
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    current_user.update authentication_token: nil

    respond_to do |format|
      format.json {
        render :json => {
        :user => current_user,
        :status => :ok,
        :authentication_token => current_user.authentication_token
      }
      }
      format.html{ redirect_to root_path}
    end
  end

  # DELETE /resource/sign_out
  def destroy

    if current_user
      current_user.update authentication_token: nil
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      respond_to do |format|
        format.json {
          render :json => {}.to_json, :status => :ok
        }
        format.html {
          redirect_to root_path
        }
      end
    else
      respond_to do |format|
        format.json {
          render :json => {}.to_json, :status => :ok
        }
        format.json { redirect_to root_path }
      end
    end
  end
end
