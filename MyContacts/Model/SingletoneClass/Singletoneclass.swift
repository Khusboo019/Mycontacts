//
//  Singletoneclass.swift
//  MyContacts
//
//  Created by GLB-311-PC on 16/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import Foundation
class SingletoneClass {
    
    // MARK: - Properties
    
    static let sharedSingletone = SingletoneClass()
    var countryListArray=[Countries]()
    var contactArray = [ContactsEntity]()
}

