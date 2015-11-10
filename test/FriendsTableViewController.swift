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

class FriendsTableViewController: PFQueryTableViewController {
    var frendToAddTextField:UITextField? = nil
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.parseClassName = "Friends"
        self.textKey = "friedName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: "addTapped")
    }
    
    
    func addTapped(){
        var alert = UIAlertController(title: "AddFriend", message: "Enter a username", preferredStyle: UIAlertControllerStyle.Alert)
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
            NSLog("Adding friend: " + (self.frendToAddTextField?.text)!)
            addFriend((self.frendToAddTextField?.text)!)
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
        
        query.whereKey(getCurrentUserId()!, equalTo: "userId")
        query.orderByAscending("friendName")
        
        NSLog("in query for table")
        NSLog(query.description)
        
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
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */



}
