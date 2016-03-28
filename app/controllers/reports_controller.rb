class ReportsController < ApplicationController
  before_filter :access_denied, :unless => :is_owner?

  def daily
    @user = User.find(params[:user_id])
    @readings = @user.readings

    # If no dates picked, default to today
    report_end = params[:report_end] ||= Time.now
    @report_end = Time.parse(report_end.to_s)

    @report = @readings.daily_range(@report_end)
  end

  def monthly
    @user = User.find(params[:user_id])
    @readings = @user.readings

    # If no dates picked, default to today
    report_end = params[:report_end] ||= Time.now
    @report_end = Time.parse(report_end.to_s)

    @report = @readings.monthly_range(@report_end)
  end

  def monthToDate
    @user = User.find(params[:user_id])
    @readings = @user.readings

    # If no dates picked, default to today
    report_start = params[:report_start] ||= Time.now
    report_end = params[:report_end] ||= Time.now

    @report_start = Time.parse(report_start.to_s)
    @report_end = Time.parse(report_end.to_s)

    @report = @readings.monthlyToDate_range(@report_start, @report_end)
  end

end