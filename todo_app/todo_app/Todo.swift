//
//  Todo.swift
//  todo_app
//
//  Created by Vinicius on 04/07/20.
//  Copyright © 2020 Vinicius. All rights reserved.
//


struct Todo: Codable{
    var name: String
    var date: String
    var done: Bool = false
}
