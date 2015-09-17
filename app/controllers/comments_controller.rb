class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to topics_path
    else
      render topics_path #I think I need topic_path(:id) where :id should be :topic_id but it aint working
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :topic_id, :user_id)
    end
end