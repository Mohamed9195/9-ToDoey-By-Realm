//
//  Category.swift
//  ToDoeyByRealm
//
//  Created by mohamed hashem on 11/1/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colour : String = ""
    let items = List<Item>()
}
