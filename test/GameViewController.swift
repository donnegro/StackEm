//
//  GameViewController.swift
//  Stacker
//
//  Created by Daniel Portillo on 11/09/15.
//  Copyright (c) 2015 Daniel Dao. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene:GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        let numberOfRows:Int = 10
        let numberOfColumns:Int = 8
        
        // Create and configure the scene.
        let newBoard:Board = Board(rows: numberOfRows, columns: numberOfColumns)
        self.scene = GameScene(size: skView.bounds.size, board: newBoard)
        self.scene.scaleMode = .AspectFill
        
        self.scene.addTiles()
        
        // Present the scene.
        skView.presentScene(scene)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}