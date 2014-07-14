class HomeController < ApplicationController

  def index
  	@upcoming_camps = Camp.upcoming.chronological.paginate(:page => params[:page]).per_page(5)
  	if (current_user != nil) && (current_user.role == "instructor") 
  		@instructor_camps = current_user.instructor.camps.upcoming.chronological.paginate(:page => params[:page]).per_page(5)
    end
    @all_upcoming_camps = Camp.upcoming.all
    @upcoming_registrations = 0
    @all_upcoming_camps.each do |camp|
      @upcoming_registrations += camp.registrations.size
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
    @query = params[:query]
    @instructors = Instructor.search(@query)
    @students = Student.search(@query)
    @total_hits = @students.size + @instructors.size
  end
  
  def home_payment_report 
  	@camp = Camp.find(params[:id])
  	@registrations = @camp.registrations.by_student.paginate(:page => params[:page]).per_page(10)
  end

  def registered_students 
  	@camp = Camp.find(params[:id])
  	@registrations = @camp.registrations.by_student.paginate(:page => params[:page]).per_page(10)
  end

  def past_camp_payments
    @past_camps = Camp.past.chronological.paginate(:page => params[:page]).per_page(5)
  end

end
