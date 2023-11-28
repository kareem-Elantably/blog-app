class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comment, only: [:update, :destroy]
    before_action :check_comment_authorization, only: [:update, :destroy]
  
    # POST /posts/:post_id/comments
    def create
      @comment = @post.comments.build(comment_params.merge(user: current_user))
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /posts/:post_id/comments/:id
    def update
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /posts/:post_id/comments/:id
    def destroy
      @comment.destroy
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_comment
      @comment = @post.comments.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  
    def check_comment_authorization
      render json: { error: 'Not Authorized' }, status: :unauthorized unless @comment.user == current_user
    end
  end
  