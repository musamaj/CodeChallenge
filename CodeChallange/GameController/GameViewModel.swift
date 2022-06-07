//
//  GameViewModel.swift
//  CodeChallange
//
//  Created by Usama Jamil on 04/06/2022.
//

import Foundation

typealias WordsCompletionHandler = (_ words:[Word]) -> Void

protocol GameViewModelType {
    func resetCounters()
    func fetchWords(completion: WordsCompletionHandler)
    func getPair()-> Word
    func generatePairs(completion: WordsCompletionHandler)
    
    func questionCount()-> Int
    func correctCount()-> Int
    func wrongCount()-> Int
    
    func incrementQuestionCount()
    func incrementCorrectCount()
    func incrementWrongCount()
}

class GameViewModel: GameViewModelType, JsonHelperProtocol {
    
    // MARK: - Properties
    
    typealias T = Word
    private var wordsList = [Word]()
    private var wordPairs = [Word]()
    
    var correctAttempts = Constants.defaultCount
    var wrongAttempts = Constants.defaultCount
    var questionsCounter = Constants.defaultCount
    
    
    // MARK: - Methods
    
    func fetchWords(completion: WordsCompletionHandler) {
        wordsList = loadJson(filename: Constants.jsonFileName) ?? []
        completion(wordsList)
    }
    
    func getPair() -> Word {
        return wordsList[Int.random(in: 0..<wordsList.count)]
    }
    
    // MARK: - Pairs Generator
    
    func generatePairs(completion: WordsCompletionHandler) {
        
        var pairsArr = [Word]()
        let randIndex = Int.random(in: 0..<Constants.numberOfPairs)
        
        for i in wordPairs.count..<(wordPairs.count + Constants.numberOfPairs) {
            let pair = Word(textEnglish: wordsList[i].textEnglish, textSpanish: getPair().textSpanish)
            pairsArr.append(pair)
        }
        
        pairsArr[randIndex] = wordsList[randIndex+wordPairs.count]
        wordPairs.append(contentsOf: pairsArr)
        
        completion(wordPairs)
    }
    
    
    // MARK: - Count getters
    
    func questionCount()-> Int {
        return questionsCounter
    }
    
    func correctCount() -> Int {
        return correctAttempts
    }
    
    func wrongCount() -> Int {
        return wrongAttempts
    }
}


// MARK: - Counters


extension GameViewModel {
    
    func resetCounters() {
        questionsCounter = Constants.defaultCount
        correctAttempts = Constants.defaultCount
        wrongAttempts = Constants.defaultCount
    }
    
    func incrementQuestionCount() {
        questionsCounter += Constants.defaultIncrement
    }
    
    func incrementCorrectCount() {
        correctAttempts += Constants.defaultIncrement
    }
    
    func incrementWrongCount() {
        wrongAttempts += Constants.defaultIncrement
    }
}
