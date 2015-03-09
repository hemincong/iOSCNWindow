//
//  VPNProfile.swift
//  Launchy
//
//  Created by Manchung.Ho on 2/21/15.
//  Copyright (c) 2015 net.mincong. All rights reserved.
//

import Foundation
import CoreData

@objc(VPNProfile)
class VPNProfile: NSManagedObject {

    @NSManaged var accountName: String
    @NSManaged var serverAddress: String
    @NSManaged var title: String

    var ID : String {
        return objectID.URIRepresentation().lastPathComponent!
    }

    class func createInManagedObjectContext(moc: NSManagedObjectContext,
                                            title: String,
                                            serverAddress: String,
                                            accountName: String) -> VPNProfile? {
        if let newItem = NSEntityDescription.insertNewObjectForEntityForName("VPNProfile", inManagedObjectContext: moc) as? VPNProfile {
            newItem.title = title
            newItem.serverAddress = serverAddress
            newItem.accountName = accountName
            return newItem
        }
        return nil
    }
}
