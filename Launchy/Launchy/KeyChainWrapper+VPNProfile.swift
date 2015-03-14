//
// Created by Manchung.Ho on 3/3/15.
// Copyright (c) 2015 net.mincong. All rights reserved.
//

import Foundation

extension KeychainWrapper {
    class func setPassword(password: String, forVPNProfileID VPNProfileID: String) -> Bool {
        var key = "\(VPNProfileID)_password"
        KeychainWrapper.removeObjectForKey(key)
        return KeychainWrapper.setString(password, forKey:key)
    }

    class func setSharedSecret(sharedSecret: String, forVPNProfileID VPNProfileID: String) -> Bool {
        var key = "\(VPNProfileID)_sharedSecret"
        KeychainWrapper.removeObjectForKey(key)
        return KeychainWrapper.setString(sharedSecret, forKey: key)
    }

    class func setPassword(password: String, andSharedSecret sharedSecret: String, forVPNProfileID VPNProfileID: String) -> Bool {
        return setPassword(password, forVPNProfileID: VPNProfileID) &&
            setSharedSecret(sharedSecret, forVPNProfileID: VPNProfileID)
    }

    class func getPassword(VPNProfileID: String) -> NSData? {
        return KeychainWrapper.dataForKey("\(VPNProfileID)_password")
    }

    class func getSharedSecret(VPNProfileID: String) -> NSData? {
        return KeychainWrapper.dataForKey("\(VPNProfileID)_sharedSecret")
    }
}