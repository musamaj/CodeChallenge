//
//  GameControllerTests.swift
//  CodeChallangeTests
//
//  Created by Usama Jamil on 07/06/2022.
//

import XCTest
@testable import CodeChallange

class GameControllerTests: XCTestCase {

    var sut: GameViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController
        sut.loadViewIfNeeded()
        sut.resetGame()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testEnglishLabel() {
        XCTAssertEqual(sut.engWordLabel.text, "primary school")
    }
    
    func testCorrectLabel() {
        XCTAssertEqual(sut.correctAttemptsLabel.text, "0")
    }

    func testWrongAttempt() {
        sut.countWrongAttempt()
        XCTAssertEqual(sut.viewModel.wrongCount(), 1)
    }
    
    func testCorrectAction() {
        sut.resetGame()
        sut.actCorrect(self)
        XCTAssertTrue((sut.viewModel.correctCount() > sut.viewModel.wrongCount() || sut.viewModel.wrongCount() > sut.viewModel.correctCount()))
    }
    
    func testWrongAction() {
        sut.resetGame()
        sut.actWrong(self)
        XCTAssertTrue((sut.viewModel.correctCount() > sut.viewModel.wrongCount() || sut.viewModel.wrongCount() > sut.viewModel.correctCount()))
    }
    
    func testUpdatePairs() {
        sut.updateAfterAttempt()
        sut.updateAfterAttempt()
        sut.updateAfterAttempt()
        sut.updateAfterAttempt()
        
        XCTAssertEqual(sut.viewModel.questionCount(), 4)
    }
    
    func testStartTimer() {
        sut.resetGame()
        sut.startTime()
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.viewModel.wrongCount(), 1)
        } else {
            XCTFail("Delay interrupted")
        }
    }

    func testEndGameScenario() {
        sut.resetGame()
        sut.countWrongAttempt()
        sut.countWrongAttempt()
        sut.countWrongAttempt()
        
        XCTAssertEqual(sut.viewModel.questionCount(), sut.viewModel.wrongCount())
    }
    
}
