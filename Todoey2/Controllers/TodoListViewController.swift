//
//  TodoListViewController.swift
//  Todoey2
//
//  Created by Marius Vorosilovas on 04/09/2018.
//  Copyright © 2018 Marius Vorosilovas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TodoListViewController:  UITableViewController {
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    var itemArray = [Item2]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //var itemArray = ["pirmas","antras","trecias","Ketvirtas","Penktas 5","Sestas 66666","sept sdkj jskd ash jkhf kjhs","astuntas 8888"]
    //let defaults = UserDefaults.standard
    
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let newItem = Item()
//        newItem.title = "Find Mike@"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "bla bla"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "trecias 3"
//        itemArray.append(newItem3)
        
        loadItems()
        
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
     
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row].title!)
        
        //  UPDATE ITEMS
        //        itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
        // DELETE ITEMS
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        saveItems()
        
        //tableView.reloadData()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        print("add pressed")
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("clicked add item on alert")
            print(textField.text!)
            if textField.text != "" {
                
                let newItem = Item2(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
                newItem.parentCategory = self.selectedCategory
                
                self.itemArray.append(newItem)
                //self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.saveItems()
                
                
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    func saveItems(){
        do {
            
            try context.save()
        } catch {
           print("error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(request: NSFetchRequest<Item2> = Item2.fetchRequest(), predicate: NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button clicked")
        let request: NSFetchRequest<Item2> = Item2.fetchRequest()
        //print(searchBar.text!)
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(request: request, predicate: predicate)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        loadItems()
    }
    
    
}


