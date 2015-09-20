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
      redirect_to topic_path(@comment.topic_id)
    else
      redirect_to login_path
    end
  end

  def destroy
    @muscleup.comment.destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :topic_id, :user_id)
    end
end