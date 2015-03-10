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

    @NSManaged var accountName: String!
    @NSManaged var serverAddress: String!
    @NSManaged var title: String!

    var ID : String {
        return objectID.URIRepresentation().lastPathComponent!
    }

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        setValue(accountName, forKey: "accountName")
        setValue(serverAddress, forKey: "serverAddress")
        setValue(title, forKey: "title")
    }
}
