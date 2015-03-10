class Ground < SKSpriteNode

  GROUND_CATEGORY = 0x1 << 3

  def init
    super

    self.initWithImageNamed('images/ground.png')
    self.position = CGPointMake(UIScreen.mainScreen.bounds.size.width * 0.5, self.size.height * 0.5)
    self.physicsBody = physics_body
    self.name = "ground"
    self
  end

  def physics_body
    body = SKPhysicsBody.bodyWithRectangleOfSize(size)
    body.restitution = 0.1
    body.dynamic = false
    body.usesPreciseCollisionDetection = true
    body.categoryBitMask = GROUND_CATEGORY
    body.collisionBitMask = 0
    body
  end

end