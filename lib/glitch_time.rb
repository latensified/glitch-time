#
# Converts real time to Glitch Time
#
# There are 308 days in a glitch year.
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
  MONTHS = {'Primuary' => 29,
            'Spork' => 3,
            'Bruise' => 53,
            'Candy' => 17,
            'Fever' => 73,
            'Junuary' => 19,
            'Septa' => 13,
            'Remember' => 37,
            'Doom' => 5,
            'Widdershins' => 47,
            'Eleventy' => 11,
            'Recurse' => -1}

  DAYS = ['Hairday', 'Moonday', 'Twoday', 'Weddingday', 'Theday', 'Fryday', 'Standay', 'Fabday']

  attr_reader :real_now

  def initialize
    @real_now = Time.now.to_i
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
    current_hour = hour
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

  def days_since_epoch
    day_of_year + (DAYS_IN_YEAR * year)
  end

  def day_of_week
    days_since_epoch.modulo 8;
  end

  def day_of_month
    day_to_month_day(day_of_year)[1]
  end

  def month_of_year
    day_to_month_day(day_of_year)[0]
  end

  def day_to_month_day incremental_day
    current_day = 0
    m = 0

    MONTHS.each do |month|
      current_day += month[1]
      if (current_day > incremental_day)
        m += 1
        d = incremental_day + 1 - (current_day - month[1])
        return [m, d]
      end
    end
    array(0, 0)
  end

  def day_name
    DAYS[day_of_week]
  end

  def month_name
    MONTHS.to_a[day_to_month_day(day_of_year)[0]][0]
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
end