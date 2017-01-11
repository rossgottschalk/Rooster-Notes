//
//  ViewController.swift
//  Rooster Notes
//
//  Created by Ross Gottschalk on 12/15/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate
 {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noteTakingTextFieldBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var noteTakingTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var notes = [String]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
        
        //scrollView.keyboardDismissMode = .interactive
        
        //scrollView.keyboardDismissMode = .interactive
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit
    {
        //if you add observers, you HAVE TO remove them
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = notes.reversed()[indexPath.row]
        cell.textLabel?.text = note
        
        return cell
    }

    // MARK: - Textfield delegate
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool
//    {
//        sendNote(textField.text!)
//        return false
//    }

    @IBAction func sendMessageTapped(_ sender: UIButton)
    {
        sendNote(noteTakingTextField.text)
        noteTakingTextField.text = ""
    }
    func sendNote(_ note: String?)
    {
        if let aNote = note
        {
            if aNote.characters.count > 0
            {
                notes.append(aNote)
                tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                //tableView.reloadData()
            }

        }
    }

    //MARK: - Helper functions
    func keyboardDidShow(_ notification: Notification)
    {
        let height = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.height
        noteTakingTextFieldBottomContraint.constant = height + 4
    }
    
    func keyboardWillHide (_ notification: Notification)
    {
        noteTakingTextFieldBottomContraint.constant = 8.0
    }
    
    func hideKeyboard()
    {
        noteTakingTextField.resignFirstResponder()
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        noteTakingTextField.resignFirstResponder()
//    }

//    @IBAction func swipeDownKeyboard(_ sender: UISwipeGestureRecognizer)
//    {
//        if sender.direction == .down
//        {
//        noteTakingTextField.resignFirstResponder()
//        }
//            //gestureNameLabel.text = "Swipe Right"
//        
//    }

}
