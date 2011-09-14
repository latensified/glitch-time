#
# Converts real time to Glitch Time
# In the world of Glitch a game day is four real hours long.
#
# There are 308 days in a glitch year.
# There are 24 hours in a day.
# There are 60 minutes in an hour.
# There are 4435200 real seconds in a game year.
# There are 14400 real seconds in a game day.
# There are 600 real seconds in a game hour.
# There are 10 real seconds in a game minute.
#
# The Glitch epoch began at 1238562000 Unix time.

class GlitchTime
  GAME_EPOCH = 1238562000
  DAYS_IN_YEAR = 308
  HOURS_IN_HALF_DAY = 12
  SECONDS_IN_GAME_YEAR = 4435200
  SECONDS_IN_GAME_DAY = 14400
  SECONDS_IN_GAME_HOUR = 600
  SECONDS_IN_GAME_MINUTE = 10
  MONTHS = ['Primuary',
            'Spork',
            'Bruise',
            'Candy',
            'Fever',
            'Junuary',
            'Septa',
            'Remember',
            'Doom',
            'Widdershins',
            'Eleventy',
            'Recurse']

  DAYS = ['Hairday', 'Moonday', 'Twoday', 'Weddingday', 'Theday', 'Fryday', 'Standay', 'Fabday']

  attr_reader :real_now

  def initialize(seconds_since_epoch = nil)
    seconds_since_epoch ||= Time.now.to_i
    @real_now = seconds_since_epoch
    @year_offset = (year * SECONDS_IN_GAME_YEAR)
    @day_of_year_offset = (day_of_year * SECONDS_IN_GAME_DAY)
    @hour_offset = (hour * SECONDS_IN_GAME_HOUR)
    @minute_offset = (minute * SECONDS_IN_GAME_MINUTE)
  end

  def now
    @real_now - GAME_EPOCH;
  end

  def year
    (now / SECONDS_IN_GAME_YEAR).floor
  end

  def day_of_year
    offset = now - @year_offset
    (offset / SECONDS_IN_GAME_DAY).floor
  end

  def hour
    offset = now - @year_offset - @day_of_year_offset
    (offset / SECONDS_IN_GAME_HOUR).floor
  end

  def standard_hour
    current_hour = hour == 0 ? HOURS_IN_HALF_DAY : hour
    current_hour > HOURS_IN_HALF_DAY ? current_hour -= HOURS_IN_HALF_DAY : current_hour
  end

  def meridian_indicator
    current_hour = hour
    current_hour < HOURS_IN_HALF_DAY ? 'am' : 'pm'
  end

  def minute
    offset = now - @year_offset - @day_of_year_offset - @hour_offset
    (offset / SECONDS_IN_GAME_MINUTE).floor
  end

  def pretty_minute
    "%02d" % minute
  end

  def second
    now - @year_offset - @day_of_year_offset - @hour_offset - @minute_offset
  end

  def weekdays_since_epoch
    # The day of Recurse is not a weekday, so we subtract one.
    day_of_year + ((DAYS_IN_YEAR - 1) * year)
  end

  def day_of_week
    return nil if month_of_year == 11
    weekdays_since_epoch.modulo 8;
  end

  def day_of_month
    day_to_month_day(day_of_year)[1]
  end

  def month_of_year
    day_to_month_day(day_of_year)[0] - 1
  end

  # Converts an absolute day to month, day pair
  def day_to_month_day incremental_day
    month_lengths = [29, 3, 53, 17, 73, 19, 13, 37, 5, 47, 11, 1]
    current_day = 0
    month_lengths.each_with_index do |month, index|
      current_day += month
      if (current_day > incremental_day)
        m = index + 1
        d = incremental_day + 1 - (current_day - month)
        return [m, d]
      end
    end
    [0, 0]
  end

  def day_name
    return nil if month_of_year == 11
    DAYS[day_of_week]
  end

  def month_name
    MONTHS[month_of_year]
  end

  def suffix value = day_of_month
    case value
      when 0
        'th'
      when 1
        'st'
      when 2
        'nd'
      when 3
        'rd'
      else
        'th'
    end
  end

  def time_and_date
    if month_of_year == 11
      "#{standard_hour}:#{pretty_minute} #{meridian_indicator}, #{month_name}, year #{year}"
    else
      "#{standard_hour}:#{pretty_minute} #{meridian_indicator}, #{day_name} #{day_of_month}#{suffix} of #{month_name}, year #{year}"
    end
  end

  def verbose_time_and_date
    "Right at this very moment, it's #{time_and_date}"
  end
end
