class Roles::PeopleController < ApplicationController
  before_action :set_role
  before_action :set_involvement, only: %i[ show edit update destroy ]

  def index
    @involvements = @role.involvements.all
    breadcrumb
  end

  def show
    breadcrumb
  end

  def new
    @involvement = @role.involvements.new
    breadcrumb
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    @involvement = @role.involvements.new(involvement_params)
    if @involvement.save
      redirect_to role_person_url(@role, @involvement), notice: t('successfully_created_html', model: @involvement.to_s)
    else
      render :new, status: :unprocessable_entity
      breadcrumb
    end
  end

  def update
    if @involvement.update(involvement_params)
      redirect_to role_person_url(@role, @involvement), notice: t('successfully_updated_html', model: @involvement.to_s)
    else
      render :edit, status: :unprocessable_entity
      breadcrumb
      add_breadcrumb t('edit')
    end
  end

  def destroy
    @involvement.destroy
    redirect_to role_people_url(@role), notice: t('successfully_destroyed_html', model: @involvement.to_s)
  end

  private

  def set_role
    @role = Role.targetless.find(params[:role_id])
  end

  def set_involvement
    @involvement = @role.involvements.find(params[:id])
  end

  def involvement_params
    params.require(:involvement).permit(:person_id, :position).merge({ target: @role })
  end

  def breadcrumb
    super
    add_breadcrumb Role.model_name.human(count: 2), roles_path
    breadcrumb_for(@role)
    add_breadcrumb Involvement.model_name.human(count: 2), role_people_path(@role)
    breadcrumb_for(@involvement, record_path: :role_person_path, record_path_params: [@role, @involvement])
  end
end
