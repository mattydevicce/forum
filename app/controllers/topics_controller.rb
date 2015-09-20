class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def muscleup_topic
    @muscleup = MuscleUp.find_by(comment_id: nil, topic_id: params[:id])
    # @muscleup = MuscleUp.find(params[:id])
    @muscleup.total += 1
    @muscleup.save
    # binding.pry
    redirect_to topics_path
  end

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
    @users = User.all
    @categorys = Category.all
    @muscleups = MuscleUp.all
    sort_topics  
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @comment = Comment.new
    @users = User.all
    @muscleups = MuscleUp.all
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    if session[:user_id]
      @topic.user_id = session[:user_id]
    end
    if @topic.valid?
      respond_to do |format|
        if @topic.save
          @muscleup = MuscleUp.new(total: 0, topic_id: @topic.id)
          @muscleup.save
          format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
          format.json { render :show, status: :created, location: @topic }
        else
          format.html { render :new }
          format.json { render json: @topic.errors, status: :unprocessable_entity }
        end
      end
    else
      render :new
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.comments.each do |comment|
      MuscleUp.find_by(topic_id: @topic.id, comment_id: comment.id).destroy
      comment.destroy
    end
    MuscleUp.find_by(topic_id: @topic.id, comment_id: nil).destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :content, :category_id)
    end

    def sort_topics
      @topics = @topics.sort_by { |topic| -topic.comments.count }
    end

end
