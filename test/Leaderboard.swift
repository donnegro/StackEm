import UIKit
import ParseUI
import Parse

class Leaderboard: PFQueryTableViewController {
    
    override init(style: UITableViewStyle, className: String!){
        super.init(style: style, className: className)
    }
    
    required init!(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        self.parseClassName = "Game"
        self.textKey = "Score"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.navigationItem.title = "Leaderboard"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionnOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    }
    
    
    
    override func queryForTable() -> PFQuery {
        let query:PFQuery = PFQuery(className: "Game")
        query.orderByDescending("Score")
        
        return query
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        var cell:PFTableViewCell = tableView.dequeueReusableCellWithIdentifier("scoreCell") as! PFTableViewCell
        
        cell.textLabel?.text = String(object?["Score"] as! Int)
        cell.detailTextLabel?.text = object?["userName"] as! String
    
        return cell
    }
    
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
}
