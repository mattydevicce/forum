class CommentsController < ApplicationController

  def muscleup_comment
    @comment = Comment.find(params[:id])
    @muscleup = MuscleUp.find_by(comment_id: params[:id], topic_id: @comment.topic_id)
    @muscleup.total += 1
    @muscleup.save
    redirect_to topic_path(@muscleup.topic_id)
  end


  def index
    @comments = Comment.all
    @muscleups = MuscleUp.all
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      @muscleup = MuscleUp.new(total: 0, comment_id: @comment.id, topic_id: @comment.topic_id)
      @muscleup.save
      redirect_to topics_path
    else
      redirect_to topics_path #I think I need topic_path(:id) where :id should be :topic_id but it aint working
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :topic_id, :user_id)
    end
end