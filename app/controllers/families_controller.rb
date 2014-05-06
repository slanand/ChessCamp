class FamiliesController < ApplicationController
  
  before_action :set_family, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  def edit
  end

  def index
  	@active_families = Family.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  	@inactive_families = Family.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def new
  	@family = Family.new
    @family.students.build
  end

  def show
  	@students_of_family = @family.students.alphabetical.to_a
  end

  def create
  	@family = Family.new(family_params)
  	if @family.save
  		redirect_to @family, notice: "The #{@family.family_name} family was added to the system."
  	else
  		render action: 'new'
  	end
  end

  def update
  	if @family.update(family_params)
  		redirect_to @family, notice: "The #{@family.family_name} family was revised in the system."
  	else
  		render action: 'edit'
  	end
  end

  def destroy
  	@family.destroy
  	redirect_to families_url, notice: "#{@family.family_name} family was removed from the system."
  end

  def family_payment_students
    # gets all years camps were given for the family payments by year page
    @family = Family.find(params[:id])
    @fam_registrations = @family.registrations.by_student.paginate(:page => params[:page]).per_page(10)
  end

  private
	def set_family
	  @family = Family.find(params[:id])
	end

	def family_params
		params.require(:family).permit(:family_name, :parent_first_name, :email, :phone, :active, student_attributes:[:id, :first_name, :last_name, :family_id, :date_of_birth, :rating, :active])
	end

end
