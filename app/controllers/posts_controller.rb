class PostsController < ApplicationController
    before_action :is_author?, only: [:edit, :update]

    def show
    end

    
    def new
    end

    def create
        @post = Post.new(post_params)
        if @post&.save
            redirect_to post_url(@post)
        else
            flash[:errors] = ["can't create nil"] # won't work => @post.errors.full_messages
            render :new
        end
    end
    
    def edit
        @post = Post.find_by(id: params[:id])
    end
    
    def update
        @post = Post.find_by(id: params[:id])
        if @post&.update(post_params)
            redirect_to posts_url
        else
            flash[:errors] = ["can't update nil"] # won't work => @post.errors.full_messages
            render :edit
        end
    end

    private
    def is_author? 
        post = Post.find_by(id: params[:id])
        current_user.id == post.author_id
    end

    def post_params
        params.require(:post).permit(:title, :url, :content)
    end
end