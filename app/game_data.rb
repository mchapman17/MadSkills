class GameData

  attr_accessor :current_score, :current_score_label, :high_score

  def initialize
    @current_score = 0
    @current_score_label = CurrentScoreLabel.alloc.init
    @high_score = 0
  end

  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end

  def update_current_score(points)
    @current_score += points
    @current_score_label.refresh
  end

  def reset
    @current_score = 0
  end

end