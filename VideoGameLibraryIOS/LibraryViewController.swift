//
//  LibraryViewController.swift
//  VideoGameLibraryIOS
//
//  Created by Andrew Beauchamp on 10/29/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let library = Library.sharedInstance
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        self.tableView.reloadData()
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.games.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! LibraryCell
        let game = library.games[indexPath.row]
        cell.setUP(game: game)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            Library.sharedInstance.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
        }
        let game = library.games[indexPath.row]
        
        func checkOut(at indexPath: IndexPath) {
            let game = self.library.games[indexPath.row]
            
            let calendar = Calendar(identifier: .gregorian)
            let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
            
            game.availabilityStatus = .checkedOut(dueDate: dueDate)
            (tableView.cellForRow(at: indexPath) as! LibraryCell).setUP(game: game)
        }
        
        func checkIn(at indexPath: IndexPath) {
            let game = self.library.games[indexPath.row]
            game.availabilityStatus = .checkedIn
            (tableView.cellForRow(at: indexPath) as! LibraryCell).setUP(game: game)
        }
        
        // Here the tableview is asking if any row should have an "edit" action.
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            
            // We create the delete action, with a closure associated with it.
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
                Library.sharedInstance.games.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            let game = library.games[indexPath.row]
            
            // If the game is checked out, we create and return the check in action.
            // If the game is checked in, we create and return the check out action.
            
            switch game.availabilityStatus {
            case .checkedIn:
                let checkOutAction = UITableViewRowAction(style: .normal, title: "Check Out") { _, indexPath in
                    
                    checkOut(at: indexPath)
                    
                }
                
                return [checkOutAction, deleteAction]
                
            case .checkedOut:
                let checkInAction = UITableViewRowAction(style: .normal, title: "Check In") { _, indexPath in
                    checkIn(at: indexPath)
                }
                
                return [checkInAction, deleteAction]
                
            }
            
            
        }
        
        return [deleteAction]
    }
}

//If the game array is deleted by the user a DZNEmptyDataSet will show up and take them to the addgamecontroller

extension  LibraryViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        
        return NSAttributedString(string: "No Games in Library")
    }
    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        
        return NSAttributedString(string:  "You have no games in your library, Add Some!")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView?, for state: UIControl.State) -> NSAttributedString? {
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
        
        return NSAttributedString(string: "Add Game", attributes: attributes)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton?) {
        performSegue(withIdentifier: "AddGameSegue", sender: self)
    }
    
}

