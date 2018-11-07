//
//  LibraryCell.swift
//  VideoGameLibraryIOS
//
//  Created by Andrew Beauchamp on 11/1/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import Foundation


import UIKit

class LibraryCell: UITableViewCell {
    //properties
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var gameGenre: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var cellRetry: UILabel!
    @IBOutlet weak var availabilityView: UIView!
    
    func setUP (game: Game) {
        gameGenre.text = game.genre.rawValue
        cellTitle.text = game.title
        cellRetry.text = game.rating.rawValue
        
        switch game.availabilityStatus {
        case .checkedIn:
            //Hide due date
            dueDate.isHidden = true
            //set view to green
            availabilityView.backgroundColor = .green
        case .checkedOut(let date):
            //Show Due date
            dueDate.isHidden = false
            //Turn view color red
            availabilityView.backgroundColor = .red
            //set duedate to formatted date
        let datFormatter = DateFormatter()
        datFormatter.dateFormat = "MM/dd/yyyy"
        dueDate.text = datFormatter.string(from: date)
        }
    }
    
}
