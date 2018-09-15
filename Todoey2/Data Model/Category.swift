//
//  Category.swift
//  Todoey2
//
//  Created by Marius Vorosilovas on 15/09/2018.
//  Copyright © 2018 Marius Vorosilovas. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name: String = ""
    let items = List<Item2>()
}
