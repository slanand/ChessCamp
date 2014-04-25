class StudentsController < ApplicationController
  def edit
  end

  def index
  	@active_students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  	@inactive_students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def new
  	@student = Student.new
  end

  def show
  	@student_camps = Student.camps.chronological.to_a
  end

  def create
  	@student = Student.new(student_params)
  	if @student.save
  		redirect_to @student, notice: "The student #{@student.proper_name} was added to the system."
  	else
  		render action: 'new'
  	end
  end

  def update
  	if @student.update(student_params)
  		redirect to @studnet, notice: "The student #{@student.proper_name} was revised in the system."
  	else
  		render action: 'edit'
  	end
  end

  def destroy
  	@student.destroy
  	redirect_to students_url, notice: "#{@student.proper_name} was removed from the system."
  end

  private
  	def set_student
  		@student = Student.find(params[:id])
  	end

  	def student_params
  		params.require(:student).permit(:family_id, :first_name, :last_name, :date_of_birth, :rating, :active)
  	end
  	
end
