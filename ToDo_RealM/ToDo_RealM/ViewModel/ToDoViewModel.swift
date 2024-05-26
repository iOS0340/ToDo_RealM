//
//  ToDoViewModel.swift
//  ToDo_RealM
//
//  Created by Bhavesh Patel on 25/05/24.
//

import Foundation
import RealmSwift

enum Event {
    case add
    case delete
    case edit
}

class ToDoViewModel {

    var listPerson : [Person] = [];
    
    var event : ((_ eve : Event) -> Void)?
    
    func getAllPerson() -> Void {
        listPerson = DatabaseHelper.shared.getAllDetails()
    }
    
    func add(person : Person) -> Void {
        listPerson.append(person)
        DatabaseHelper.shared.add(person: person)
        self.event?(.add)
    }
    
    func delete(person : Person) -> Void {
        let index = listPerson.firstIndex(of: person)
        
        listPerson.remove(at: index!)        
        DatabaseHelper.shared.delete(index: index!)
        self.event?(.delete)
    }
    
    func edit(person: Person, index : Int) -> Void {
        listPerson[index] = person
        DatabaseHelper.shared.update(updatedPerson: person, index: index)
        self.event?(.edit)
    }
}
