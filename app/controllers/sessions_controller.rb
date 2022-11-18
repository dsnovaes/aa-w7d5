class SessionsController < ApplicationController

    before_action :required_logged_in, only: [:destroy]

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
            redirect_to users_url
        else
            @temp_username = params[:user][:username]
            flash[:errors] = ["Invalid credentials"]
            redirect_to new_session_url
        end
    end

    def destroy
        # logout user
        logout
        redirect_to new_session_url
    end

end