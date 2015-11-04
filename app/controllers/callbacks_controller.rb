class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        @user.email = "skinxbonesmia@gmail.com"
        sign_in_and_redirect @user
    end
end
