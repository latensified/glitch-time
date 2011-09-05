class GlitchTime
  GAME_EPOCH = 1238562000
  SECONDS_IN_GAME_YEAR = 4435200
  SECONDS_IN_GAME_DAY = 14400
  SECONDS_IN_GAME_HOUR = 600
  SECONDS_IN_GAME_MINUTE = 10

  attr_reader :real_now

  def initialize
    @real_now = Time.now.to_i
  end

  def now
    @real_now - GAME_EPOCH;
  end

  def year
    (now / SECONDS_IN_GAME_YEAR).floor
  end

  def day_of_year
    sec = now - (year * SECONDS_IN_GAME_YEAR)
    (sec / SECONDS_IN_GAME_DAY).floor
  end

  def hour
    sec = now - (year * SECONDS_IN_GAME_YEAR) - (day_of_year * SECONDS_IN_GAME_DAY)
    (sec / SECONDS_IN_GAME_HOUR).floor
  end

  def minute
    sec = now - (year * SECONDS_IN_GAME_YEAR) - (day_of_year * SECONDS_IN_GAME_DAY) - (hour * SECONDS_IN_GAME_HOUR)
    (sec / SECONDS_IN_GAME_MINUTE).floor
  end

  def second
    now - (year * SECONDS_IN_GAME_YEAR) - (day_of_year * SECONDS_IN_GAME_DAY) - (hour * SECONDS_IN_GAME_HOUR) - (minute * SECONDS_IN_GAME_MINUTE)
  end
end