class ReadingsController < ApplicationController
  before_filter :access_denied, :unless => :is_owner?

  def index
    @user = User.find(params[:user_id])
    @readings = @user.readings
  end

  def show
    @user = User.find(params[:user_id])
    @reading = @user.readings.find(params[:id])
  end

  def new
    # Retrieve the user this is being created for with params[:post_id]
    # May not always be current_user
    @user = User.find(params[:user_id])

    # Check for over daily limit: Redirects if true
    check_over_daily_readings_limit(@user) and return

    # It's good, we proceed with creation
    @reading = @user.readings.build
  end

  def edit
    @user = User.find(params[:user_id])
    @reading = @user.readings.find(params[:id])
  end

  def create
    # Retrieve the user this is being created for with params[:post_id]
    # May not always be current_user
    @user = User.find(params[:user_id])

    # Check for over daily limit: Redirects if true
    check_over_daily_readings_limit(@user) and return

    @reading = @user.readings.build(reading_params)

    if @reading.save
      redirect_to user_readings_path(@user)
    else
      render 'new'
    end

  end

  def update
    @reading = Reading.find(params[:id])

    if @reading.update(reading_params)
      redirect_to ([@reading.user, @reading])
    else
      render 'edit'
    end

  end

  def destroy
    @reading = Reading.find(params[:id])
    @reading.destroy

    redirect_to user_readings_path
  end

  def check_over_daily_readings_limit(user)
    if error = Reading.over_daily_readings_limit(user)
      redirect_to user_readings_path(user), error
    else
      return false
    end

  end

  private
    def reading_params
      massAssignable = [:title, :blood_sugar]
      params.require(:reading).permit(massAssignable)
    end

end