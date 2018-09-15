//
//  CategoryTableViewController.swift
//  Todoey2
//
//  Created by Marius Vorosilovas on 13/09/2018.
//  Copyright © 2018 Marius Vorosilovas. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("add button pressed")
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            print("clicked add Category on alert")
            print(textField.text!)
            if textField.text != "" {
                let newCategory = Category()
                newCategory.name=textField.text!
//                self.categories.append(newCategory)
                self.save(category: newCategory)
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
    
    //MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added"
        return cell
    }
    
    
    func save(category: Category){
        do {
            
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
}

