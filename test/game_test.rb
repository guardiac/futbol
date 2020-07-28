require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/helpable'

class GameTest < Minitest::Test
  extend Helpable

  def setup
    @game = Game.new({:game_id => "2012030221", :season => "20122013", :type => "Postseason", :date_time => "5/16/13", :away_team_id => "3", :home_team_id => "6", :away_goals => 2, :home_goals => 3, :venue => "Toyota Stadium", :venue_link => "/api/v1/venues/null"})
    Game.class_variable_set(:@@all_games, [])
    Game.create('./data/games_fixture.csv')
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_can_read_info
    assert_equal "2012030221", @game.game_id
    assert_equal "20122013", @game.season
    assert_equal "Postseason", @game.type
    assert_equal "5/16/13", @game.date_time
    assert_equal "3", @game.away_team_id
    assert_equal "6", @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end

  def test_it_can_return_an_array_of_info
    assert_instance_of Array, Game.class_variable_get(:@@all_games)
    assert_equal 30, Game.class_variable_get(:@@all_games).count
    assert_equal true, Game.class_variable_get(:@@all_games).all? { |game| game.class == Game }
  end

  def test_it_can_get_total_number_of_games
    assert_equal 30, Game.count
  end

  def test_it_can_get_away_wins
    assert_equal 13, Game.total_away_wins
  end

  def test_it_can_return_total_goals_per_season
    seasons_and_total_goals = {
      "20122013" => 37,
      "20142015" => 35,
      "20172018" => 44
    }

    assert_equal seasons_and_total_goals, Game.total_goals_per_season
  end

  def test_count_of_games_by_season
    assert_equal ({"20122013"=>10, "20142015"=>10, "20172018"=>10}), Game.count_of_games_by_season
  end

  def test_it_can_get_highest_total_score
    assert_equal 7, Game.highest_total_score
  end

  def test_it_can_get_all_seasons
    assert_equal ["20122013", "20142015", "20172018"], Game.all_seasons
  end
end
