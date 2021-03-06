//
//  ListarToDosViewController.swift
//  TODO LIST
//
//  Created by Isaias Fernandes on 22/06/17.
//  Copyright © 2017 Isaias Fernandes. All rights reserved.
//

import UIKit
import RealmSwift


class ListarToDosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ToDoTableViewControllerDelegate{

    
    //MARK: - Variaveis
    
    let dao = ToDoDAO()
    var toDoss: Results<Todo>! = nil
    
    @IBOutlet weak var label: UITextField!
    @IBOutlet weak var tableViewToDos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Listar To-Do's"
        self.toDoss = dao.getAll()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoss.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configurarTexto(da: cell, com: toDoss[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dao.delete(toDoss[indexPath.row])
            self.tableViewToDos.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let controller = segue.destination as! ToDoTableViewController
            controller.delegate = self
            if let indexPath = self.tableViewToDos.indexPath(for: sender as! UITableViewCell) {
                controller.editToDo = toDoss[indexPath.row]
                controller.indexEdit = indexPath.row
            }
        }
        if segue.identifier == "add" {
            let controller = segue.destination as! ToDoTableViewController
            controller.delegate = self
        }
    }
    

    func toDoTableViewController(_ controller: ToDoTableViewController, didFinishAdding toDo: Todo){
        //toDos.append(toDo)
        dao.insert(toDo: toDo)
        self.tableViewToDos.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func toDoTableViewController(_ controller: ToDoTableViewController, didFinishEditing toDo: Todo, indexEdit: Int){
        dao.update(oldToDo: self.toDoss[indexEdit], newTodo: toDo)
        let indexPath = IndexPath(row: indexEdit, section: 0)
        let cell = self.tableViewToDos.cellForRow(at: indexPath)
        configurarTexto(da: cell!, com: toDo)
        self.navigationController?.popViewController(animated: true)

    }
    
    func configurarTexto (da cell: UITableViewCell, com toDo: Todo) {
        let label = cell.viewWithTag(1000) as! UITextField
        label.text = toDo.nome
    }
}
