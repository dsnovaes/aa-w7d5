class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        # puts @user
        if @user&.save
            login(@user)
            redirect_to user_url(@user)
        else
            flash[:errors] = ["unsuccessful save"]
            redirect_to new_user_url
        end
    end

    def show
        @subs = Sub.where(moderator_id: current_user.id)
        @user = User.find_by(id: params[:id])
    end

    def index
        @users = User.all
    end

    private
    def user_params
        params.require(:user).permit(:username,:password)
    end

end
