//
//  APIHelperclass.swift
//  MyContacts
//
//  Created by GLB-311-PC on 16/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import UIKit

class APIHelperclass: NSObject {
   
    static let sharedApiHelperClass = APIHelperclass()
    
    //get category response
    func getCountryList(completionHandler: @escaping ([Countries]?, NSError?) -> Void) -> Void {
        
      
        let url: URL?
        url = URL(string:ServerDomain.serviceDomain)!
        URLSessionManager.share.getRequest(with: url!) { (data, error)
            in
            if error != nil {
                completionHandler(nil, error)
            }
                
            else {
                do {
                    let response = try JSONDecoder().decode([Countries].self, from: data! as Data)
                    
                    completionHandler(response, error)
                } catch let error {
                    completionHandler([], error as NSError)
                }
            }
        }
    }
}
