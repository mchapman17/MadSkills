class GameViewController < UIViewController

  def loadView
    view = SKView.new
    view.showsFPS = true
    view.showsNodeCount = true
    view.showsDrawCount = true
    view.showsPhysics = true

    self.view = view
  end

  def viewWillLayoutSubviews
    super

    unless self.view.scene
      scene = Level01Scene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      view.presentScene(scene)
    end
  end

  def prefersStatusBarHidden
    true
  end

end