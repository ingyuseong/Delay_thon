class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :confirm, :confirm2, :likes]

  before_action :log_impression, :only=> [:show]
 
   def log_impression
      @hit_post = Post.find(params[:id])
      # this assumes you have a current_user method in your authentication system
      @hit_post.impressions.create(ip_address: request.remote_ip)
   end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order("updated_at DESC")
    if Post.all.count >= 3
      puts "하하하하하하ㅏㅎ하하하하하하하하하하하하"
      @viewposts = Post.order("likes DESC")[0..3]
      @likeposts = Post.order("views DESC")[0..3]
      @viewposts.each do |v|
        puts "gkgkgkkgkgkgkgkgkgkgkgkgkgkgkgkgkgkgkg"
        puts v
      end
      @likeposts.each do |l|
        puts "gkgkgkkgkgkgkgkgkgkgkgkgkgkgkgkgkgkgkg"
        puts l
      end
    else
      @viewposts = Post.none
      @likeposts = Post.none
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    newviews = @post.views + 1
    @post.update(views: newviews)
  end

  def confirm
    
  end
  def confirm2
    
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if @post.password != params[:password]
      redirect_to posts_path
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @post.password != params[:password]
      puts @post.password
      puts params[:password]
      redirect_to posts_path
    end

    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def likes
    num_like = @post.likes + 1
    if @post.update(likes: num_like)
      redirect_back fallback_location: { action: "show", id: @post.id }
    end
  end

  def search
    p_search = params[:search]
    p_all = Post.order("updated_at DESC")
    p_id = []
    case p_search[:select]
    when "title"
      p_all.each do |p|
        if p.title.include? p_search[:query]
          p_id.push(p.id)
        end
      end
      @posts = Post.where(id: p_id).order("updated_at DESC")
    when "content"
      p_all.each do |p|
        if p.content.include? p_search[:query]
          p_id.push(p.id)
        end
      end
      @posts = Post.where(id: p_id).order("updated_at DESC")
    else
      @posts = Post.none
    end
    if Post.all.count >= 3
      @viewposts = Post.order("likes DESC")[0..3]
      @likeposts = Post.order("views DESC")[0..3]
    else
      @viewposts = Post.none
      @likeposts = Post.none
    end
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :row, :column, :status, :summary, :password)
    end
end
