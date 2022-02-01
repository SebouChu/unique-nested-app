class RolesController < ApplicationController
  before_action :set_role, only: %i[ show edit update destroy ]

  def index
    @roles = Role.all
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to role_url(@role), notice: t('successfully_created_html', model: @role.to_s)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @role.update(role_params)
      redirect_to role_url(@role), notice: t('successfully_updated_html', model: @role.to_s)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_url, notice: t('successfully_destroyed_html', model: @role.to_s)
  end

  private

  def set_role
    @role = Role.where(target_id: nil).find(params[:id])
  end

  def role_params
    params.require(:role).permit(:description)
  end
end
