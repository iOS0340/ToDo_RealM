//
//  ToDoItem.swift
//  ToDo_RealM
//
//  Created by Bhavesh Patel on 25/05/24.
//

import Foundation
import UIKit

class ToDoItem: UITableViewCell {
    
    var person : Person? {
        didSet {
            self.configureCell()
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        self.textLabel?.text = person?.firstName
        self.detailTextLabel?.text = person?.lastName
    }
}
