//
//  DatabaseHelper.swift
//  ToDo_RealM
//
//  Created by Bhavesh Patel on 25/05/24.
//

import Foundation
import RealmSwift

class DatabaseHelper {
    
//  Singlton Shared object
    static let shared = DatabaseHelper()
    
    // Open the local-only default realm
    let realm = try! Realm()
    
//    Method to fetch record from Database
    
    func getAllDetails() -> [Person] {
        let persons = realm.objects(Person.self)
        return Array(persons)
    }

//    Method to add record to Database
    
    func add(person : Person) -> Void {
        try! realm.write {
            realm.add(person)
        }
    }

//    Method to update database record
    
    func update(updatedPerson: Person, index : Int) -> Void{
        let person = getAllDetails()[index]
        try! realm.write {
            person.firstName = updatedPerson.firstName
            person.lastName = updatedPerson.lastName
        }
    }
    
//    Method to remove record from Database
    
    func delete(index : Int) -> Void {
        let person = getAllDetails()[index]
        try! realm.write {
            realm.delete(person)
        }
    }
    
    
    
}
