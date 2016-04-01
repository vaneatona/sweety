class Reading < ActiveRecord::Base
  belongs_to :user

  validates :title,
      presence: true,
      length: { minimum: 3 }
  validates :blood_sugar,
      presence: true,
      numericality: { only_integer: true, less_than_or_equal_to: 9, greater_than_or_equal_to: 0 }

  MAX_READINGS = 4
  ERROR_MESSAGE = "Maximum of #{MAX_READINGS} blood glucose readings per day."

  def self.over_daily_readings_limit(user)
    if user.readings.daily_range(Time.now).count >= MAX_READINGS
      return :flash => { :error => ERROR_MESSAGE }
    end
  end

  def self.glucose_max
    self.maximum(:blood_sugar)
  end

  def self.glucose_min
    self.minimum(:blood_sugar)
  end

  def self.glucose_avg
    (self.sum(:blood_sugar).to_f / self.count.to_f).round(2)
  end

  def self.oldest_report
    (self.minimum(:created_at)).strftime('%d/%m/%Y')
  end

  def self.newest_report
    (self.maximum(:created_at)).strftime('%d/%m/%Y')
  end

  def self.daily_range(date)
    return (self.where(:created_at => (self.date_range(date, date, 'daily'))))
  end

  def self.monthly_range(date)
    return (self.where(:created_at => (self.date_range(date, date, 'monthly'))))
  end

  def self.monthlyToDate_range(start_date, end_date)
    return (self.where(:created_at => (self.date_range(start_date, end_date, 'monthToDate'))))
  end

  private
    def self.date_range(start_date, end_date, type)
      if type == 'daily'
        (start_date.beginning_of_day..end_date.end_of_day)
      elsif type == 'monthly'
        (start_date.beginning_of_month..end_date.end_of_month)
      else type == 'monthToDate'
        (start_date.beginning_of_day..end_date.end_of_day)
      end
    end

end