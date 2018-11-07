//
//  Game.swift
//  VideoGameLibraryIOS
//
//  Created by Andrew Beauchamp on 10/29/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import Foundation


class Game  {
    enum Genre : String {
        case RPG = "RPG"
        case FPS = "FPS"
        case sports = "sports"
        case actionadventure = "actionadventure"
        case sidescroller = "sidescroller"
        case battleroyale = "battleroyale"
    }
    
    enum Rating: String {
        case mature = "Mature"
        case everyone = "Everyone"
        case E10 = "Everyone 10+"
        case teen = "Teen"
    }
    
    enum Availability {
        case checkedIn
        case checkedOut (dueDate: Date)
    }
    
   let title: String
    let genre: Genre
    let rating: Rating
   let description: String
    var availabilityStatus: Availability
    
    
    init(title: String, genre: Genre, rating: Rating, description: String) {
        self.title = title
        self.genre = genre
        self.rating = rating
        self.description = description
        self.availabilityStatus = .checkedIn
    }
  
}

