//
//  ViewController.swift
//  CodeChallange
//
//  Created by Usama Jamil on 03/06/2022.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var correctAttemptsLabel: UILabel!
    @IBOutlet weak var wrongAttemptsLabel: UILabel!
    @IBOutlet weak var spanishTranslationLabel: UILabel!
    @IBOutlet weak var engWordLabel: UILabel!
    @IBOutlet weak var btnCorrect: UIButton!
    @IBOutlet weak var btnWrong: UIButton!
    
    
    // MARK: - Properties
    
    internal var viewModel: GameViewModelType!
    private var wordsList = [Word]()
    private var currentWord: Word!
    private var randomWrongWord: Word!
    private var wordPairs = [Word]()
    
    private var timer: Timer!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        resetGame()
    }
    
    
    // MARK: - Setup
    
    func resetGame() {
        viewModel = GameViewModel()
        viewModel.resetCounters()
        
        viewModel.fetchWords(completion: { [weak self] words in
            self?.wordsList = words
        })
        
        viewModel.generatePairs(completion: { [weak self] words in
            self?.wordPairs = words
        })
        
        setup()
        startTime()
        showSpanishLabelWithAnimation()
    }
    
    func setup() {
        currentWord = wordPairs[viewModel.questionCount()]
        
        engWordLabel.text = currentWord.textEnglish
        spanishTranslationLabel.text = currentWord.textSpanish
        
        correctAttemptsLabel.text = "\(viewModel.correctCount())"
        wrongAttemptsLabel.text = "\(viewModel.wrongCount())"
    }
    
    func showSpanishLabelWithAnimation() {
        spanishTranslationLabel.animHide()
        spanishTranslationLabel.animShow()
    }

    func updatePairsIfNeeded() {
        if wordPairs.count == viewModel.questionCount() {
            viewModel.generatePairs(completion: { [weak self] words in
                self?.wordPairs = words
            })
        }
    }
    
    
    // MARK: - Count wrong attempt in case of no action by user
    
    func countWrongAttempt() {
        viewModel.incrementWrongCount()
        wrongAttemptsLabel.text = "\(viewModel.wrongCount())"
        
        updateAfterAttempt()
    }
    
    func updateAfterAttempt() {
        viewModel.incrementQuestionCount()
        
        if viewModel.questionCount() >= Constants.totalQuestions || viewModel.wrongCount() >= Constants.totalWrongAttempts {
            stopTime()
            endGameHandler()
        } else {
            updatePairsIfNeeded()
            setup()
            showSpanishLabelWithAnimation()
            
            // Reset timer after attempt
            resetTimer()
        }
    }
    
    
    // MARK: - Actions

    @IBAction func actCorrect(_ sender: Any) {
        btnCorrect.tapHandling()
        
        if spanishTranslationLabel.text == wordsList[viewModel.questionCount()].textSpanish {
            viewModel.incrementCorrectCount()
            correctAttemptsLabel.text = "\(viewModel.correctCount())"
        } else {
            viewModel.incrementWrongCount()
            wrongAttemptsLabel.text = "\(viewModel.wrongCount())"
        }
        
        updateAfterAttempt()
        
    }
    
    @IBAction func actWrong(_ sender: Any) {
        btnWrong.tapHandling()
        
        if spanishTranslationLabel.text == wordsList[viewModel.questionCount()].textSpanish {
            viewModel.incrementWrongCount()
            wrongAttemptsLabel.text = "\(viewModel.wrongCount())"
        } else {
            viewModel.incrementCorrectCount()
            correctAttemptsLabel.text = "\(viewModel.correctCount())"
        }
        
        updateAfterAttempt()
    }
    
}


// MARK: - Start/Stop Timer


extension GameViewController {
    
    func resetTimer() {
        stopTime()
        startTime()
    }
    
    func stopTime() {
      timer.invalidate()
      timer = Timer()
    }
    
    func startTime() {
        timer = Timer.scheduledTimer(withTimeInterval: Constants.attemptDuration, repeats: false) { [weak self] timer in
            self?.countWrongAttempt()
        }
    }
    
}


// MARK: - Game End Handler


extension GameViewController {
    
    func endGameHandler() {
        presentAlertWithTitle(title: Constants.scoreTitle, message: String(format: Constants.scoreMessage, arguments: ["\(viewModel.correctCount())"]), options: Constants.restartButtonTitle, Constants.quitButtonTitle) { (option) in
            switch(option) {
            case GameOptions.restart.rawValue:
                self.resetGame()
            case GameOptions.exit.rawValue:
                self.exitGame()
            default:
                break
            }
        }
    }
    
    func exitGame() {
        UIApplication.shared.exitApp()
    }
    
}
