//
//  NoteViewController.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/27/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var fromPage: UITextField!
    @IBOutlet weak var toPage: UITextField!
    @IBOutlet weak var insertImageButton: UIButton!
    @IBOutlet weak var noteContent: UITextView!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates
        fromPage.delegate    = self
        toPage.delegate      = self
        noteContent.delegate = self

        // check if existing note to edit
        if let note = note {
            fromPage.text = note.title
            noteContent.text = note.content
        }
        // Do any additional setup after loading the view.
        validateInputs()
    }
    
    func validateInputs() {
        // Check fromPage to be valid number
        
        // Check toPage to be valid number or nothing
        
        // Check noteContent to be something
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Add Image
    @IBAction func insertImage(_ sender: UIButton) {
    }

    
    // MARK: - Navigation
     @IBAction func cancel(_ sender: UIBarButtonItem) {
        if presentingViewController is UINavigationController {
            // dismiss w/o storing any info
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
     }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if saveButton === sender as? UIBarButtonItem {
            let title = fromPage.text!
            let content = noteContent.text!
            
            note = Note(title: title, content: content, everNote: nil)
        }
    }

}
