//
//  ChallengeTableViewController.swift
//  StackEm
//
//  Created by Daniel Dao on 11/10/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class ChallengeTableViewController: PFQueryTableViewController {

    override init(style: UITableViewStyle, className: String!){
        super.init(style: style, className: className)
    }
    
    required init!(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        self.parseClassName = "Challenger"

        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.navigationItem.title = "Challenger"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionnOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    }
    
    
    
    override func queryForTable() -> PFQuery {
        let query:PFQuery = PFQuery(className: "Challenge")
        query.whereKey("friend", equalTo: getCurrentUserName()!)
        return query
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cell:PFTableViewCell = tableView.dequeueReusableCellWithIdentifier("challengeCell") as! PFTableViewCell
        
        cell.textLabel?.text = object?["challenger"] as! String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = tableView.cellForRowAtIndexPath(indexPath) as! PFTableViewCell
        let challengerName = object.textLabel!.text!
        let query:PFQuery = PFQuery(className: "Game")
        query.whereKey("userName", equalTo: getCurrentUserName()!)
        query.orderByDescending("Score")
        query.findObjectsInBackgroundWithBlock{(results, error) in
            if(error == nil){
                let userObject = results![0] as! PFObject
                let userScore = userObject["Score"] as! Int
                
                let challengerQuery = PFQuery(className: "Game")
                challengerQuery.whereKey("userName", equalTo: challengerName)
                challengerQuery.orderByDescending("Score")
                challengerQuery.findObjectsInBackgroundWithBlock{(results, error) in
                    if(error == nil){
                        let challengerObject = results![0] as! PFObject
                        let challengerScore = challengerObject["Score"] as! Int
                        let alert = UIAlertController(title: "Challenge Score", message: challengerName + ": " + challengerScore.description + " Your score: " + userScore.description, preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
                            
                        }
                        
                        alert.addAction(okAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                
                }
                
            
            }
        
            else{
                NSLog("error in grabbing challenge scores")
            }
        }

        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    

}
