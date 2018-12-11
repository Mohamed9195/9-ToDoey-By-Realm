//
//  InfoViewController.swift
//  ToDoeyByRealm
//
//  Created by mohamed hashem on 11/2/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import RealmSwift

class InfoViewController: UIViewController {
    
  let ream = try! Realm()
    var d = ""
    var Information : Item?{
        didSet{
            loadInfo()
        }
    }
    
    @IBOutlet weak var TitleOFItem: UILabel!
    @IBOutlet weak var InfoOfItem: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  loadInfo()
        TitleOFItem.text = (Information?.title)!
        InfoOfItem.text! = d
    
        // Do any additional setup after loading the view.
    }
    
    
    func loadInfo() {
        d = Information?.info?.InfoText ?? "no information"
        
        print(d)
      
      
        
    }

    @IBAction func deletInfo(_ sender: UIBarButtonItem) {
        InfoOfItem.text = "No Data to Delete"
    }
    
    @IBAction func RefrechData(_ sender: UIBarButtonItem) {
        
    
        try! ream.write {
            let infodata = Info()
            infodata.InfoText = InfoOfItem.text
            infodata.date = Date()
            
            
            Information?.info = infodata
         
           
            
           
        }
        
    }
    
    @IBAction func dissmis(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
