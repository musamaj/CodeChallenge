//
//  CodeChallangeTests.swift
//  CodeChallangeTests
//
//  Created by Usama Jamil on 03/06/2022.
//

import XCTest
@testable import CodeChallange

class CodeChallangeTests: XCTestCase, JsonHelperProtocol {
    
    typealias T = Word
    var sut: GameViewModelType!
    
    override func setUpWithError() throws {
        sut = GameViewModel()
        sut.resetCounters()
        sut.fetchWords { words in
        }
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    func testGameStart() {
        XCTAssertEqual(sut.questionCount(), Constants.defaultCount)
    }
    
    func testIncrementQuestion() {
        sut.incrementQuestionCount()
        XCTAssertEqual(sut.questionCount(), 1)
    }

    func testFileParsing() {
        let expectation = self.expectation(description: "Parsed")
        sut.fetchWords { words in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testWordListing() {
        let expectation = self.expectation(description: "Listing")
        var wordsList = [Word]()
        sut.fetchWords { words in
            wordsList = words
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertEqual(wordsList.count, 297)
    }
    
    func testPairsGenerator() {
        let expectation = self.expectation(description: "Pairs")
        var wordsList = [Word]()
        sut.generatePairs { words in
            wordsList = words
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertEqual(wordsList.count, 4)
    }
    
    func testJsonHelper() {
        let words = loadJson(filename: "words")
        XCTAssertEqual(words?.count, 297)
    }
    
    func testJsonHelperFailure() {
        let words = loadJson(filename: "word")
        XCTAssertNil(words)
    }

}
