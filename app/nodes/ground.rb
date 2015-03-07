class Ground < SKNode

  def init
    super

    self.position = CGPointMake(UIScreen.mainScreen.bounds.size.width * 0.5, 32)
    self.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(CGSizeMake(UIScreen.mainScreen.bounds.size.width, 64))
    self.physicsBody.categoryBitMask = Level01Scene::WORLD
    self.physicsBody.restitution = 0.1
    self.physicsBody.dynamic = false
    self.physicsBody.collisionBitMask = 0
    self.physicsBody.usesPreciseCollisionDetection = true
    self
  end

end