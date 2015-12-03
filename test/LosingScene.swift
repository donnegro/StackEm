//
//  GameOverScene.swift
//  Stacker
//
//  Created by Daniel Dao on 10/19/15.
//  Copyright © 2015 Daniel Dao. All rights reserved.
//

import UIKit
import SpriteKit

class LosingScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        NSLog("Game over scene presented")
        backgroundColor = SKColor.blackColor()
        var label: UILabel = UILabel()
        
        label.frame = CGRectMake(self.view!.frame.size.width/4, 100, 200, 20)
        label.backgroundColor = UIColor.orangeColor()
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = "You lost"
        
        self.view?.addSubview(label)
    }
}
