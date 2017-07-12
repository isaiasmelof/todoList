//
//  Todo.swift
//  TODO LIST
//
//  Created by Isaias Fernandes on 22/06/17.
//  Copyright © 2017 Isaias Fernandes. All rights reserved.
//

import Foundation
import RealmSwift

class Todo : Object {
    dynamic var nome : String = ""
    dynamic var descricao: String = ""
    dynamic var data: String = ""
    dynamic var id : String = UUID().uuidString
    
    convenience init(nome: String, descricao: String, data: String) {
        self.init()
        self.nome = nome
        self.descricao = descricao
        self.data = data
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
