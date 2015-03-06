//
//  DetailViewController.swift
//  SwiftToDo
//
//  Created by Ignazio Calo on 05/03/15.
//  Copyright (c) 2015 IgnazioC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var taskDesc: UITextField!
    
    @IBAction func saveBtnPressed(sender: UIButton) {
        let t = Task()
        t.title = self.taskDesc.text
        t.save()
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    override func viewWillAppear(animated: Bool) {
        
        self.taskDesc.becomeFirstResponder()
        self.taskDesc.text = ""
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}