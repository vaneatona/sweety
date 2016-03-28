module ReadingsHelper

  def new_report_link(user)
    unless Reading.over_daily_readings_limit(user)
      link_to new_icon + 'New Reading', new_user_reading_path, title: 'Enter a new reading'
    else
      %{<span title="Over Daily Limit.">#{new_icon} New Reading</span>}.html_safe
    end
  end
end
