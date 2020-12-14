class PostsController < ApplicationController
  def index
    @post = Post.page(params[:page]).per(6)
    @post_side = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(4).pluck(:post_id))
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "complete"
      redirect_to posts_path
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts.build
    @post  = @tag.posts.page(params[:page])
  end


  private

  def post_params
    params.require(:post).permit(:user_id, :text, :image, :hashtag_id)
  end
end
