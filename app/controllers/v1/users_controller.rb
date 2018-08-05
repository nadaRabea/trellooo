class V1::UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    render 'v1/users/index'
  end
end
