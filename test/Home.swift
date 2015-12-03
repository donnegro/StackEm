//
//  File.swift
//  test
//
//  Created by Don Negro on 10/28/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import Foundation
import UIKit
import Parse
import AVFoundation

class Home : UIViewController {
    
    let songPath = NSBundle.mainBundle().pathForResource("test", ofType: "caf")
    
    var audioPlayerSong:AVAudioPlayer? = nil
    var songVolume:Float = 0.5    // range is 0.0 - 1.0
    var songLoop = true
    
    @IBOutlet weak var onOffLbl: UILabel!
    
    @IBOutlet weak var onOffSwitchOutlet: UISwitch!
    @IBAction func onOffSwitch(sender: AnyObject) {
        if self.onOffSwitchOutlet.on {
            self.audioPlayerSong?.play()
        }
        else {
            self.audioPlayerSong?.stop()
        }
    }
    

    var touchCount : Int = 0
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var userNameTxtField: UILabel!
    @IBAction func logOutAction(sender: AnyObject) {
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    
    @IBAction func volumeSlider(sender: AnyObject){
        songVolume = self.volumeSlider.value
        self.audioPlayerSong?.volume = songVolume
    }
 
    @IBAction func btnSoundPressed(sender: AnyObject) {
        touchCount++
        if touchCount == 1 {
            do {
                try self.audioPlayerSong = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: self.songPath!), fileTypeHint: nil)
            } catch {
                print("Something didn't work!")
            }
            
            self.audioPlayerSong?.prepareToPlay()
            self.audioPlayerSong?.volume = songVolume
            if self.songLoop {
                self.audioPlayerSong?.numberOfLoops = -1
            }
            self.audioPlayerSong?.play()
        }
        
        if touchCount % 2 == 1{
            volumeSlider.hidden = false
            onOffLbl.hidden = false
            onOffSwitchOutlet.hidden = false
        }
            
        else {
            volumeSlider.hidden = true
            onOffLbl.hidden = true
            onOffSwitchOutlet.hidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSettings()
        
        // Show the current visitor's username
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.userNameTxtField.text = pUserName
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSettings() {
        self.songVolume = 0.5
        self.volumeSlider.value = songVolume
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
}