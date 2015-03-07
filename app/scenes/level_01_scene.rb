class Level01Scene < SKScene

  WORLD = 0x1 << 1

  def didMoveToView(view)
    super

    physicsWorld.gravity = CGVectorMake(0.0, -1.0)
    physicsWorld.contactDelegate = self

    add_background
    add_ground
    add_turret
    add_beasts
    # add_ground
    # add_bird

    # add_pause_label
  end

  def add_background
    texture = SKTexture.textureWithImageNamed("images/background_gradient.png")

    # 4.times do |i|
    #   x_position = mid_x + (i * mid_x * 2)
      background = SKSpriteNode.spriteNodeWithTexture(texture)
      background.position = CGPointMake(mid_x, mid_y)
      background.name = "background"
      background.zPosition = -20
    #   # skyline.scale = 1.12
    #   # skyline.runAction scroll_action(mid_x, 0.1)

      addChild(background)
    # end
  end

  def add_ground
    texture = SKTexture.textureWithImageNamed("images/ground.png")
    (self.frame.size.width / texture.size.width).to_i.times do |i|
      ground = SKSpriteNode.spriteNodeWithTexture(texture)
      ground.position = CGPointMake(min_x + (texture.size.width * i) + (texture.size.width / 2), min_y + (texture.size.height / 2))
      addChild(ground)
    end

    addChild(Ground.alloc.init)
  end

  def add_turret
    addChild(Turret.alloc.init)
  end

  def add_beasts
    delay = SKAction.waitForDuration(1.2, withRange: 0.2)
    sequence = SKAction.sequence([SKAction.performSelector("add_beast", onTarget: self), delay])
    self.runAction(SKAction.repeatActionForever(sequence))
  end

  def add_beast
    addChild(Beast.alloc.init)
  end

  def didBeginContact(contact)
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
      beast = contact.bodyA
    else
      beast = contact.bodyB
    end

    if beast.categoryBitMask == Beast::BEAST
      beast.node.runAction(beast.node.die)
    end
  end

  def didSimulatePhysics
    self.enumerateChildNodesWithName('beast', usingBlock: lambda { |node, stop| node.removeFromParent if node.should_be_removed? })
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