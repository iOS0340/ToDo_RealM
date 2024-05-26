//
//  DatabaseHelper.swift
//  ToDo_RealM
//
//  Created by Bhavesh Patel on 25/05/24.
//

import Foundation
import RealmSwift

class DatabaseHelper {
    static let shared = DatabaseHelper()
    
    // Open the local-only default realm
    let realm = try! Realm()
    
    func getAllDetails() -> [Person] {
        let persons = realm.objects(Person.self)
        return Array(persons)
    }
    
    func add(person : Person) -> Void {
        try! realm.write {
            realm.add(person)
        }
    }
    
    func update(updatedPerson: Person, index : Int) -> Void{
        let person = getAllDetails()[index]
        try! realm.write {
            person.firstName = updatedPerson.firstName
            person.lastName = updatedPerson.lastName
        }
    }
    
    func delete(index : Int) -> Void {
        let person = getAllDetails()[index]
        try! realm.write {
            realm.delete(person)
        }
    }
    
    
    
}
