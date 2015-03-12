class LevelCompleteLabel < SKLabelNode

  def init
    super

    self.fontName = "Menlo"
    self.fontSize = 30
    self.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter
    self.position = CGPointMake(UIScreen.mainScreen.bounds.size.width * 0.5, UIScreen.mainScreen.bounds.size.height * 0.75)
    self.zPosition = 10
    self.name = "level_complete_label"
    self.text = "Level 1 Complete!"
    self
  end

end