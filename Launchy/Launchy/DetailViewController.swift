//
//  DetailViewController.swift
//  Launchy
//
//  Created by Manchung.Ho on 2/26/15.
//  Copyright (c) 2015 net.mincong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleTF : UITextField!
    @IBOutlet weak var serverAddressTF : UITextField!
    @IBOutlet weak var sharedSecretTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    @IBOutlet weak var accountNameTF : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        var rightButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("done"))
        self.navigationItem.rightBarButtonItem = rightButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func done() {
        self.navigationController?.popViewControllerAnimated(false)
        VPNProfileManager.sharedManager.createVPNProfileAndSave(titleTF.text, serverAddress: serverAddressTF.text, accountName: accountNameTF.text)
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
