class Beast < SKSpriteNode

  BEAST = 0x1 << 0

  STATE_ALIVE = 1
  STATE_DEAD = 2

  def init
    self.initWithImageNamed('images/beast_1.png')
    self.physicsBody = physics_body
    self.position = CGPointMake(random_x, UIScreen.mainScreen.bounds.size.height + self.size.height)
    # self.scale = 1.1
    self.name = "beast"
    self.runAction(hover)
    @current_state = STATE_ALIVE

    self
  end

  def hover
    beast1 = SKTexture.textureWithImageNamed('images/beast_1.png')
    beast2 = SKTexture.textureWithImageNamed('images/beast_2.png')
    animation = SKAction.animateWithTextures([beast1, beast2], timePerFrame: 0.25)

    SKAction.repeatActionForever(animation)
  end

  def die
    unless dead?
      self.removeAllActions # self.removeActionForKey('hover') - not sure why this doesn't work
      @current_state = STATE_DEAD
      puts "beast is dead!!"
      SKAction.rotateToAngle(1.2, duration: 0.2, shortestUnitArc: true)
    end
  end

  def physics_body
    body = SKPhysicsBody.bodyWithRectangleOfSize(size)
    body.dynamic = true
    body.mass = 1
    # body.affectedByGravity = false
    # body.friction = 0.0
    body.categoryBitMask = BEAST
    body.contactTestBitMask = Level01Scene::WORLD
    body
  end

  def alive?
    @current_state == STATE_ALIVE
  end

  def dead?
    @current_state == STATE_DEAD
  end

  def should_be_removed?
    position.x < -40 || position.x > UIScreen.mainScreen.bounds.size.width + 40 || position.y < 0
  end

  def random_x
    x = Random.new.rand((size.width)..(UIScreen.mainScreen.bounds.size.width - size.width))
    puts "beast width: #{size.width}"
    puts "screen width: #{UIScreen.mainScreen.bounds.size.width - size.width}"
    puts "x: #{x}"
    x
  end

end