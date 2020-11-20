# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  # Define WorkOS API key from environment variables
  WorkOS.key = Figaro.env.workos_api_key

  # GET /sso/new path to authenticate via WorkOS
  def auth
    authorization_url = WorkOS::SSO.authorization_url(
      domain: params[:domain],
      project_id: Figaro.env.workos_project_id,
      redirect_uri: 'http://localhost:3000/sso/callback',
    )

    redirect_to authorization_url
  end

  # GET /sso/callback path to consume profile object from WorkOS
  def callback
    profile = WorkOS::SSO.profile(
      code: params['code'],
      project_id: Figaro.env.workos_project_id,
    )

    @user = User.from_sso(profile)

    sign_in_and_redirect @user
  end

  # send user to root path after authenticating
  def after_sign_in_path_for(_resource)
    root_path
  end
end
