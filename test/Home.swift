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

class Home : UIViewController {
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
    
    @IBAction func btnSoundPressed(sender: AnyObject) {
        touchCount++
        if touchCount % 2 == 1{
            volumeSlider.hidden = false;
        }
        else {
            volumeSlider.hidden = true;
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the current visitor's username
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.userNameTxtField.text = pUserName
        }
        
        
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