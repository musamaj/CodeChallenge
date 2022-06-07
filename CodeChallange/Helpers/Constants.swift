//
//  Constants.swift
//  CodeChallange
//
//  Created by Usama Jamil on 06/06/2022.
//

import Foundation

enum GameOptions: Int {
    case restart
    case exit
}

struct Constants {
    static let fileFormat = "json"
    static let jsonFileName = "words"
    
    static let defaultCount = 0
    static let defaultIncrement = 1
    static let numberOfPairs = 4
    
    static let totalQuestions = 15
    static let totalWrongAttempts = 3
    static let attemptDuration = 5.2
    
    static let restartButtonTitle = "Restart"
    static let quitButtonTitle = "Quit"
    static let scoreTitle = "Score"
    
    static let scoreMessage = "You answered %@ questions correctly out of 15"
}
