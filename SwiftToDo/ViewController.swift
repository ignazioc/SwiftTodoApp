//
//  ViewController.swift
//  SwiftToDo
//
//  Created by Ignazio Calo on 03/03/15.
//  Copyright (c) 2015 IgnazioC. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var mainText: UILabel!
}

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var taskTableView: UITableView!
    var datastore: Array<Task> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskTableView.backgroundView = nil
        self.taskTableView.backgroundColor = AppTheme.redColor
    }
    
    override func viewWillAppear(animated: Bool) {
        self.datastore = Task.findAll()
        self.taskTableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TaskCell? =  tableView.dequeueReusableCellWithIdentifier("default_identifier", forIndexPath: indexPath) as? TaskCell
        
        if let constVar = cell {
            constVar.layoutMargins = UIEdgeInsetsZero
            constVar.preservesSuperviewLayoutMargins = false
            constVar.mainText?.text = self.datastore[indexPath.row].title.uppercaseString
            return constVar
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datastore.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.datastore.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let action1: UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Done!") { (action, indexPath) -> Void in
            self.datastore.removeAtIndex(indexPath.row)
            TaskStorage.saveAll(self.datastore)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        action1.backgroundColor = UIColor.grayColor()
        return [action1]
    }
    
    
}



