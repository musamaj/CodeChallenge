//
//  JsonHelperTests.swift
//  CodeChallangeTests
//
//  Created by Usama Jamil on 07/06/2022.
//

import XCTest
@testable import CodeChallange

class JsonHelperTests: XCTestCase, JsonHelperProtocol {
    typealias T = WordList
    

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let words = loadJson(filename: "words")
        XCTAssertNil(words)
    }

}
