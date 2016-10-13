//
//  ViewController.swift
//  FELocalizer-Demo
//
//  Created by Fabian Ehlert on 05.02.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var localizer: FELocalizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = Bundle.main.path(forResource: "Localizer", ofType: "json") {
            do {
                localizer = try FELocalizer(path: filePath)
                print("Localizer setup successfully : \(localizer)")
            } catch let error {
                print(error)
            }
        } else {
             print("File doesn't exist!")
        }
    }
        
    func localizeStuff() {
        if let hello = localizer?.localized("Hello") {
            print("Translation : \(hello)")
        } else {
            print("Value for \"Hello\" not found!")
        }
        
        if let goodbye = localizer?.localized("Goodbye") {
            print("Translation : \(goodbye)")
        } else {
            print("Value for \"Goodbye\" not found!")
        }
    }
    
}
