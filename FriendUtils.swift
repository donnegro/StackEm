//
//  FriendUtils.swift
//  StackEm
//
//  Created by Daniel Dao on 11/9/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import Foundation
import Parse
import UIKit

func addFriend(friendUsername: String, tableView:FriendsTableViewController){
    if(friendUsername == getCurrentUserName()!){
        let alertController = generateAlertController("Cannot add self")
        tableView.presentViewController(alertController, animated: true, completion: nil)
        return
    }
    let query:PFQuery = PFUser.query()!
    query.whereKey("username", equalTo: friendUsername)
    query.findObjectsInBackgroundWithBlock{(results, error) -> Void in
        if(error == nil && results!.count == 1){
            // iterate through query results and grab object id
            var friendId:String? = nil
            var friendName:String? = nil
            for user in results!{
                friendId = user.objectId
                friendName = user["username"] as! String?
            }
            

            // add the friend now if the relationship does not exist
            let currentUserId = getCurrentUserId()
            
            let checkFriendsQuery:PFQuery = PFQuery(className: "Friends")
            checkFriendsQuery.whereKey("userId", equalTo: currentUserId!)
            checkFriendsQuery.whereKey("friendId", equalTo: friendId!)
            NSLog("friend name: " + friendName! + " username: "  + getCurrentUserName()!)
            checkFriendsQuery.findObjectsInBackgroundWithBlock{ (results, error) -> Void in
                if(error == nil && results!.count == 0){
                    NSLog(results!.description)
                    // saving to current friends list
                    let userRow = PFObject(className: "Friends")

                    userRow.setObject(currentUserId!, forKey: "userId")
                    userRow.setObject(friendId!, forKey: "friendId")
                    userRow.setObject(getCurrentUserName()!, forKey: "userName")
                    userRow.setObject(friendName!, forKey: "friendName")
                    
                    let friendRow = PFObject(className: "Friends")
                    // saving to other friends list
                    friendRow.setObject(friendId!, forKey: "userId")
                    friendRow.setObject(currentUserId!, forKey: "friendId")
                    friendRow.setObject(friendName!, forKey: "userName")
                    friendRow.setObject(getCurrentUserName()!, forKey: "friendName")
                    
                    
                    userRow.saveInBackgroundWithBlock{(success, error) -> Void in
                        if(success){
                            NSLog("friendship successfully saved for user")
                        }
                            
                        else{
                            NSLog("error saving the friendship for user")
                        }
                    }
                    
                    friendRow.saveInBackgroundWithBlock{(success, error) -> Void in
                        if(success){
                            NSLog("friendship successfully for friend")
                            let alertController = generateAlertController("Successfully added friend")
                            tableView.presentViewController(alertController, animated: true, completion: nil)

                        }
                            
                        else{
                            NSLog("error saving the friendship for friend")
                            let alertController = generateAlertController("Error saving friendship")
                            tableView.presentViewController(alertController, animated: true, completion: nil)
                        }
                    }
                }
                
                else{
                    // display alert view
                    NSLog("friendship already exists")
                    let alertController = generateAlertController("Friend already exists")
                    tableView.presentViewController(alertController, animated: true, completion: nil)
                }
            
            }
            
        }
            
        else{
            NSLog("name does not exist")
            
            let alertController = generateAlertController("User does not exist")
            tableView.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

func generateAlertController(textToDisplay:String) -> UIAlertController{
    var alert = UIAlertController(title: textToDisplay, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
      
    }
    
    alert.addAction(okAction)
    return alert

}
