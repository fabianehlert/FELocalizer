//
//  ViewController.swift
//  FELocalizer-Demo
//
//  Created by Fabian Ehlert on 05.02.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import Foundation

extension String {
    func firstComponentTillSeparator() -> String {
        if let x = self.components(separatedBy: "-").first { return x }
        return self
    }
}

enum FELocalizerNumerus {
    case `default`
    case singular
    case plural
}

enum FELocalizerGenus {
    case `default`
    case female
    case male
}

class FELocalizer {

    static let shared = FELocalizer()
    private var json: [String: AnyObject]!
    
    /// Sets the path for the JSON file that contains the translation strings
    func setFilePath(_ path: String) {
        if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
            } catch let error {
                print(error)
            }
        }

    }
    
    /// Returns a localized String
    func localized(_ key: String, numerus: FELocalizerNumerus = .default, genus: FELocalizerGenus = .default, language: String! = nil) -> String {
        print("Searching for : \(key) with num : \(numerus) and genus : \(genus)")
        if let _ = language {
            return string(key, numerus: numerus, genus: genus, language: language)
        } else {
            return string(key, numerus: numerus, genus: genus, language: languageISOCode())
        }
    }
    
    private func string(_ key: String, numerus: FELocalizerNumerus, genus: FELocalizerGenus, language: String) -> String {
        guard let _ = json else { return "" }
        guard let object = json[key] else { return "" }
        
        if let o = object[language] {
            if let o = o {
                if let l: String = o["default"] as? String { return l }
            }
        }
        
        if let o = object["en"] {
            if let o = o {
                if let l: String = o["default"] as? String { return l }
            }
        }
        
        return ""
    }
    
    /// Returns the ISO only code (2 or 3 character) of the currently preferred system language
    func languageISOCode() -> String {
        if let language = Locale.preferredLanguages().first {
            print("Lang ISO code : \(Locale.preferredLanguages())")
            return language.firstComponentTillSeparator()
        }
        return "en"
    }
    
}
