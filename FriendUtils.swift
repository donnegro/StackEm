//
//  FriendUtils.swift
//  StackEm
//
//  Created by Daniel Dao on 11/9/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import Foundation
import Parse

func addFriend(friendUsername: String){
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
                        }
                            
                        else{
                            NSLog("error saving the friendship for friend")
                        }
                    }
                }
                
                else{
                    // display alert view
                    NSLog("friendship already exists")
                }
            
            }
            
        }
            
        else{
            NSLog("name does not exist")
        }
    }
}
