//
//  Contacts.swift
//  MyContacts
//
//  Created by Khusboo Suhasini Preety on 14/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import Foundation

struct Contacts {
    var id:Int64?
    var firstname:String?
    var lastname:String?
    var email:String?
    var mobile:String?
    var profileimage:NSData?
    var location:String?
    var dictionaryRepresentation: [String: Any] {
        return [
            "id" : id as Any,
            "firstname" : firstname as Any,
            "lastname" : lastname as Any,
            "email" : email!,
            "mobile" : mobile as Any,
            "profileimage" : profileimage as Any,
            "location" : location as Any,
        ]
    }
}
