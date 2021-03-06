class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :set_like, only: [:destroy]

  def create
  	if params[:like] && !liked_before
  		@like = Like.new(status_id: params[:like][:status], user_id: current_user.id) 
  	else 
  		@like = Like.new 
  	end 

  	if @like.save 
  		redirect_to(root_path, flash:{notice: "You liked #{@like.status.title}!"})
  	else
  		redirect_to(root_path, flash:{alert: "You liked before!"})
  	end 
  end

  def destroy
	@like.destroy
	flash[:notice] = "You unlike."
  	redirect_to status_path(@like.status) 
  end 

  private 
  def liked_before
  	if params[:like][:user] && params[:like][:status]
  		@user = User.find(params[:like][:user])
  		@status = Status.find(params[:like][:status])
  		@user.likes.find_by(status_id:@status.id).present?
  	end 
  end 

  def set_like
  	@like = Like.find(params[:id])
  end 

end
