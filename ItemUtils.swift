//
//  ItemUtils.swift
//  StackEm
//
//  Created by Daniel Dao on 12/1/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import Foundation
import Parse

func purchaseItem(username:String, quantity:Int, itemName:String, price:Int, vc:ItemViewController){
    let total:Int = quantity * price
    var successfulPurchase = true
    if(total > getCurrentUserCurrency()){
        successfulPurchase = false
        var alert = UIAlertController(title: "", message: "You do not have enough money.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
            
        }
        alert.addAction(okAction)
        vc.presentViewController(alert, animated: true, completion: nil)
        
        return
    }
    
    let change = getCurrentUserCurrency() - total
    PFUser.currentUser()?.setObject(change, forKey: "currency")
    PFUser.currentUser()?.saveInBackground()
    
    let itemIdQuery:PFQuery = PFQuery(className: "Item")
    itemIdQuery.whereKey("name", equalTo: itemName)
    itemIdQuery.findObjectsInBackgroundWithBlock{(results, error) -> Void in
        if(error == nil){
            var item:PFObject = results![0] as! PFObject
            var itemId = item.objectId!
            let relationshipQuery:PFQuery = PFQuery(className: "ItemCrossRefUser")
            relationshipQuery.whereKey("userId", equalTo: getCurrentUserId()!)
            relationshipQuery.whereKey("itemId", equalTo: itemId)
            relationshipQuery.findObjectsInBackgroundWithBlock{(results, error) -> Void in
                if(error == nil){
                    if(results!.count == 0){
                        let relationshipObject = PFObject(className: "ItemCrossRefUser")
                        relationshipObject.setObject(quantity, forKey: "quantity")
                        relationshipObject.setObject(getCurrentUserId()!, forKey: "userId")
                        relationshipObject.setObject(itemId, forKey: "itemId")
                        relationshipObject.saveInBackground()
                    }
                        
                    else{
                        var relationship:PFObject = results![0] as! PFObject
                        var oldQuantity = relationship.objectForKey("quantity") as! Int
                        relationship.setObject(oldQuantity + quantity, forKey: "quantity")
                        relationship.saveInBackground()
                    }
                }
                    
                else{
                    
                }
            }
            
        }
            
        else{
            NSLog("error in finding the item id")
        }
    }
    
    var alert = UIAlertController(title: "", message: "You have successfully purchased the item!", preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
        
    }
    alert.addAction(okAction)
    vc.presentViewController(alert, animated: true, completion: nil)
    
    
    
}