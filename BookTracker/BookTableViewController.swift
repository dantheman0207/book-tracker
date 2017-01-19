//
//  BookTableViewController.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/26/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

protocol requestListenerProtocol {
    func requestCompleted()
}

class BookTableViewController: UITableViewController, requestListenerProtocol {
    
    // MARK: Properties
    var books: Books?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.books = Books(user: 1, reqProtocolDelegate: self)
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Testing data
    func loadSampleBook() {
        let book = Book(name: "Zen and the Art of Motorcycle Maintenance", isbn: "1300000000000", existingNotes: nil)!
        self.books!.add(book: book)
    }
    
    func loadSampleNotes() -> Notes {
        // create Notes object
        let notes = Notes()
        notes.createNote(title: "pg. 57-59", content: "Opening lines of note, showing the first bit...", images: nil)
        return notes
    }

    func requestCompleted() {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books?.count() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let edit = "EditBook"
        let show = "ShowBookNotes"
        let sender = tableView.cellForRow(at: indexPath)
        
        if tableView.isEditing {
            performSegue(withIdentifier: edit, sender: sender)
        } else {
            performSegue(withIdentifier: show, sender: sender)
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell

        // Fetch appropriate data
        let index = (indexPath as NSIndexPath).row
        let book = self.books!.getBook(index: index)
        
        // Configure the cell...
        cell.bookTitle.text = book.displayName
        if let pic = book.photo {
            cell.photoView.image = pic
        }
        
        return cell
    }
 
    @IBAction func unwindToBookList(_ sender: UIStoryboardSegue) {
        if let source = sender.source as? BookViewController, let book = source.book {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update an existing book
                let index = (selectedIndexPath as NSIndexPath).row
                self.books!.update(book: book, index: index)
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // add a new book
                let newIndexPath = IndexPath(row: books!.count(), section: 0)
                self.books!.add(book: book)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        } 
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let edit = "EditBook"
        let show = "ShowBookNotes"
        let add = "AddBook"
        
        if segue.identifier == add {
            print("Adding book.")
        } else if segue.identifier == show {
            let notesTableViewController  = segue.destination as! NoteTableViewController
            if let selectedBookCell = sender as? BookTableViewCell {
                let indexPath = tableView.indexPath(for: selectedBookCell)!
                let selectedBook = self.books!.getBook(index: (indexPath as NSIndexPath).row)
                notesTableViewController.notes = selectedBook.notes
            }
        } else if segue.identifier == edit {
            let bookViewController = segue.destination as! BookViewController
            if let selectedBookCell = sender as? BookTableViewCell {
                let indexPath = tableView.indexPath(for: selectedBookCell)!
                let selectedBook = self.books!.getBook(index: (indexPath as NSIndexPath).row)
                bookViewController.book = selectedBook
            }
        }
    }
    

}
