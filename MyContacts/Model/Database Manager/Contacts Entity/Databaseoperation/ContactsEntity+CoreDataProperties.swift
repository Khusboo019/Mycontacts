//
//  ContactsEntity+CoreDataProperties.swift
//  MyContacts
//
//  Created by GLB-311-PC on 17/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//
//

import Foundation
import CoreData


extension ContactsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactsEntity> {
        return NSFetchRequest<ContactsEntity>(entityName: "ContactsEntity")
    }

    @NSManaged public var country: String?
    @NSManaged public var email: String?
    @NSManaged public var firstname: String?
    @NSManaged public var id: Int64
    @NSManaged public var lastname: String?
    @NSManaged public var mobile: String?
    @NSManaged public var profileimage: NSData?

}
