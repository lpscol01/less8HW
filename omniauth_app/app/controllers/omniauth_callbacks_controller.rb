class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def github
		puts request.env["omniauth.auth"]
		@user = User.find_for_github_oauth(request.env["omniauth.auth"])

		if @user.persisted?
			sign_in_and_redirect @user, :event => :authentication
			set_flash_message(:notice, :succes, :kind => "Github") if is_navigational_format?
		else
			session["devise.user_attributes"] = @user.attributes
			redirect_to new_user_registration_url
		end
	end
end
