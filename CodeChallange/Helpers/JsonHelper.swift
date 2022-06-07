//
//  JsonLoader.swift
//  CodeChallange
//
//  Created by Usama Jamil on 04/06/2022.
//

import Foundation

protocol JsonHelperProtocol {
    associatedtype T: Decodable
    func loadJson(filename fileName: String) -> [T]?
}

extension JsonHelperProtocol {
    
    func loadJson(filename fileName: String) -> [T]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: Constants.fileFormat) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let model = try decoder.decode([T].self, from: data)
                return model
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
}
