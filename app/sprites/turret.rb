class Turret < SKSpriteNode

  TURRET_CATEGORY = 0x1 << 2

  def init
    self.initWithImageNamed('images/turret.png')
    self.physicsBody = physics_body
    self.name = "turret"
    self.runAction(shoot)
    self
  end

  def shoot
    delay = SKAction.waitForDuration(0.4)
    sequence = SKAction.sequence([SKAction.performSelector("add_bullet", onTarget: self), delay])
    SKAction.repeatActionForever(sequence)
  end

  def add_bullet
    position = CGPointMake(0, self.size.height * 0.5)
    addChild(Bullet.alloc.initWithPosition(position))
  end

  def physics_body
    body = SKPhysicsBody.bodyWithRectangleOfSize(size)
    body.dynamic = false
    body.categoryBitMask = TURRET_CATEGORY
    body.contactTestBitMask = Beast::BEAST_CATEGORY
    body
  end

end