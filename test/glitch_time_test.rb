require "test/unit"
require "../lib/glitch_time"

class GlitchTimeTest < Test::Unit::TestCase

  def setup
    @now = Time.now.to_i
  end

  def test_now
    expected = @now - 1238562000
    actual = GlitchTime.new.now

    puts "now: #{actual}, #{expected}"

    assert_equal(expected, actual, "Current time is incorrect.")
  end

  def test_year
    expected = (@now - 1238562000) / 4435200
    actual = GlitchTime.new.year

    assert_equal(expected, actual, "Current year is incorrect.")
  end

  def test_glitch_time
    glitch_time = GlitchTime.new

    sec = glitch_time.real_now - 1238562000;

    # there are 4435200 real seconds in a game year
    # there are 14400 real seconds in a game day
    # there are 600 real seconds in a game hour
    # there are 10 real seconds in a game minute

    year = (sec / 4435200).floor

    assert_equal(year, glitch_time.year, "Year is incorrect.")

    sec -= year * 4435200
    day_of_year = (sec / 14400).floor

    assert_equal(day_of_year, glitch_time.day_of_year, "Day of year is incorrect.")

    sec -= day_of_year * 14400
    hour = (sec / 600).floor

    assert_equal(hour, glitch_time.hour, "Hour is incorrect.")
    
    sec -= hour * 600
    minute = (sec / 10).floor

    assert_equal(minute, glitch_time.minute, "Minute is incorrect.")

    sec -= minute * 10

    assert_equal(sec, glitch_time.second, "Seconds are incorrect.")

  end
end