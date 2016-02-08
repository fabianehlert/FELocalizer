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
        
        if let file = NSBundle.mainBundle().pathForResource("Localizer", ofType: "json") {
            FELocalizer.shared.setFilePath(file)
            
            let translation = FELocalizer.shared.localized("Hello")
            
            print("Translation : \(translation)")
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}