class Laser < SKSpriteNode

  LASER = 0x1 << 3

  def init
    self.initWithImageNamed('images/laser.png')
    self.physicsBody = physics_body
    self.position = CGPointMake(10, 120)
    self.name = "laser"
    self.runAction(shoot)

    self
  end

  def shoot
    puts "move: x: #{self.position.x} y: #{UIScreen.mainScreen.bounds.size.height + 50}"
    SKAction.moveTo(CGPointMake(self.position.x, UIScreen.mainScreen.bounds.size.height + 50), duration: 0.8)
    # self.removeFromParent
  end

  def physics_body
    body = SKPhysicsBody.bodyWithRectangleOfSize(size)
    body.dynamic = true
    body.affectedByGravity = false
    body.friction = 0.0
    body.categoryBitMask = LASER
    body.contactTestBitMask = Level01Scene::WORLD
    body
  end

end