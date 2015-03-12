class Bullet < SKSpriteNode

  BULLET_CATEGORY = 0x1 << 0
  SPEED = 500.0
  OFFSCREEN_MARGIN = 20

  def initWithPosition(position)
    self.initWithImageNamed('images/bullet.png')
    self.physicsBody = physics_body
    self.position = position
    self.name = "bullet"
    self
  end

  def contacted_bullet(bullet)
    # do nothing
  end

  def contacted_beast(beast)
    self.removeFromParent
    beast.node.die
    beast.node.explode
  end

  def physics_body
    body = SKPhysicsBody.bodyWithRectangleOfSize(size)
    body.dynamic = false
    body.mass = 200
    body.affectedByGravity = false
    body.friction = 0.0
    body.categoryBitMask = BULLET_CATEGORY
    body.contactTestBitMask = Level01Scene::WORLD_CATEGORY
    body
  end

  def should_be_removed?
    # would be better to have the bullet move to Y position just above top of screen and then remove itself
    # needs to travel at same speed the whole way though, so duration won't work, needs to be a constant speed
    position_in_scene = convertPoint(self.position, fromNode: self.scene)
    position.y > UIScreen.mainScreen.bounds.size.height + position_in_scene.y
  end

end