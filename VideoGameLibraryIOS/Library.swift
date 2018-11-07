//
//  Library.swift
//  VideoGameLibraryIOS
//
//  Created by Andrew Beauchamp on 10/29/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import Foundation
import RealmSwift

class Library {
    //Singleton: an instance that can be shared throughout the entire app (which is neat!)
    static let sharedInstance = Library()
    
 var games = [Game] ( )
}
