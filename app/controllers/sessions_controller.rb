class SessionsController < ApplicationController

    before_action :require_logged_in, only: [:destroy]

    def new
        # login form
        render :new
    end

    def create
        # login user
        user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        if user
            login(user)
            redirect_to user_url(user)
        else
            @temp_username = params[:user][:username]
            flash.now[:errors] = ["Invalid credentials"]
            render :new
        end
    end

    def destroy
        # logout user
        logout
        redirect_to new_session_url
    end

end
