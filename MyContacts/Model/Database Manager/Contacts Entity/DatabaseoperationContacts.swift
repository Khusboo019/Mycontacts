//
//  DatabaseoperationContacts.swift
//  MyContacts
//
//  Created by Khusboo Suhasini Preety on 14/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import Foundation
import CoreData

class DatabaseoperationContacts:NSObject {
    static let sharedDatabaseoperationcontacts = DatabaseoperationContacts()
    let context = CoreDataDBModel.sharedCoredataModel.persistentContainer.viewContext
    var customContacts = [ContactsEntity]()
    typealias Completionhandler = (_ success:Bool,_ contactsFetched:[ContactsEntity]) -> Void
 
    func fetchAllContacts(completionHandler:Completionhandler){
        do{
            customContacts = try context.fetch(ContactsEntity.fetchRequest())
            completionHandler(true,customContacts)
        }catch{
            print("Database error")
            completionHandler(false,customContacts)
        }
        
    }
    
}
