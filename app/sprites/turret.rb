class Turret < SKSpriteNode

  TURRET = 0x1 << 2

  def init
    self.initWithImageNamed('images/turret.png')
    self.physicsBody = physics_body
    self.position = CGPointMake(UIScreen.mainScreen.bounds.size.width * 0.5, (self.size.height * 0.5) + 64)
    self.name = "turret"
    self.runAction(shoot)

    self
  end

  def shoot
    delay = SKAction.waitForDuration(0.4)
    sequence = SKAction.sequence([SKAction.performSelector("add_laser", onTarget: self), delay])
    SKAction.repeatActionForever(sequence)
  end

  def add_laser
    addChild(Laser.alloc.init)
  end

  def physics_body
    body = SKPhysicsBody.bodyWithRectangleOfSize(size)
    body.dynamic = false
    # body.affectedByGravity = false
    # body.friction = 0.0
    body.categoryBitMask = TURRET
    body.contactTestBitMask = Level01Scene::WORLD
    body
  end

end