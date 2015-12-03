//
//  GameOverScene.swift
//  Stacker
//
//  Created by Daniel Portillo on 12/3/15.
//  Copyright © 2015 Daniel Portillo. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    var score:Int
    
    init(size:CGSize, score:Int) {
        self.score = score
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        
        let message = "GAME OVER"
        
        let label = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.redColor()
        label.position = CGPointMake(self.size.width/2, self.size.height/2)
        self.addChild(label)
        
        let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        scoreLabel.text = "Your Score is: \(self.score)"
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = SKColor.redColor()
        scoreLabel.position = CGPointMake(self.size.width/2, self.size.height/2 - 40)
        self.addChild(scoreLabel)
        
        let replayMessage = "Play Again"
        let replayButton = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        replayButton.text = replayMessage
        replayButton.fontColor = SKColor.redColor()
        replayButton.position = CGPointMake(self.size.width/2, 50)
        replayButton.name = "replay"
        self.addChild(replayButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == "replay" {
                let reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
                let newBoard:Board = Board(rows: 10, columns: 8)
                let scene = GameScene(size: self.view!.bounds.size, board: newBoard)
                scene.scaleMode = .AspectFill
                scene.addTiles()
                self.view?.presentScene(scene, transition: reveal)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}