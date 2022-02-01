class Roles::PeopleController < ApplicationController
  before_action :set_role
  before_action :set_involvement, only: %i[ show edit update destroy ]

  # GET /roles/1/people or /roles/1/people.json
  def index
    @involvements = @role.involvements.all
  end

  # GET /roles/1/people/1 or /roles/1/people/1.json
  def show
  end

  # GET /roles/1/people/new
  def new
    @involvement = @role.involvements.new
  end

  # GET /roles/1/people/1/edit
  def edit
  end

  # POST /roles/1/people or /roles/1/people.json
  def create
    @involvement = @role.involvements.new(involvement_params)

    respond_to do |format|
      if @involvement.save
        format.html { redirect_to role_person_url(@role, @involvement), notice: t('successfully_created_html', model: @involvement.to_s) }
        format.json { render :show, status: :created, location: role_person_url(@role, @involvement) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @involvement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1/people/1 or /roles/1/people/1.json
  def update
    respond_to do |format|
      if @involvement.update(involvement_params)
        format.html { redirect_to role_person_url(@role, @involvement), notice: t('successfully_updated_html', model: @involvement.to_s) }
        format.json { render :show, status: :ok, location: role_person_url(@role, @involvement) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @involvement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1/people/1 or /roles/1/people/1.json
  def destroy
    @involvement.destroy

    respond_to do |format|
      format.html { redirect_to role_people_url(@role), notice: t('successfully_destroyed_html', model: @involvement.to_s) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.where(target_id: nil).find(params[:role_id])
    end

    def set_involvement
      @involvement = @role.involvements.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def involvement_params
      params.require(:involvement).permit(:person_id, :position).merge({
        target: @role,
        kind: :administrator
      })
    end
end
