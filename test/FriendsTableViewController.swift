//
//  FriendsTableViewController.swift
//  StackEm
//
//  Created by Daniel Dao on 11/9/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import UIKit
import ParseUI
import Parse
import SpriteKit

class FriendsTableViewController: PFQueryTableViewController {
    var frendToAddTextField:UITextField? = nil
    
    override init(style: UITableViewStyle, className: String!){
        super.init(style: style, className: className)
    }
    
    required init!(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        self.parseClassName = "Friends"
        self.textKey = "friendName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.navigationItem.title = "Friends List"
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: "addTapped")
    }
    
    
    func addTapped(){
        var alert = UIAlertController(title: "Add Friend", message: "Enter a username", preferredStyle: UIAlertControllerStyle.Alert)
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
            NSLog("Adding friend: " + (self.frendToAddTextField?.text)!)
            addFriend((self.frendToAddTextField?.text)!, tableView: self)
            // for refreshing after add 
            //dispatch_async(dispatch_get_main_queue(), {() -> Void in
              //  self.tableView.reloadData()
           // }  )
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
            
        }
        
        alert.addTextFieldWithConfigurationHandler{(textField) -> Void in
            self.frendToAddTextField = textField
            
        }
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        // present the view controller
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func queryForTable() -> PFQuery {
        let query:PFQuery = PFQuery(className: "Friends")
        query.whereKey("userId", equalTo: getCurrentUserId()!)
        query.orderByAscending("friendName")
        
        return query
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        var cell:PFTableViewCell = tableView.dequeueReusableCellWithIdentifier("friendCell") as! PFTableViewCell
        
        cell.textLabel?.text = object?["friendName"] as? String
        
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = tableView.cellForRowAtIndexPath(indexPath) as! PFTableViewCell
        let name = object.textLabel!.text!
        
        let alert = UIAlertController(title: "Challenge", message: "Do you want to play " + name + "?", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
            let pfQuery:PFQuery = PFQuery(className: "Challenge")
            pfQuery.whereKey("challenger", equalTo: getCurrentUserName()!)
            pfQuery.whereKey("friend", equalTo: name)
            pfQuery.findObjectsInBackgroundWithBlock{(results, error) in
                if(error == nil && results?.count == 0){
                    let userName = getCurrentUserName()
                    let pfObjectUser = PFObject(className: "Challenge")
                    pfObjectUser.setObject(userName!, forKey: "challenger")
                    pfObjectUser.setObject(name, forKey: "friend")
                    
                    // save the challenge in the backend
                    pfObjectUser.saveInBackgroundWithBlock{(success, error) in
                        if (success){
                            NSLog("challenge saved for user")
                        }
                            
                        else{
                            NSLog("challenge saved for friend")
                        }
                    }
                    
                    
                    let pfObjectFriend = PFObject(className: "Challenge")
                    pfObjectFriend.setObject(name, forKey: "challenger")
                    pfObjectFriend.setObject(userName!, forKey: "friend")
                    
                    pfObjectFriend.saveInBackgroundWithBlock{(success, error) in
                        if (success){
                            NSLog("challenge saved for friend")
                        }
                            
                        else{
                            NSLog("challenge saved for user")
                        }
                        
                    }

                
                }
                
                else{
                    NSLog("challenge already in there")
                }
            
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in

        }

        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

}
