//
//  Todo.swift
//  TODO LIST
//
//  Created by Isaias Fernandes on 22/06/17.
//  Copyright © 2017 Isaias Fernandes. All rights reserved.
//

import Foundation

class Todo : NSObject {
    var nome : String
    var descricao: String
    var data: String
    
    init(nome: String, descricao: String, data: String) {
        self.nome = nome
        self.descricao = descricao
        self.data = data
    }
}
