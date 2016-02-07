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
        if let x = self.componentsSeparatedByString("-").first { return x }
        return self
    }
}

enum FELocalizerNumerus {
    case Default
    case Singular
    case Plural
}

enum FELocalizerGenus {
    case Default
    case Female
    case Male
}

class FELocalizer {

    static let shared = FELocalizer()
    private var json: [String: AnyObject]!
    
    /// Sets the path for the JSON file that contains the translation strings
    func setFilePath(path: String) {
        if let jsonData = NSData(contentsOfFile: path) {
            do {
                json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
            } catch let error {
                print(error)
            }
        }

    }
    
    /// Returns a localized String
    func localized(key: String, numerus: FELocalizerNumerus = .Default, genus: FELocalizerGenus = .Default, language: String! = nil) -> String {
        print("Searching for : \(key) with num : \(numerus) and genus : \(genus)")
        if let _ = language {
            return string(key, numerus: numerus, genus: genus, language: language)
        } else {
            return string(key, numerus: numerus, genus: genus, language: languageISOCode())
        }
    }
    
    private func string(key: String, numerus: FELocalizerNumerus, genus: FELocalizerGenus, language: String) -> String {
        guard let _ = json else { return "" }
        guard let object = json[key] else { return "" }
        
        if let o = object[languageISOCode()] {
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
        if let language = NSLocale.preferredLanguages().first {
            return language.firstComponentTillSeparator()
        }
        return "en"
    }
    
}