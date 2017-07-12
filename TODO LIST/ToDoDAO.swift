//
//  ToDoDAO.swift
//  TODO LIST
//
//  Created by Isaias Fernandes on 12/07/17.
//  Copyright © 2017 Isaias Fernandes. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoDAO {
    //BANCO
    private let realm: Realm
    
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func update (oldToDo: Todo, newTodo: Todo){
        try! realm.write {
            oldToDo.nome = newTodo.nome
            oldToDo.descricao = newTodo.descricao
            oldToDo.data = newTodo.data
        }
    }
    
    func insert (toDo: Todo){
        try! realm.write {
            realm.add(toDo)
        }
    }
    
    func delete (_ toDo: Todo){
        try! realm.write {
            realm.delete(toDo)
        }
    }
    
    func getAll() -> Results<Todo> {
        return realm.objects(Todo.self)
    }
}
