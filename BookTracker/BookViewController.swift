//
//  BookViewController.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/26/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    // NAMES:
    //  cancelButton, photoView, saveButton, bookTitle, isbn
    var user: String?
    var book: Book?
    
    //
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var isbn: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("view loaded!")
        
        // set up existing book if given
        if let book = book {
            print("we have a book already!")
            
            self.bookTitle.text = book.displayName
            if let isbn = book.isbn {
                self.isbn.text = isbn
            }
            if let pic = book.photo {
                self.photoView.image = pic
            }
        }
        
        // Save button only enabled when book name valid
        checkValidName()
    }
    
    // MARK: Helper functions
    func checkValidName() {
        // Disable the 'Save' button if text field empty
        //let text = bookTitle.text ?? ""
        //saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard and return
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // saveButton.isEnabled = false
    }
    
    // MARK: Cancel
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        if presentingViewController is UINavigationController {
            // dismiss w/o storing any info
            dismiss(animated: true, completion: nil)
        } else {
            // dismiss without changing anything about the book
            navigationController!.popViewController(animated: true)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //
        if saveButton == sender as? UIBarButtonItem {
            let bookName = bookTitle.text!
            let nr = isbn.text
            
            self.book!.displayName = bookName
            self.book!.isbn = nr
            self.book!.update()
        }
        
        
    }
    

}
