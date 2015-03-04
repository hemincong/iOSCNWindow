//
// Created by Manchung.Ho on 3/3/15.
// Copyright (c) 2015 net.mincong. All rights reserved.
//

import Foundation

extension KeychainWrapper {
    class func setPassword(password: String, forVPNProfileID VPNProfileID: String) -> Bool {
        KeychainWrapper.removeObjectForKey("\(VPNProfileID)_password")
        return KeychainWrapper.setString(password, forKey: VPNProfileID)
    }

    class func setSharedSecret(sharedSecret: String, forVPNProfileID VPNProfileID: String) -> Bool {
        KeychainWrapper.removeObjectForKey("\(VPNProfileID)_sharedSecret")
        return KeychainWrapper.setString(sharedSecret, forKey: VPNProfileID)
    }

    class func setPassword(password: String, andSharedSecret sharedSecret: String, forVPNProfileID VPNProfileID: String) -> Bool {
        return setPassword(password, forVPNProfileID: VPNProfileID) &&
            setSharedSecret(sharedSecret, forVPNProfileID: VPNProfileID)
    }

    class func getPassword(VPNProfileID: String) -> String? {
        return KeychainWrapper.dataForKey("\(VPNProfileID)_password")
    }

    class func getSharedSecret(VPNProfileID: String) -> String? {
        return KeychainWrapper.dataForKey("\(VPNProfileID)_sharedSecret")
    }
}