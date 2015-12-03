//
//  ItemViewController.swift
//  StackEm
//
//  Created by Daniel Dao on 11/30/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    var itemDescription:String = ""
    var name:String = ""
    var price:Int = 0
    var itemToAddTextField:UITextField? = nil
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        priceLabel.text = price.description
        descriptionLabel.text = itemDescription
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buy", style: .Plain, target: self, action: "buyItem")
        // Do any additional setup after loading the view.
    }
    
    func buyItem(){
        var alert = UIAlertController(title: "Purchase Item", message: "Enter a quantity", preferredStyle: UIAlertControllerStyle.Alert)
        
        let buyAction = UIAlertAction(title: "Buy", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
            NSLog(getCurrentUserCurrency().description)
            purchaseItem(getCurrentUserName()!, quantity: Int((self.itemToAddTextField?.text)!)!, itemName: self.name, price: self.price, vc: self)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) in
            
        }
        
        
        alert.addTextFieldWithConfigurationHandler{(textField) -> Void in
            self.itemToAddTextField = textField
        }
        
        alert.addAction(buyAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
