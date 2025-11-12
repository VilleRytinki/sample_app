class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      # handle successful save.
    else
      render "new", status: unprosessable_entity
    end
  end
end
