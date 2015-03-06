//
//  Model.swift
//  SwiftToDo
//
//  Created by Ignazio Calo on 03/03/15.
//  Copyright (c) 2015 IgnazioC. All rights reserved.
//

import Foundation
import UIkit

struct AppTheme {
    static let redColor = UIColor(red:0.79, green:0.11, blue:0.21, alpha:1)
}

class TaskStorage {
    class func findAll() -> Array<Task> {
        var db:  Array? = NSUserDefaults.standardUserDefaults().arrayForKey("swift_todo_example")

        if let constVar = db {
            return constVar.map(){(x: AnyObject)  in
                if let d = x as? Dictionary<String, String> {
                    return Task(dictionary: d)
                }
                else {
                    return Task()
                }
            }
        } else {
            return []
        }
    }
    
    class func save(t: Task) -> () {
        
        var db:  Array? = NSUserDefaults.standardUserDefaults().arrayForKey("swift_todo_example")
        if var constant = db {
            constant.append(t.toDict())
            NSUserDefaults.standardUserDefaults().setObject(constant, forKey: "swift_todo_example")
        } else {
            NSUserDefaults.standardUserDefaults().setObject([t.toDict()], forKey: "swift_todo_example")
        }
    }
    
    class func saveAll(list: [Task]) -> () {
        let db: [Dictionary<String, String>] = list.map(){(t:Task) in return t.toDict()}
        NSUserDefaults.standardUserDefaults().setObject(db, forKey: "swift_todo_example")
    }
}


class Task {
    var title: NSString = ""
    
    init() {
    }
    
    init(dictionary  : Dictionary<String, String>) {
        if let title = dictionary["title"] {
            self.title = title
        }
    }

    func toDict() -> Dictionary<String, String> {
        return ["title" : self.title]
    }
    
    
    func save() -> () {
        TaskStorage.save(self)
    }
    
    class func findAll() -> Array<Task> {
        return TaskStorage.findAll()
    }
    
    
}