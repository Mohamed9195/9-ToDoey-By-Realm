//
//  FirstTableViewController.swift
//  ToDoeyByRealm
//
//  Created by mohamed hashem on 11/1/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework



class FirstTableViewController: SwipeViewController {

    let realm = try! Realm()
    
    // autot apdate
    var categoryArray: Results<Category>?
    var path = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
      
        let longPressgester = UILongPressGestureRecognizer(target: self, action: #selector(editCategory))
        tableView.addGestureRecognizer(longPressgester)
        
        loadCategory()
        tableView.rowHeight = 65.0
        
        tableView.separatorStyle = .none
        
        
    }

    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        var textCell = UITextField()
        let alert = UIAlertController(title: "Add New Todey Category", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            if textCell.text! != "" {
                
                
                let newCategory = Category()
                newCategory.name = textCell.text!
                newCategory.colour = UIColor.randomFlat.hexValue()
                
                self.save(category: newCategory)
                
            }
            
        }))
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Creat new Category"; textCell = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return categoryArray?.count ?? 1
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name  ??  "No Categories Add Yet"
        
        cell.backgroundColor = UIColor(hexString: categoryArray?[indexPath.row].colour ?? "1BA3E5")
        cell.textLabel?.textColor = (UIColor(contrastingBlackOrWhiteColorOn:cell.backgroundColor!, isFlat:true))
        return cell
    }
    
    
    
    
    
    // MARK: - Table view data delegate
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
        path = Int(indexPath.row)
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! secoundTableViewController
       
        destinationVC.selectedCategory = categoryArray?[path]
        
    }
    
    
    
    
    
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
//        if editingStyle == .delete {
//                    if let item = categoryArray?[indexPath.row] {
//                            do{
//                                try realm.write {
//                                     realm.delete(item.items) // delete refernce to data in item table
//                                    realm.delete(item)
//                                }
//
//                            }catch{
//                                print("Error Savinge done status\(error)")
//                            }
//                    }
//
//                    tableView.reloadData()
//        }
//    }
//
    
    
    
    
    
    // MARK: - Table view Mainpulation
    
    // save category
    func save(category: Category) {
        do{
            try  realm.write {
                  realm.add(category)
            }
            
        }catch{
            
            print("Error in reading data : \(error)")
        }
        tableView.reloadData()
    }
    
    // reade category
    func loadCategory() {
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    //MARK: - Delete Data from swipe
    
    override  func DeletModel(at indexPath: IndexPath) {
        
                    if let item = self.categoryArray?[indexPath.row] {
                        do{
                            try self.realm.write {
                                self.realm.delete(item.items) // delete refernce to data in item table
                                self.realm.delete(item)
                            }
        
                        }catch{
                            print("Error Savinge done status\(error)")
                        }
                    }
        
        
    }
    
 
  
    
    
    
    @objc func editCategory(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let touchPoint = gestureRecognizer.location(in: self.tableView)
            if let indexpath = tableView.indexPathForRow(at: touchPoint) {
                
                var textcell = UITextField()
                let alert = UIAlertController(title: "Edit caegory", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
                    
                        if textcell.text! != "" {
                        
                            do{
                                try self.realm.write {
                                    self.categoryArray?[indexpath.row].name  = textcell.text!
                                }
                            }catch{
                                print("Error in edit data")
                            }
                            self.tableView.reloadData()

                    }
                    
                }))
                
                
                present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    
    
    
}


