class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :check_authorization, only: [:update, :destroy]
  
    # GET /posts
    def index
      @posts = Post.all
      render json: @posts
    end
  
    # GET /posts/:id
    def show
      render json: @post
    end
  
    # POST /posts
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /posts/:id
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /posts/:id
    def destroy
      @post.destroy
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :body, :tags)
    end
  
    def check_authorization
      render json: { error: 'Not Authorized' }, status: :unauthorized unless @post.user == current_user
    end
  end
  