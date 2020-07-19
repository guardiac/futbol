require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'

class StatTrackerTest < Minitest::Test

  def setup
    game_fixture_path = './data/games_fixture.csv'
    team_fixture_path = './data/teams_fixture.csv'
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

  def test_it_has_attributes
    assert_instance_of GameCollection, @stat_tracker.game_collection
    # assert_equal './data/teams_fixture.csv', @stat_tracker.team_path
    # assert_equal './data/game_teams_fixture.csv', @stat_tracker.game_teams_path
  end

  # Game Statistics Tests #
  def test_average_goals_per_game
    assert_equal 3.75, @stat_tracker.average_goals_per_game
  end

  def test_count_of_games_by_season
    assert_equal ({20122013 => 20}), @stat_tracker.count_of_games_by_season
  end

end
