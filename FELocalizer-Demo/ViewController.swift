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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("-------")
        print("Touches began")
        print("-------")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touches moved: \(touches.first?.locationInView(view))")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("####")
        print("Touches ended")
        print("####")
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print("*****")
        print("Touches cancelled")
        print("*****")
    }

}