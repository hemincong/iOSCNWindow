//
//  VPNManagerHelper.swift
//  Launchy
//
//  Created by Manchung.Ho on 2/1/15.
//  Copyright (c) 2015 net.mincong. All rights reserved.
//

import Foundation
import NetworkExtension

public class VPNManagerHelper {

    let _vpn_manager = NEVPNManager.sharedManager()

    private var vpn_profile: VPNProfile

    func savePreferenceHandler(err: NSError?) -> Void {
        if let err = err {
            println("Failed to save profile: \(err.localizedDescription)")
        } else {
            var connectError: NSError?
            if _vpn_manager != nil {
                _vpn_manager.connection.startVPNTunnelAndReturnError(&connectError)

                if let connectErr = connectError {
                    println("Failed to start tunnel: \(connectErr.localizedDescription)")
                } else {
                    println("VPN tunnel started.")
                }
            }
        }
    }

    func loadPreferenceHandler(err: NSError?) -> Void {
        if (err != nil) {
            println("\(err)");
        } else {
            let p = NEVPNProtocolIPSec()
            println("\(vpn_profile.accountName)");
            p.username = vpn_profile.accountName;
            p.passwordReference = KeychainWrapper.getPassword(vpn_profile.ID)!
            p.authenticationMethod = NEVPNIKEAuthenticationMethod.SharedSecret;
            p.sharedSecretReference = KeychainWrapper.getSharedSecret(vpn_profile.ID)!
            p.serverAddress = vpn_profile.serverAddress
            println("\(vpn_profile.serverAddress)");
            p.useExtendedAuthentication = true;
            p.disconnectOnSleep = false;

            if (_vpn_manager != nil) {
                _vpn_manager.`protocol` = p;
                _vpn_manager.saveToPreferencesWithCompletionHandler(savePreferenceHandler);
            }
        }
    }

    init(vp: VPNProfile) {
        self.vpn_profile = vp
    }

    func initVPN() {
        if (_vpn_manager != nil) {
            _vpn_manager.loadFromPreferencesWithCompletionHandler(loadPreferenceHandler);

            var ruleList: [NEOnDemandRule] = [];
            ruleList.append(NEOnDemandRuleConnect());
            _vpn_manager.onDemandRules = ruleList;
        } else {
            println("vpn Manager not found");
        }
    }

    func vpnConfigChanged() {
        var startError: NSError?
        if (_vpn_manager != nil) {
            _vpn_manager.connection.startVPNTunnelAndReturnError(&startError);
            if startError != nil {
                println("connect error: \(startError)");
            } else {
                println("connect success");
            }
        }
    }

    class func disconnection() {
        if (NEVPNManager.sharedManager() != nil) {
            NEVPNManager.sharedManager().connection.stopVPNTunnel()
        }
    }
}
