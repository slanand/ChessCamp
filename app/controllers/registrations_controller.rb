class RegistrationsController < ApplicationController
  
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def edit
  end

  def index
  	@registrations = Registration.by_student
  end

  def new
  	@registration = Registration.new
  	@registration.camp_id = params[:camp_id] unless params[:camp_id].nil?
    # students eligible to register for a camp must be active and within the rating of the camp's curriculum
  	@students = (Student.active.at_or_above_rating(@registration.camp.curriculum.min_rating).below_rating(@registration.camp.curriculum.max_rating).alphabetical.to_a) - (@registration.camp.students) 	
  end

  def create
  	@registration = Registration.new(registration_params)
  	if @registration.save
  		redirect_to @registration.camp, notice: "You have successfully registered #{@registration.student.proper_name} for #{@registration.camp.curriculum.name}."
  	else
  		render action: 'new'
  	end
  end

  def update
  	if @registration.update(registration_params)
  		redirect_to @registration.camp, notice: "This registration was revised in the system."
  	else
  		render action: 'edit'
  	end
  end

  def show
  end

  def destroy
  	@registration.destroy
  	redirect_to camp_url(@registration.camp), notice: "This registration has been removed from the system."
  end

  private
  def set_registration
  	@registration = Registration.find(params[:id])
  end

  def registration_params
  	params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
  end
end
