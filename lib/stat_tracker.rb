require_relative './game'
require_relative './game_collection'

class StatTracker
  attr_reader :game_collection,
              :team_collection,
              :teams

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    self.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    # @team_collection = TeamCollection.new(team_path)
    @game_collection = GameCollection.new(game_path)
    @games = @game_collection.all_games
  end

# Game Statistics Tests - Helper Methods #
  def total_goals
    @games.reduce(0) do |total, game|
      total += game.away_goals + game.home_goals
      total
    end
  end 

  def total_goals_per_game
    @games.reduce({}) do |ids_to_scores, game|
      ids_to_scores[game.game_id] = game.away_goals + game.home_goals
      ids_to_scores
    end
  end

  def array_of_total_goals_per_season
    @games.reduce(Hash.new { |h, k| h[k] = [] }) do |result, game|
      result[game.season] << game.away_goals + game.home_goals
      result
    end
  end

  def total_goals_per_season
    result = {}
    array_of_total_goals_per_season.each do |season, goals|
      result[season] = goals.sum
    end
  result
  end

# Game Statistics Tests - Stat Methods #
  def highest_total_score
    total_goals_per_game.max_by {|game_id, total_goals| total_goals}[1]
  end

  def count_of_games_by_season
    season_games = Hash.new(0)
    @games.each do |game|
      season_games[game.season] += 1
    end
    season_games
  end

  def average_goals_per_game
    result = total_goals_per_game.values.sum
    (result / total_goals_per_game.keys.count.to_f).round(2)
  end

  def average_goals_by_season 
    seasons = [20122013, 20142015, 20172018]
    
    result = {}
    seasons.each do |season|
      result[season] = (total_goals_per_season[season] / count_of_games_by_season[season]).round(2)
    end
    result
  end
end
