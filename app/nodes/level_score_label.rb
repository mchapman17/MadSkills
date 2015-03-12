class LevelScoreLabel < SKLabelNode

  def init
    super

    self.fontName = "Menlo"
    self.fontSize = 36
    self.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter
    self.position = CGPointMake(UIScreen.mainScreen.bounds.size.width * 0.5, UIScreen.mainScreen.bounds.size.height * 0.5)
    self.zPosition = 10
    self.name = "level_complete_label"
    self.text = "Score: #{GameData.instance.current_score}"
    self
  end

end