class Api::V1::PostsController < ApplicationController
  before_action :authenticate, except: [:index, :show]

  def index
    posts = Post.all
    render json: posts, status: :ok
  end

  def show
    post = Post.find_by(id: params[:id])

    if post
      render json: post, status: :ok
    else
      render json: { error: 'Post is not found' }, status: :not_found
    end
  end

  def create
    post = Post.new
    post.author = post_params[:author]
    post.title = post_params[:title]
    post.body = post_params[:body]

    history = History.new
    history.type = 'post created'
    history.user = @user

    # wait both transactions is not failed
    result = ActiveRecord::Base.transaction do
      post.save!
      history.save!
    end

    # send to all users notification
    NotificationMailer.new_post_notification(post)


    if result
      render json: post, status: :created
    else
      render json: { error: 'Error creating post' }, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.permit([
      :title,
      :author,
      :body
    ])
  end


end
