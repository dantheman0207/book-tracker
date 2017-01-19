//
//  NoteTableViewController.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/27/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    // MARK: Properties
    var notes: Notes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //navigationItem.rightBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell

        let index = (indexPath as NSIndexPath).row
        let note = notes.getNote(index: index)
        
        // Configure the cell...
        let endIndex = note.content.index(note.content.startIndex, offsetBy: 44)
        cell.contentLabel.text = note.content.substring(to: endIndex) + "..."
        
        cell.pageLabel.text = note.title
        
        return cell
    }
    
    @IBAction func unwindToNoteList(_ sender: UIStoryboardSegue) {
        if let source = sender.source as? NoteViewController, let note = source.note {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing note
                let index = (selectedIndexPath as NSIndexPath).row
                notes.update(note: note, index: index)
                tableView.reloadRows(at: [selectedIndexPath], with: .none) // Reload row
            } else {
                // Add a new note
                let newIndexPath = IndexPath(row: notes.count(), section: 0)
                notes.add(note: note)
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
        
        // Identifiers
        let add = "AddNote"
        let show = "ShowNoteDetail"
        
        if segue.identifier == add {
            print("Adding new note")
        } else if segue.identifier == show {
            let noteViewController = segue.destination as! NoteViewController
            if let selectedNoteCell = sender as? NoteTableViewCell {
                let indexPath = tableView.indexPath(for: selectedNoteCell)!
                let index = (indexPath as NSIndexPath).row
                let selectedNote = notes.getNote(index: index)
                noteViewController.note = selectedNote
            }
        }
    }
    
}
