class PostsController < ApplicationController
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy], except: [:index]

    def index
        @topic = Topic.includes(:posts).find_by(id: params[:topic_id])
        @posts = @topic.posts.order('created_at DESC')
    end

    def new
        @topic = Topic.find_by(id: params[:topic_id])
        @post = Post.new
    end

    def create
        @topic = Topic.find_by(id: params[:topic_id])
        @post = current_user.posts.build(post_params.merge(topic_id: params[:topic_id]))


        if @post.save
            redirect_to topic_posts_path
        else
            redirect_to new_topic_post_path
        end
  end

    def edit
        @post = Post.find_by(id: params[:id])
        @topic = @post.topic
        authorize @post
    end

    def update
        @topic = Topic.find_by(id: params[:topic_id])
        @post = Post.find_by(id: params[:id])
        authorize @post

        if @post.update(post_params)
            redirect_to topic_posts_path(@topic)
        else
            redirect_to edit_topic_post_path(@topic, @post)
        end
    end

    def destroy
        @post = Post.find_by(id: params[:id])
        @topic = @post.topic
        authorize @post

        redirect_to topic_posts_path(@topic) if @post.destroy
    end

    private

    def post_params
        params.require(:post).permit(:title, :body, :image)
    end
end
