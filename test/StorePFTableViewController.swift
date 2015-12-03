//
//  StorePFTableViewController.swift
//  StackEm
//
//  Created by Daniel Dao on 11/30/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class StorePFTableViewController: PFQueryTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    required init!(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        self.parseClassName = "Item"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.navigationItem.title = "Store"
        
    }
    
    override func queryForTable() -> PFQuery {
        let query:PFQuery = PFQuery(className: "Item")
        query.orderByAscending("name")
        
        return query
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cell:PFTableViewCell = tableView.dequeueReusableCellWithIdentifier("storeItemCell") as! PFTableViewCell
        
        cell.textLabel?.text = object?["name"] as? String
        cell.detailTextLabel?.text = "Price: " + (object?["price"] as! Int).description
        
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showItemViewController"){
            let indexPath = self.tableView.indexPathForSelectedRow
            let item = self.objectAtIndexPath(indexPath)
            let itemVC:ItemViewController = segue.destinationViewController as! ItemViewController
            itemVC.name = item?.objectForKey("name") as! String
            itemVC.price = (item?.objectForKey("price") as! Int)
            itemVC.itemDescription = item?.objectForKey("description") as! String
            //            self.presentViewController(itemVC, animated: false, completion: nil)
            
        }
    }
    
    
}
