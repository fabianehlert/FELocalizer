//
//  ViewController.swift
//  FELocalizer-Demo
//
//  Created by Fabian Ehlert on 05.02.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = Bundle.main.path(forResource: "Localizer", ofType: "json") {
            do {
                let localizer = try FELocalizer(path: filePath)
                print("Localizer setup successful : \(localizer)")
                
                if let hello = localizer.localized("Hello") {
                    print("Translation : \(hello)")
                } else {
                    print("Value for \"Hello\" not found!")
                }

                if let goodbye = localizer.localized("Goodbye") {
                    print("Translation : \(goodbye)")
                } else {
                    print("Value for \"Goodbye\" not found!")
                }
            } catch let error {
                print(error)
            }
        } else {
             print("File doesn't exist!")
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
