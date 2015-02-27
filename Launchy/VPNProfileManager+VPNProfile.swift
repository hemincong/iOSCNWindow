//
// Created by Manchung.Ho on 2/22/15.
// Copyright (c) 2015 net.mincong. All rights reserved.
//

import Foundation
import CoreData

extension VPNProfileManager {
    func createVPNProfile() -> VPNProfile? {
        return NSEntityDescription.insertNewObjectForEntityForName("VPNProfile", inManagedObjectContext: self.managedObjectContext!) as? VPNProfile
    }

    func createVPNProfile(title: String, serverAddress: String, accountName: String) -> VPNProfile? {
        if let vp = createVPNProfile() {
            vp.title = title
            vp.serverAddress = serverAddress
            vp.accountName = accountName
            return vp
        }
        return nil
    }

    func createVPNProfileAndSave(title: String, serverAddress: String, accountName: String) -> Bool {
        if let vp = createVPNProfile(title, serverAddress: serverAddress, accountName: accountName) {
            var error: NSError?
            if !self.managedObjectContext!.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
                return false
            } else {
                self.saveContext()

                if !vp.objectID.temporaryID {

                    //VPNKeychainWrapper.setPassword(password, andSecret: password, forVPNID: vpn.ID)
                    /*
                    if allVPN().count == 0 {
                        VPNManager.sharedManager().activatedVPNDict = vpn.toDictionary()
                    }
                    */

                    println("New VPN saved.")
                }
                return true
            }
        }
        return false
    }

    func getAllVPNProfile() -> [VPNProfile] {
        var profiles = [VPNProfile]()

        var error: NSError?

        let fetchRequest = NSFetchRequest(entityName: "VPNProfile")

        // Execute the fetch request, and cast the results to an array of LogItem objects
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as [VPNProfile]? {
            profiles = fetchResults
        } else {
            println("cannot fetch vpns. \(error?.localizedDescription)")
        }
        return profiles
    }
}