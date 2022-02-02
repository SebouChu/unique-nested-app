class RolesController < ApplicationController
  include Sortable

  before_action :set_role, only: %i[ show edit update destroy ]

  def index
    @roles = Role.all.ordered
    breadcrumb
  end

  def show
    @involvements = @role.involvements.ordered
    breadcrumb
  end

  def new
    @role = Role.new
    breadcrumb
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to role_url(@role), notice: t('successfully_created_html', model: @role.to_s)
    else
      render :new, status: :unprocessable_entity
      breadcrumb
    end
  end

  def update
    if @role.update(role_params)
      redirect_to role_url(@role), notice: t('successfully_updated_html', model: @role.to_s)
    else
      render :edit, status: :unprocessable_entity
      breadcrumb
      add_breadcrumb t('edit')
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
    params.require(:role).permit(:description, involvements_attributes: [:id, :person_id, :position, :_destroy])
  end

  def breadcrumb
    super
    add_breadcrumb Role.model_name.human(count: 2), roles_path
    breadcrumb_for(@role)
  end
end
