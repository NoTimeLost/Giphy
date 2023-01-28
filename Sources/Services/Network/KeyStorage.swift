//
//  KeyStorage.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

import Foundation

enum KeyStorage {
    static var gifAPIKey: String {
        guard
            let filePath = Bundle.main.path(forResource: "GIPHY-Info", ofType: "plist")
        else {
            fatalError("Couldn't find file 'GIPHY-Info.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard
            let value = plist?.object(forKey: "API_KEY") as? String
        else {
            fatalError("Couldn't find key 'API_KEY' in 'GIPHY-Info.plist'.")
        }
        
        return value
    }
}
