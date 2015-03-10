class Level01Scene < SKScene

  WORLD = 0x1 << 1

  def didMoveToView(view)
    super

    physicsWorld.gravity = CGVectorMake(0.0, -1.0)
    physicsWorld.contactDelegate = self

    add_background
    add_ground
    add_turret
    add_score_label
    add_beasts
  end

  def add_background
    texture = SKTexture.textureWithImageNamed("images/background_gradient.png")

    background = SKSpriteNode.spriteNodeWithTexture(texture)
    background.position = CGPointMake(mid_x, mid_y)
    background.name = "background"
    background.zPosition = -20

    addChild(background)
  end

  def add_ground
    @ground = Ground.alloc.init
    addChild(@ground)
  end

  def add_turret
    # don't like setting the position here but seems to be a bug with childNodeWithName("//ground")
    @turret = Turret.alloc.init
    position = CGPointMake(UIScreen.mainScreen.bounds.size.width * 0.5, (@turret.size.height * 0.5) + @ground.size.height)
    @turret.position = position
    addChild(@turret)
  end

  def add_score_label
    addChild(GameData.instance.current_score_label)
  end

  def add_beasts
    delay = SKAction.waitForDuration(1.0, withRange: 0.6)
    sequence = SKAction.sequence([SKAction.performSelector("add_beast", onTarget: self), delay])
    self.runAction(SKAction.repeatActionForever(sequence))
  end

  def add_beast
    addChild(Beast.alloc.init)
  end

  def touchesMoved(touches, withEvent: event)
    touch = touches.anyObject
    old_position = touch.previousLocationInNode(self)
    node = self.nodeAtPoint(old_position)

    if node.name == "turret"
      new_position = touch.locationInNode(self)
      self.move_node(node, new_position)
    end
  end

  def move_node(node, position)
    new_position = bounded_position(node, position)
    node.setPosition(new_position)
  end

  def bounded_position(node, position)
    x = [position.x, 0].max
    x = [x, self.frame.size.width].min

    y = [position.y, @ground.size.height + node.size.height * 0.5].max
    y = [y, self.frame.size.height - node.size.height].min
    CGPointMake(x, y)
  end

  def didBeginContact(contact)
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    else
      firstBody = contact.bodyB
      secondBody = contact.bodyA
    end

    # delegate contact handling to appropriate class
    firstBody.node.send("contacted_#{secondBody.node.class.name.underscore}", secondBody)
  end

  def didSimulatePhysics
    self.enumerateChildNodesWithName('beast', usingBlock: lambda { |node, stop| node.removeFromParent if node.should_be_removed? })
    self.enumerateChildNodesWithName('turret/bullet', usingBlock: lambda { |node, stop| node.removeFromParent if node.should_be_removed? })
  end

  def mid_x
    CGRectGetMidX(self.frame)
  end

  def mid_y
    CGRectGetMidY(self.frame)
  end

  def min_x
    CGRectGetMinX(self.frame)
  end

  def min_y
    CGRectGetMinY(self.frame)
  end

  def max_x
    CGRectGetMaxX(self.frame)
  end

  def max_y
    CGRectGetMaxY(self.frame)
  end

end