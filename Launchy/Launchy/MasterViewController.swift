//
//  ViewController.swift
//  CNWindow
//
//  Created by Manchung.Ho on 11/8/14.
//  Copyright (c) 2014 net.mincong. All rights reserved.
//

import UIKit
import NetworkExtension
import CoreData

class MasterViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    var items: [VPNProfile] = [VPNProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            /*
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
                (segue.destinationViewController as DetailViewController).detailItem = object
            }
*/
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.items[indexPath.row].title
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    var lastIndexPath: NSIndexPath!
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        if (self.lastIndexPath != nil) {
            if let oldCell = tableView.cellForRowAtIndexPath(lastIndexPath){
                oldCell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
        if let newCell = tableView.cellForRowAtIndexPath(indexPath) {
            newCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        self.lastIndexPath = indexPath
    }
}

