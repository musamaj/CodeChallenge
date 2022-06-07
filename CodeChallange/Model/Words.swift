//
//  Words.swift
//  CodeChallange
//
//  Created by Usama Jamil on 04/06/2022.
//

import Foundation

struct WordList: Decodable {
    var words: [Word]
}

// MARK: - Word
struct Word: Decodable {
    let textEnglish, textSpanish: String?

    enum CodingKeys: String, CodingKey {
        case textEnglish = "text_eng"
        case textSpanish = "text_spa"
    }
}

