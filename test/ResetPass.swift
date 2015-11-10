//
//  ResetPass.swift
//  StackEm
//
//  Created by Don Negro on 11/8/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ResetPass : UIViewController {
    @IBOutlet weak var resetPassTxtField: UITextField!
    
    @IBAction func btnResetPass(sender: AnyObject) {
        var email = self.resetPassTxtField.text
        var finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Send a request to reset a password
        PFUser.requestPasswordResetForEmailInBackground(finalEmail)
        
        var alert = UIAlertController (title: "Password Reset", message: "An email containing information on how to reset your password has been sent to " + finalEmail + ".", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}