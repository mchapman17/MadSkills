class Beast < SKSpriteNode

  BEAST_CATEGORY = 0x1 << 1

  STATE_ALIVE = 1
  STATE_DEAD = 2

  KILL_POINTS = 1

  def init
    self.initWithImageNamed('images/beast_01.png')
    self.position = CGPointMake(random_x, UIScreen.mainScreen.bounds.size.height + self.size.height)
    self.physicsBody = physics_body
    self.scale = 0.7
    self.name = "beast"
    self.runAction(hover)
    @current_state = STATE_ALIVE

    self
  end

  def hover
    beast1 = SKTexture.textureWithImageNamed('images/beast_01.png')
    beast2 = SKTexture.textureWithImageNamed('images/beast_02.png')
    animation = SKAction.animateWithTextures([beast1, beast2], timePerFrame: 0.25)

    SKAction.repeatActionForever(animation)
  end

  def explode
    self.physicsBody = nil

    atlas = SKTextureAtlas.atlasNamed("explosion")
    textures = atlas.textureNames.sort.map { |texture| SKTexture.textureWithImageNamed(texture) }
    animation = SKAction.animateWithTextures(textures, timePerFrame: 0.04, resize: false, restore: false)

    self.runAction(SKAction.repeatAction(animation, count: 1), completion: lambda { self.removeFromParent })
  end

  def die
    unless dead?
      # self.removeAllActions # self.removeActionForKey('hover') - not sure why this doesn't work
      @current_state = STATE_DEAD
      GameData.instance.update_current_score(KILL_POINTS)
    end
  end

  def contacted_beast(beast)
    # do nothing
  end

  def contacted_ground(ground)
    self.removeAllActions
    self.physicsBody = nil
    self.runAction(SKAction.fadeOutWithDuration(0.5), completion: lambda { self.removeFromParent })
  end

  def contacted_turret(turret)
    # do nothing
  end

  def physics_body
    body = SKPhysicsBody.bodyWithRectangleOfSize(size)
    body.dynamic = true
    body.mass = 10
    body.categoryBitMask = BEAST_CATEGORY
    body.contactTestBitMask = Ground::GROUND_CATEGORY
    body
  end

  def alive?
    @current_state == STATE_ALIVE
  end

  def dead?
    @current_state == STATE_DEAD
  end

  def should_be_removed?
    position.x < -40 || position.x > UIScreen.mainScreen.bounds.size.width + 40
  end

  def random_x
    Random.new.rand((size.width)..(UIScreen.mainScreen.bounds.size.width - size.width))
  end

end