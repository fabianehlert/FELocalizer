//
//  FELocalizer.swift
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

enum Numerus {
    case `default`
    case singular
    case plural
}

enum Genus {
    case `default`
    case female
    case male
}

enum FELocalizerError: Error {
    case FileSetupFailed
    case FileParsingFailed
}

extension FELocalizerError: CustomStringConvertible {
    var description: String {
        switch self {
        case .FileSetupFailed:
            return "Failed to get JSON file for FELocalizer."
        case .FileParsingFailed:
            return "Failed to parse JSON file for FELocalizer."
        }
    }
}

class FELocalizer {
    
    var json: [String: AnyObject]?
    
    /// Initialize
    init(path: String) throws {
        do {
            try setFilePath(path)
        } catch let error {
            throw error
        }
    }
    
    /// Sets the path for the JSON file that contains the translation strings
    private func setFilePath(_ path: String) throws {
        if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]
            } catch let error {
                print("error in setFilePath: \(error)")
                throw FELocalizerError.FileParsingFailed
            }
        } else {
            throw FELocalizerError.FileSetupFailed
        }
    }
    
    /// Returns a localized String
    func localized(_ key: String, numerus: Numerus = .default, genus: Genus = .default, language: String! = nil) -> String? {
        print("Searching for : \(key) with num : \(numerus) and genus : \(genus)")
        if let _ = language {
            return string(key, numerus: numerus, genus: genus, language: language)
        } else {
            guard let defaultLanguage = defaultLanguage() else { return nil }
            return string(key, numerus: numerus, genus: genus, language: defaultLanguage)
        }
    }
    
    private func string(_ key: String, numerus: Numerus, genus: Genus, language: String) -> String? {
        guard let json = json, let object = json[key], let o = object[language] else { return nil }
        
        if let o = o,
            let l: String = o["default"] as? String {
            return l
        }
        
        return nil
    }
    
    /// Returns the ISO only code (2 or 3 character) of the currently preferred system language
    func defaultLanguage() -> String? {
        if let language = Locale.preferredLanguages.first {
            return language.firstComponentTillSeparator()
        }
        return nil
    }
    
}
