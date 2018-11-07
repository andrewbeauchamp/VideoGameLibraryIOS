//
//  AddGameViewController.swift
//  VideoGameLibraryIOS
//
//  Created by Andrew Beauchamp on 10/29/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import UIKit

class AddGameViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource {
    //This is for the picker view so you can actually put your variables in it to add a genre to the game thats being made
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    
    //Properties
    let genres = ["RPG", "FPS", "sports", "actionadventure",  "sidescroller", "battleroyale"]
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var genrePickerView: UIPickerView!
    @IBOutlet weak var ratingSegmentedController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genrePickerView.delegate = self //These two lines have to be put here for the picker view to work
        genrePickerView.dataSource = self
    }
    
    //Actions
    @IBAction func addGameTapped(_ sender: Any) {
        addGame()
     }
    
    func addGame () {
        guard
            let addedTitle = titleTextField.text, !addedTitle.isEmpty,
            let addedDesc = descriptionTextView.text, !addedTitle.isEmpty
            else {
                let errorAlert = UIAlertController(title: "Error Detected", message: "Please fill all options", preferredStyle: UIAlertController.Style.alert)
                let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default ) {UIAlertAction in}
                errorAlert.addAction(dismissAction)
                self.present(errorAlert, animated: true, completion: nil)
                return
        }
        
        //selectionlabel.text = genre[pickerview.selectedRow(incomponent: 0)]
        Library.sharedInstance.games.append(Game(title: addedTitle, genre: .actionadventure, rating: .E10, description: addedDesc))
        performSegue(withIdentifier: "AddGameToLibrary", sender: self)
    }

}
