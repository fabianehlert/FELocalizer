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
    func localized(key: String, language: String! = nil) -> String {
        if let _ = language {
            return string(key, language: language)
        } else {
            return string(key, language: languageISOCode())
        }
    }
    
    private func string(key: String, language: String) -> String {
        if let _ = json {
            if let object = json[key] {
                if let l = object[languageISOCode()] {
                    if let l: String = l as? String {
                        return l
                    }
                }
                if let l = object["en"] {
                    if let l: String = l as? String {
                        return l
                    }
                }
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