//
//  DetailViewController.swift
//  Launchy
//
//  Created by Manchung.Ho on 2/26/15.
//  Copyright (c) 2015 net.mincong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var serverAddressTF: UITextField!
    @IBOutlet weak var sharedSecretTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var accountNameTF: UITextField!

    internal var detailItem: VPNProfile? = nil

    private var magicPassword: String? = "9FAs&&^%$#@#vv!czsg"

    override func viewDidLoad() {
        super.viewDidLoad()

        var rightButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("done"))
        self.navigationItem.rightBarButtonItem = rightButton
    }

    override func viewWillAppear(animated: Bool) {
        if let item = detailItem {
            titleTF.text = item.title
            serverAddressTF.text = item.serverAddress
            accountNameTF.text = item.accountName
            passwordTF.text = magicPassword
            sharedSecretTF.text = magicPassword
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func done() {

        if let vp = VPNProfileManager.sharedManager.createVPNProfileAndSave(titleTF.text, serverAddress: serverAddressTF.text, accountName: accountNameTF.text) {

            if let password = passwordTF.text {
                if password != magicPassword {
                    KeychainWrapper.setPassword(password, forVPNProfileID: vp.ID)
                }
            }

            if let sercet = sharedSecretTF.text {
                if sercet != magicPassword {
                    KeychainWrapper.setSharedSecret(sercet, forVPNProfileID: vp.ID)
                }
            }
        }

        self.navigationController?.popViewControllerAnimated(false)
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
