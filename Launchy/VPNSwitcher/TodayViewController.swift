//
//  TodayViewController.swift
//  VPNSwitcher
//
//  Created by Manchung.Ho on 1/17/15.
//  Copyright (c) 2015 net.mincong. All rights reserved.
//

import UIKit
import NotificationCenter

import NetworkExtension

let kKeychainServiceName = "VPNSwither";

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var button : UIButton!
    
    @IBAction func ButtonTap(AnyObject) {
        initVPN();
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
          preferredContentSize = CGSizeMake(0, 50)
        // Do any additional setup after loading the view from its nib.
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
    
    
    func initVPN() {
        let vpn_manager = NEVPNManager.sharedManager();
        if (vpn_manager == nil) {
            println("vpn Manager not found");
            return;
        }
        
        func savePreferenceHandler (err:NSError?) -> Void {
            if let err = err {
                println("Failed to save profile: \(err.localizedDescription)")
            }
            else
            {
                var connectError : NSError?
                NEVPNManager.sharedManager().connection.startVPNTunnelAndReturnError(&connectError)
                
                if let connectErr = connectError {
                    println("Failed to start tunnel: \(connectErr.localizedDescription)")
                } else {
                    println("VPN tunnel started.")
                }
            }
        }
        
        func loadPreferenceHandler (err:NSError?) -> Void {
            if (err != nil) {
                println("\(err)");
            } else {
                let p = NEVPNProtocolIPSec()
                p.username = "";
                p.passwordReference = KeychainWrapper.dataForKey("vpn_swither_pwd")
                p.authenticationMethod = NEVPNIKEAuthenticationMethod.SharedSecret;
                p.sharedSecretReference = KeychainWrapper.dataForKey("vpn_switcher_secret")
                p.serverAddress = ""
                p.useExtendedAuthentication = true;
                p.disconnectOnSleep = false;
                
                vpn_manager.`protocol` = p;
                vpn_manager.saveToPreferencesWithCompletionHandler(savePreferenceHandler);
            }
        }
        
        vpn_manager.loadFromPreferencesWithCompletionHandler(loadPreferenceHandler);
        
        
        
        var ruleList:[NEOnDemandRule] = [];
        ruleList.append(NEOnDemandRuleConnect());
        if vpn_manager != nil {
            vpn_manager.onDemandRules = ruleList;
        }
        
        vpn_manager.connection
    }
    
    func vpnConfigChanged() {
        var startError : NSError?
        NEVPNManager.sharedManager().connection.startVPNTunnelAndReturnError(&startError);
        if startError != nil {
            println("connect error: \(startError)");
        } else {
            println("connect success");
        }
    }

    
}
