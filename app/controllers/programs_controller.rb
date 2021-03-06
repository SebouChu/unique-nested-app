class ProgramsController < ApplicationController
  before_action :set_program, only: %i[ show edit update destroy ]

  def index
    @programs = Program.all
    breadcrumb
  end

  def show
    breadcrumb
  end

  def new
    @program = Program.new
    breadcrumb
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    @program = Program.new(program_params)
    if @program.save
      redirect_to program_url(@program), notice: t('successfully_created_html', model: @program.to_s)
    else
      render :new, status: :unprocessable_entity
      breadcrumb
    end
  end

  def update
    if @program.update(program_params)
      redirect_to program_url(@program), notice: t('successfully_updated_html', model: @program.to_s)
    else
      render :edit, status: :unprocessable_entity
      breadcrumb
      add_breadcrumb t('edit')
    end
  end

  def destroy
    @program.destroy
    redirect_to programs_url, notice: t('successfully_destroyed_html', model: @program.to_s)
  end

  private

  def set_program
    @program = Program.find(params[:id])
  end

  def program_params
    params.require(:program).permit(:title, :description)
  end

  def breadcrumb
    super
    add_breadcrumb Program.model_name.human(count: 2), programs_path
    breadcrumb_for(@program)
  end
end
