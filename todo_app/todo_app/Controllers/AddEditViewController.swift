//
//  AddEditViewController.swift
//  todo_app
//
//  Created by Vinicius on 03/07/20.
//  Copyright © 2020 Vinicius. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var home: HomeTableViewController?
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var dpTodoDate: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    var todos: [Todo]?
    var todo: Todo?
    var todoIndex = -1
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    func initialSetup(){

        dpTodoDate.minimumDate = Date()
        
        if let object = todo{
            tfName?.text = object.name
            
            let dateString = object.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let date = dateFormatter.date(from: dateString)
            self.date = object.date
            
            dpTodoDate.setDate(date!, animated: false)
        }else{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let somedateString = dateFormatter.string(from: dpTodoDate.date)
            
            date = somedateString
        }
        
    }
    
    @IBAction func onSave(_ sender: Any) {
        
        
        guard let name = tfName.text else{
            return
        }
        
        let newTodo: Todo = Todo.init(name: name, date: date!, done: false)
        
        if(todoIndex == -1){
            if (todos != nil){
                todos?.append(newTodo)
            }else{
                todos = [newTodo]
            }
        }else{
            todos?[todoIndex] = newTodo
        }
        todos?.sort(by: {$0.date < $1.date})
        if let encoded = try? JSONEncoder().encode(todos){
            defaults.set(encoded, forKey: "todos")
        }
        
        self.home!.loadTodos()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let somedateString = dateFormatter.string(from: sender.date)
        date = somedateString
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
