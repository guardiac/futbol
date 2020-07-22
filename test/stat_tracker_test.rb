require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_fixture_path = './data/games_fixture.csv'
    team_fixture_path = './data/teams.csv'
    game_teams_fixture_path = './data/game_teams_fixture.csv'

    @fixture_locations = {
    games: game_fixture_path,
    teams: team_fixture_path,
    game_teams: game_teams_fixture_path
    }

    @stat_tracker = StatTracker.from_csv(@fixture_locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  # def test_it_has_attributes
  #   assert_equal './data/games_fixture.csv', @stat_tracker.game_path
  #   assert_equal './data/teams.csv', @stat_tracker.team_path
  #   assert_equal './data/game_teams_fixture.csv', @stat_tracker.game_teams_path
  # end

  # Game Statistics Tests - Helper Methods #
  def test_it_can_get_total_goals_per_game
    assert_equal 5, @stat_tracker.total_goals_per_game[2012030221]
    assert_equal 3, @stat_tracker.total_goals_per_game[2012030231]
  end

  # Game Statistics Tests - Stat Methods #
  def test_it_can_get_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_count_of_games_by_season
    assert_equal ({20122013=>10, 20142015=>10, 20172018=>10}), @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 3.87, @stat_tracker.average_goals_per_game
  end

# ==================       League Stats Tests      ==================
  def test_it_can_get_total_games_per_team
    expected = { 3=>9, 6=>9, 5=>8, 17=>1, 16=>7, 14=>6, 28=>10, 54=>6, 24=>4 }
    assert_equal expected, @stat_tracker.total_games_per_team
  end
end
