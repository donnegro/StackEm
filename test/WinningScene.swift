//
//  WinningScene.swift
//  Stacker
//
//  Created by Daniel Dao on 10/19/15.
//  Copyright © 2015 Daniel Dao. All rights reserved.
//

import UIKit
import SpriteKit
import Parse

class WinningScene: SKScene {
    var score:Int? = nil
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        NSLog("Winning scene presented")
        backgroundColor = SKColor.blackColor()
        var label: UILabel = UILabel()
        
        label.frame = CGRectMake(self.view!.frame.size.width/4, 100, 200, 20)
        label.backgroundColor = UIColor.orangeColor()
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = "You won: " + String(score! as Int)
        saveScore()
        self.view?.addSubview(label)
    }
    
    private func saveScore(){
        let gameRow = PFObject(className: "Game")
        gameRow.setObject(score!, forKey: "Score")
        gameRow.setObject(getCurrentUserName()!, forKey: "userName")
        gameRow.saveInBackgroundWithBlock{(success, error) in
            if(success){
                NSLog("score was succesfully saved.")
            }
            
            else{
                NSLog("unfortunately your score was not saved.")
            }
        }
    
    }
}
