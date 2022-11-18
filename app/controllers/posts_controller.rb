class PostsController < ApplicationController
    before_action :is_author?, only: [:edit, :update]

    def show
    end


    def new
        @subs = Sub.all
        #you want the view to be able to access the subs so that they can use the checkbox
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id
        # @post.sub_id = params[:sub_id]
        puts "----"
        puts params
        puts "---"
        puts @post.sub_id
        if @post&.save
            redirect_to post_url(@post)
        else
            flash.now[:errors] = ["can't create nil"] # won't work => @post.errors.full_messages
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
            flash.now[:errors] = ["can't update nil"] # won't work => @post.errors.full_messages
            render :edit
        end
    end

    private
    def is_author?
        post = Post.find_by(id: params[:id])
        current_user.id == post.author_id
    end

    def post_params
        params.require(:post).permit(:title, :url, :content, :sub_id)
    end
end
