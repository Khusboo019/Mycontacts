//
//  ErrorManager.swift
//  MyContacts
//
//  Created by GLB-311-PC on 16/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import UIKit

extension NSError {
    
    class func xcodeError(_ errorMessage: String) -> NSError {
        return NSError(domain: "Local Error", code: 1001, userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }
    
    class func noDataError(_ errorCode: Int) -> NSError {
        return NSError(domain: "No Data found!!", code: 400, userInfo: [NSLocalizedDescriptionKey:"Sorry!!No data has been found"])
    }
    
    class func unknownError(_ errorCode: Int) -> NSError {
        return NSError(domain: "Something went wrong!!", code: 404, userInfo: [NSLocalizedDescriptionKey:"Something went wrong to fetch the data!!"])
    }
    //Validation Profile picture Error
    class func profileImageError(_ errorCode: Int) -> NSError {
        return NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey:"Please select a profile picture to proceed!"])
    }
    
    //Validation email Error
    class func emailError(_ errorCode: Int) -> NSError {
        return NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey:"Please enter a valid email"])
    }
    
    //Validation mobile Error
    class func mobileError(_ errorCode: Int) -> NSError {
        return NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey:"Please enter a valid mobile"])
    }
    
    //Validation country Error
    class func countryError(_ errorCode: Int) -> NSError {
        return NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey:"Please select your country"])
    }
    
    //Validation firstName Error
    class func firstNameError(_ errorCode: Int) -> NSError {
        return NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey:"Please enter your firstname"])
    }
    
    //Validation lastName Error
    class func lastNameError(_ errorCode: Int) -> NSError {
        return NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey:"Please enter your lastname"])
    }
    
    
}

