//
//  Info.swift
//  ToDoeyByRealm
//
//  Created by mohamed hashem on 11/2/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import Foundation
import RealmSwift

class Info: Object {
    @objc dynamic var InfoText: String = ""
    @objc dynamic var date: Date = Date()
    
}
