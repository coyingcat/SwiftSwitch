//
//  ViewController.swift
//  DGRunkeeperSwitchExample
//
//  Created by Danil Gontovnik on 9/3/15.
//  Copyright © 2015 Danil Gontovnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -
    // MARK: Vars
    
    @IBOutlet weak var runkeeperSwitch4: DGRunkeeperSwitch?

    // MARK: -
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let runkeeperSwitch3 = DGRunkeeperSwitch()
  
        runkeeperSwitch3.selectedBackgroundColor = .white
        
        runkeeperSwitch3.frame = CGRect(x: 50.0, y: 70.0 + 80, width: 81, height: 38)
        runkeeperSwitch3.addTarget(self, action: #selector(ViewController.switchValueDidChange(sender:)), for: .valueChanged)
        view.addSubview(runkeeperSwitch3)
    }
    
    
    // MARK: -
    
    @IBAction func switchValueDidChange(sender: DGRunkeeperSwitch!) {
        print("valueChanged: \(sender.selectedIndex)")
    }
    
}

