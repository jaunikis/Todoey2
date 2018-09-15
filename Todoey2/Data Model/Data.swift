//
//  Data.swift
//  Todoey2
//
//  Created by Marius Vorosilovas on 15/09/2018.
//  Copyright © 2018 Marius Vorosilovas. All rights reserved.
//

import Foundation
import RealmSwift


class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
