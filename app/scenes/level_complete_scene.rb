class LevelCompleteScene < SKScene

  def didMoveToView(view)
    super

    # physicsWorld.contactDelegate = self
    add_level_complete_label
    add_level_score_label
    # add_next_level_label

    self.backgroundColor = UIColor.clearColor
    view.allowsTransparency = true

    view.when_tapped do
      puts "tapped dat!"
    end
  end

  def add_level_complete_label
    addChild(LevelCompleteLabel.alloc.init)
  end

  def add_level_score_label
    addChild(LevelScoreLabel.alloc.init)
  end

  # def touchesMoved(touches, withEvent: event)
  #   touch = touches.anyObject
  #   old_position = touch.previousLocationInNode(self)
  #   node = self.nodeAtPoint(old_position)

  #   if node.name == "turret"
  #     new_position = touch.locationInNode(self)
  #     self.move_node(node, new_position)
  #   end
  # end

end