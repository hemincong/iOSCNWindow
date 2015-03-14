//
//  TodayViewController.swift
//  VPNSwitcher
//
//  Created by Manchung.Ho on 1/17/15.
//  Copyright (c) 2015 net.mincong. All rights reserved.
//

import UIKit
import NotificationCenter

let kKeychainServiceName = "VPNSwither";

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var tableView : UITableView!
    var items: [VPNProfile] = [VPNProfile]()
    
    @IBAction func disconnectBtnTap(AnyObject) {
        VPNManagerHelper.disconnection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view from its nib.
        preferredContentSize = CGSizeMake(0, 200)

        self.items = VPNProfileManager.sharedManager.getAllVPNProfile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.NewData)
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
        println("You selected cell #\(indexPath.row)!")
        
        if (self.lastIndexPath != nil) {
            var oldCell = tableView.cellForRowAtIndexPath(lastIndexPath)
            oldCell!.accessoryType = UITableViewCellAccessoryType.None
        }
        
        var newCell = tableView.cellForRowAtIndexPath(indexPath)
        newCell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        self.lastIndexPath = indexPath

        var vh = VPNManagerHelper(vp: items[indexPath.row] as VPNProfile)
        vh.initVPN()
    }
}
