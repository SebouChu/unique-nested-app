class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]

  def index
    @people = Person.all
    breadcrumb
  end

  def show
    breadcrumb
  end

  def new
    @person = Person.new
    breadcrumb
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to person_url(@person), notice: t('successfully_created_html', model: @person.to_s)
    else
      render :new, status: :unprocessable_entity
      breadcrumb
    end
  end

  def update
    if @person.update(person_params)
      redirect_to person_url(@person), notice: t('successfully_updated_html', model: @person.to_s)
    else
      render :edit, status: :unprocessable_entity
      breadcrumb
      add_breadcrumb t('edit')
    end
  end

  def destroy
    @person.destroy
    redirect_to people_url, notice: t('successfully_destroyed_html', model: @person.to_s)
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :biography)
  end

  def breadcrumb
    super
    add_breadcrumb Person.model_name.human(count: 2), people_path
    breadcrumb_for(@person)
  end
end
