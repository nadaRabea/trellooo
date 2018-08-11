class V1::ListsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_list, only: [:show, :update, :destroy, :assign_member, :unassign_member]
  before_action :set_user, only: [:assign_member, :unassign_member]

  def index
    # @lists = List.accessible_by(current_ability)
    if current_user.admin?
      @lists = List.all
    else
      @lists = List.find_user_lists(current_user.id)
    end
  end

  def show
  end

  def create
    @list = current_user.created_lists.create(list_params)
    current_user.lists << @list

    if @list.save
      render :show, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      render :show, status: :ok, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
  end

  def assign_member
    @list.users << @user
  end

  def unassign_member
    @list.users.delete(@user)
  end


  private
  
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:title)
    end

    def set_user
      @user = User.find(params[:user_id])
    end
end
