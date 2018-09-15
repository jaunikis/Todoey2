//
//  CategoryTableViewController.swift
//  Todoey2
//
//  Created by Marius Vorosilovas on 13/09/2018.
//  Copyright © 2018 Marius Vorosilovas. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    //let categoryArray = ["Pirmas","Antras","Trecias","Ketvirtas"]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      loadItems()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
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
                let newCategory = Category(context: self.context)
                newCategory.name=textField.text!
                self.categoryArray.append(newCategory)
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
    
    //MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categoryArray[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    
    func saveItems(){
        do {
            
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(request: NSFetchRequest<Category> = Category.fetchRequest()){
        do {
        categoryArray = try context.fetch(request)
        } catch {
        print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}

