class SubsController < ApplicationController

    before_action :is_moderator?, only: [:edit,:update]

    def new
    end

    def show
        @posts = Sub.find_by(id: params[:id]).posts
    end

    def create
        @sub = Sub.new(sub_params)
        if @sub&.save
            redirect_to sub_url(@sub)
        else
            flash[:errors] = ["can't create nil"] # won't work => @sub.errors.full_messages
            render :new
        end
    end

    def edit
        @sub = Sub.find_by(id: params[:id])
    end

    def update
        @sub = Sub.find_by(id: params[:id])
        if @sub&.update(sub_params)
            redirect_to subs_url
        else
            flash[:errors] = ["can't update nil"] # won't work => @sub.errors.full_messages
            render :edit
        end
    end

    private

    def is_moderator?
        sub = Sub.find_by(id: params[:id])
        current_user.id == sub.moderator_id
    end

    def sub_params
        params.require(:sub).permit(:title,:description)
    end

end