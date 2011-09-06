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

    sec = glitch_time.real_now - 1238562000

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

  def test_days_since_epoch
    glitch_time = GlitchTime.new
    expected = glitch_time.now / 14400

    assert_equal(expected, glitch_time.days_since_epoch, "Days since epoch is incorrect.")
  end

  def test_day_to_month_day
    glitch_time = GlitchTime.new


    puts "Today is #{glitch_time.month_of_year}/#{glitch_time.day_of_month}!"

    third_of_primuary = [1, 3]
    actual = glitch_time.day_to_month_day(2)

    assert_equal(third_of_primuary, actual)

    first_of_spork = [2, 1]
    actual = glitch_time.day_to_month_day(29)

    fifty_third_of_bruise = glitch_time.day_to_month_day(84)
  end

  def test_suffix
    glitch_time = GlitchTime.new

    expected = 'th'
    actual = glitch_time.suffix 0
    assert_equal(expected, actual, "0 failed suffix test")

    expected = 'st'
    actual = glitch_time.suffix 1
    assert_equal(expected, actual, "1 failed suffix test")

    expected = 'nd'
    actual = glitch_time.suffix 2
    assert_equal(expected, actual, "2 failed suffix test")

    expected = 'rd'
    actual = glitch_time.suffix 3
    assert_equal(expected, actual, "3 failed suffix test")

    expected = 'th'
    actual = glitch_time.suffix 4
    assert_equal(expected, actual, "4 failed suffix test")

    expected = 'th'
    actual = glitch_time.suffix 5
    assert_equal(expected, actual, "5 failed suffix test")

    expected = 'th'
    actual = glitch_time.suffix 6
    assert_equal(expected, actual, "6 failed suffix test")

    expected = 'th'
    actual = glitch_time.suffix 7
    assert_equal(expected, actual, "7 failed suffix test")

    expected = 'th'
    actual = glitch_time.suffix 8
    assert_equal(expected, actual, "8 failed suffix test")

    expected = 'th'
    actual = glitch_time.suffix 9
    assert_equal(expected, actual, "9 failed suffix test")

    expected = 'th'
    actual = glitch_time.suffix 10
    assert_equal(expected, actual, "10 failed suffix test")
  end

  def test_pretty_printing
    glitch_time = GlitchTime.new

    puts "Right at this very moment, it's #{glitch_time.standard_hour}:#{glitch_time.pretty_minute} #{glitch_time.meridian_indicator}, #{glitch_time.day_name} #{glitch_time.day_of_month}#{glitch_time.suffix} of #{glitch_time.month_name}, year #{glitch_time.year}"

  end
end