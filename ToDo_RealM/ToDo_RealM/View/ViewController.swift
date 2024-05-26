//
//  ViewController.swift
//  ToDo_RealM
//
//  Created by Bhavesh Patel on 25/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView : UITableView!;
    var viewModel = ToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
        self.updateOnAction()
        
    }
    
    @IBAction func addPerson(sender : UIBarButtonItem) -> Void {
        addOrEditPerson(person: nil)
    }
    
}

extension ViewController {
    
//    Configure First Screen (Table view)
    
    func configuration() -> Void {
        self.tblView.register(UINib.init(nibName: "ToDoItem", bundle: nil), forCellReuseIdentifier: "todoItem")
        self.viewModel.getAllPerson()
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    
//    Method called when any operation occur on database level.
    
    func updateOnAction() -> Void {
        self.viewModel.event = { (event) in
            switch event {
                case .add:
                    self.tblView.reloadData()
                    break;
                case .delete:
                    break;
                case .edit:
                    self.tblView.reloadData()
                    break
            }
        }
    }
    
    func addOrEditPerson(person : Person?, index : Int? = 0) -> Void {
        let alert = UIAlertController.init(title: person != nil ? "Edit" : "Add", message: person != nil ? "Edit person" : "Add person", preferredStyle: .alert)
        
        alert.addTextField { (firstName) in
            firstName.placeholder = person?.firstName ?? "First Name"
        }
        
        alert.addTextField { (lastName) in
            lastName.placeholder = person?.lastName ?? "Last Name"
        }
        
        let saveAction = UIAlertAction.init(title: person != nil ? "Update" : "Save", style: .default) { (saveAction) in
            let objPerson = Person(firstName: alert.textFields![0].text ?? "", lastName: alert.textFields![1].text ?? "")
            
            person != nil ? self.viewModel.edit(person: objPerson, index: index!) :
            self.viewModel.add(person: objPerson)
        }
        
        let cancelAction  = UIAlertAction.init(title: "Cancel", style: .default) { (cancelAction) in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true) {
            
        }
    }
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listPerson.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath) as? ToDoItem
        
        cell?.person = self.viewModel.listPerson[indexPath.row]
        return cell ?? UITableViewCell.init();
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction.init(style: .destructive, title: "Delete") { (delete, view, handler) in
            
            self.viewModel.delete(person: self.viewModel.listPerson[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
        let edit = UIContextualAction.init(style: .normal, title: "Edit") { (edit, view, handler) in
            self.addOrEditPerson(person: self.viewModel.listPerson[indexPath.row], index: indexPath.row)
            self.tblView.reloadData()
        }
        
        let swipeAction = UISwipeActionsConfiguration.init(actions: [delete, edit]);
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
}
