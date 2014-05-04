class HomeController < ApplicationController

  def index
  	@upcoming_camps = Camp.upcoming.chronological.paginate(:page => params[:page]).per_page(5)
  	if (current_user != nil) && (current_user.role == "instructor") 
  		@instructor_camps = current_user.instructor.camps.upcoming.chronological.paginate(:page => params[:page]).per_page(5)
	end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
  def home_payment_report 
  	@camp = Camp.find(params[:id])
  	@registrations = @camp.registrations.by_student.paginate(:page => params[:page]).per_page(10)
  end

  def registered_students 
  	@camp = Camp.find(params[:id])
  	@registrations = @camp.registrations.by_student.paginate(:page => params[:page]).per_page(10)
  end


end
