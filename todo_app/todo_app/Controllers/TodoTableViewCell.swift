//
//  TodoTableViewCell.swift
//  todo_app
//
//  Created by Vinicius on 04/07/20.
//  Copyright © 2020 Vinicius. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoStatusView: UIView!
    @IBOutlet weak var lbTodoName: UILabel!
    @IBOutlet weak var lbTodoDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepare(with todo: Todo){

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let now = dateFormatter.string(from: Date())
        
        let todoDate = todo.date
        if(todo.done == true){
            todoStatusView.backgroundColor = UIColor.green
        }else if(todoDate == now){
            todoStatusView.backgroundColor = UIColor.yellow
        }else if (todoDate < now){
            todoStatusView.backgroundColor = UIColor.red
        }
        
        
//        todoStatusView.backgroundColor = UIColor.red
        lbTodoName.text = todo.name
        lbTodoDate.text = todo.date
        
    }
}
