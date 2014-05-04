class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
      user ||= User.new # guest user (not logged in)
      if user.role? :admin
        can :manage, :all
      elsif user.role? :instructor
        # they can update their own profile
        can :edit, Instructor do |i|  
          i.id == user.instructor_id
        end
        can :update, Instructor do |i|  
          i.id == user.instructor_id
        end
        can :update, User do |u|  
          u.id == user.id
        end
        can :edit, User do |u|  
          u.id == user.id
        end
        # can view other instructors' profiles
        can :show, Instructor
        # can see curriculums and curriculum information
        can :show, Curriculum
        can :index, Curriculum
        # they can read their own camps' info
        can :read, Camp do |this_camp|
          camps = user.instructor.camps.map(&:id)
          camps.include? this_camp.id
        end
        # can only see students in their camps
        can :read, Student do |this_student|  
          student_camps = user.instructor.camps.map{|c| c.students.map(&:id)}.flatten
          student_camps.include? this_student.id 
        end
        # instructors can see a list of all:
        can :index, Instructor
        can :index, Student
        can :index, Camp
        can :index, Location
        can :index, Curriculum
        can :index, User
        # can view other camps and locations
        can :show, Camp
        can :show, Location
      else 
        # guests can 
        can :show, Instructor
        can :index, Instructor
        can :index, Curriculum
        can :show, Curriculum
        can :index, Camp
        can :show, Camp
        can :show, Location
        can :index, Location
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
