//
//  TaskTableViewController.swift
//  todo_app
//
//  Created by Vinicius on 04/07/20.
//  Copyright © 2020 Vinicius. All rights reserved.
//

import UIKit


class HomeTableViewController: UITableViewController {
    
    var todos: [Todo]?
    
    
    @IBOutlet weak var newTodoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTodos()
    }
    
    private func retrieveTodos() {
        do {
            let storedObjItem = UserDefaults.standard.object(forKey: "todos")
            if(storedObjItem != nil) {
                let storedItems = try JSONDecoder().decode([Todo].self, from: storedObjItem as! Data)
                self.todos = storedItems
            }
        } catch let err {
            print(err)
        }
    }
    
    func loadTodos(){
        retrieveTodos()
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let tasks = self.todos {
            return tasks.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        
        if let tasks = self.todos {
            cell.prepare(with: tasks[indexPath.row])
            
            cell.clipsToBounds = true
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = cell.frame.height / 7
            cell.layer.masksToBounds = true
        }
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    func toAddEditScreen(_ todo: Todo?,_ todoIndex: Int?) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        let addEditViewController = AddEditViewController(nibName: "AddEditViewController", bundle: nil)
        addEditViewController.home = self
        addEditViewController.todos = todos
        addEditViewController.todo = todo
        if let index = todoIndex{
            addEditViewController.todoIndex = index
        }
        present(addEditViewController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if let tasks = self.todos{
            var newTodos = tasks
            newTodos.remove(at: indexPath.row)
            if let encoded = try? JSONEncoder().encode(newTodos){
                
                UserDefaults.standard.set(encoded, forKey: "todos")
            }
        }
        loadTodos()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var todo: Todo?
        if let tasks = self.todos{
            todo = tasks[indexPath.row]
            toAddEditScreen(todo, indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    @IBAction func newTodo(_ sender: Any) {
        toAddEditScreen(nil, nil)
    }
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
