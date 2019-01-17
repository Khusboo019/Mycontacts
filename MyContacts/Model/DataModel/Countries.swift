//
//  Countries.swift
//  MyContacts
//
//  Created by GLB-311-PC on 16/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import Foundation

struct Countries:Decodable {
    let name:String?
    let alpha2Code:String?
}

struct filterCountryList {
    let countryFilter:[Countries]?
}
