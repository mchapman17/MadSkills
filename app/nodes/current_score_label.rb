class CurrentScoreLabel < SKLabelNode

  def init
    super

    self.fontName = "Copperplate"
    self.fontSize = 20
    self.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight
    self.position = CGPointMake(UIScreen.mainScreen.bounds.size.width - 10, UIScreen.mainScreen.bounds.size.height - 20)
    self.zPosition = 10
    self.name = "current_score_label"
    self.text = "Score: 0"

    self
  end

  def refresh
    self.text = "Score: #{GameData.instance.current_score}"
  end

end