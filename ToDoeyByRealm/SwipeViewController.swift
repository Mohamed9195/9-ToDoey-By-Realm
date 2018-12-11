//
//  SwipeViewController.swift
//  ToDoeyByRealm
//
//  Created by mohamed hashem on 11/2/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeViewController: UITableViewController  , SwipeTableViewCellDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
       
        
        return cell    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            
            self.DeletModel(at: indexPath)

        }
        
        
        let infoAction = SwipeAction(style: .destructive, title: "Info") { action, indexPath in
            
            self.infoModel(at : indexPath)
      
            
        }
    
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        infoAction.image = UIImage(named: "More")
        infoAction.backgroundColor = UIColor.blue
        
        
        return [deleteAction, infoAction ]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func DeletModel(at indexPath: IndexPath) {
 
    }
    
    func infoModel(at indexPath: IndexPath) {
        
    }
}


