//
//  Dictionary + JsonDict.swift
//  NotesFirst
//
//  Created by Andriy Trubchanin on 6/15/17.
//
//

import Foundation

typealias JsonDict = [String:Any]

extension Dictionary where Key == String {
    
    func getDict(_ path: String) -> JsonDict? {
        return self[path] as? JsonDict
    }

    func getArray(_ path: String) -> [JsonDict]? {
        return self[path] as? [JsonDict]
    }
    
    func getString(_ path: String) -> String? {
        return self[path] as? String
    }
    
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}
