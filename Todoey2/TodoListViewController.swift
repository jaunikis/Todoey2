//
//  TodoListViewController.swift
//  Todoey2
//
//  Created by Marius Vorosilovas on 04/09/2018.
//  Copyright © 2018 Marius Vorosilovas. All rights reserved.
//

import Foundation
import UIKit

class TodoListViewController:  UITableViewController {
    
    var itemArray = ["pirmas","antras","trecias","Ketvirtas","Penktas 5","Sestas 66666","sept sdkj jskd ash jkhf kjhs","astuntas 8888"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        print("add pressed")
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("clicked add item on alert")
            print(textField.text!)
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    
}
