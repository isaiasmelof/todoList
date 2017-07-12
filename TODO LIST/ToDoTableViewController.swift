//
//  ToDoTableViewController.swift
//  TODO LIST
//
//  Created by Isaias Fernandes on 22/06/17.
//  Copyright © 2017 Isaias Fernandes. All rights reserved.
//

import UIKit

protocol ToDoTableViewControllerDelegate: class {
    func toDoTableViewController(_ controller: ToDoTableViewController, didFinishAdding toDo: Todo)
    func toDoTableViewController(_ controller: ToDoTableViewController, didFinishEditing toDo: Todo, indexEdit: Int)
}

class ToDoTableViewController: UITableViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var nomeTxtField: UITextField!
    @IBOutlet weak var descricaoTxtView: UITextView!
    @IBOutlet weak var data: UITextField!
    
    //MARK: - Variaveis
    weak var delegate : ToDoTableViewControllerDelegate?
    
    var dataDatePicker: UIDatePicker = UIDatePicker()
    var editToDo : Todo?
    var indexEdit: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        self.nomeTxtField.becomeFirstResponder()
        if let toDo = self.editToDo {
            populateFieldsToDo(toDo: toDo)
            self.navigationItem.title = "Editar To-Do"
        }else{
            self.navigationItem.title = "Adicionar To-Do"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - METODOS DELEGATE - VIEW
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ToDoTableViewController.adicionar))
    }
    
    
    func adicionar () {
        
        if  self.editToDo != nil {
            let x = Todo()
            x.nome  = nomeTxtField.text!
            x.descricao = descricaoTxtView.text
            x.data = data.text!
            delegate?.toDoTableViewController(self, didFinishEditing: x, indexEdit: indexEdit!)
        }else {
            let todo = Todo(nome: self.nomeTxtField.text!, descricao: self.descricaoTxtView.text, data: self.data.text!)
            delegate?.toDoTableViewController(self, didFinishAdding: todo)
        }
        
    }
    
    func createDatePicker(){
        //formato do date picker
        self.dataDatePicker.datePickerMode = .date
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Concluído", style: .done, target: nil, action: #selector(donePressedData))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        self.data.inputAccessoryView = toolbar
        
        //atribuir o date picker no text field
        self.data.inputView = dataDatePicker
    }

    func donePressedData(){
        //formato da data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.data.text = dateFormatter.string(from: dataDatePicker.date)
        self.view.endEditing(true)
    }
    
    func populateFieldsToDo (toDo: Todo) {
        self.nomeTxtField.text = toDo.nome
        self.descricaoTxtView.text = toDo.descricao
        self.data.text = toDo.data
    }
    
    
    

}
