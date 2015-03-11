class Turret < SKSpriteNode

  TURRET_CATEGORY = 0x1 << 2
  RATE = 0.4

  def init
    self.initWithImageNamed('images/turret.png')
    self.physicsBody = physics_body
    self.name = "turret"
    self.runAction(shoot)
    self
  end

  def shoot
    delay = SKAction.waitForDuration(RATE)
    sequence = SKAction.sequence([SKAction.performSelector("add_bullet", onTarget: self), delay])
    SKAction.repeatActionForever(sequence)
  end

  def add_bullet
    starting_position = CGPointMake(self.position.x, self.position.y + (self.size.height * 0.5))
    finishing_position = CGPointMake(self.position.x, UIScreen.mainScreen.bounds.size.height + Bullet::OFFSCREEN_MARGIN)
    distance = finishing_position.y - starting_position.y

    bullet = Bullet.alloc.initWithPosition(starting_position)
    shoot = SKAction.moveToY(finishing_position.y, duration: distance / Bullet::SPEED)
    bullet.runAction(shoot, completion: lambda { bullet.removeFromParent })
    self.scene.addChild(bullet)
  end

  def physics_body
    body = SKPhysicsBody.bodyWithRectangleOfSize(size)
    body.dynamic = false
    body.categoryBitMask = TURRET_CATEGORY
    body.contactTestBitMask = Beast::BEAST_CATEGORY
    body
  end

end