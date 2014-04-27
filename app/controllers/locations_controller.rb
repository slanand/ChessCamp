class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def index
  	@active_locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  	@inactive_locations = Location.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def new
  	@location = Location.new
  end

  def show
  end

  def update
  	if @location.update(location_params)
  		redirect to @location, notice: "The family #{@location.name} was revised in the system."
  	else
  		render action: 'edit'
  	end
  end

  def destroy
  	@location.destroy
  	redirect_to locations_url, notice: "#{@location.name} was removed from the system."
  end

  private
	def set_location
	  @location = Location.find(params[:id])
	end
	
	def location_params
		params.require(:location).permit(:name, :street_1, :street_2, :city, :state, :zip, :max_capacity, :latitude, :longitude, :active)
	end
end
