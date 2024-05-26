//
//  Person.swift
//  ToDo_RealM
//
//  Created by Bhavesh Patel on 25/05/24.
//

import Foundation
import RealmSwift

class Person: Object {
    @Persisted(primaryKey: true) var id : ObjectId
    @Persisted var firstName : String = ""
    @Persisted var lastName : String = ""
    
    convenience init(firstName : String, lastName : String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
    }
    
}
