//
//  ViewController.swift
//  CNWindow
//
//  Created by Manchung.Ho on 11/8/14.
//  Copyright (c) 2014 net.mincong. All rights reserved.
//

import UIKit
import NetworkExtension

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"vpnConfigChanged", name:NEVPNConfigurationChangeNotification, object:nil);
        KeychainService.saveToken("", userAccount:"mincong_vpn")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initVPN() {
        let vpn_manager = NEVPNManager.sharedManager();
        if (vpn_manager == nil) {
            println("vpn Manager not found");
            return;
        }
        
        func savePreferenceHandler (err:NSError?) -> Void {
            if (err != nil) {
                println(err?.localizedDescription);
            }
        }
        
        func loadPreferenceHandler (err:NSError?) -> Void {
            if (err != nil) {
                println("\(err)");
            } else {
                let p = NEVPNProtocolIPSec()
                p.username = "mincong";
                p.passwordReference = KeychainService.loadToken("mincong_vpn")?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false);
                p.authenticationMethod = NEVPNIKEAuthenticationMethod.Certificate;
                p.disconnectOnSleep = false;
                p.identityData = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("clientCert", ofType: "p12")!);
                p.identityDataPassword = KeychainService.loadToken("mincong_vpn");
                p.localIdentifier = ""
                p.serverAddress = ""
                p.remoteIdentifier = ""
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

