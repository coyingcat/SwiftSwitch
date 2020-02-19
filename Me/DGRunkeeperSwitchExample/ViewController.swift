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
       
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(red: 252.0/255.0, green: 182.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        
        let runkeeperSwitch3 = DGRunkeeperSwitch()
        runkeeperSwitch3.backgroundColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        runkeeperSwitch3.selectedBackgroundColor = .white
        runkeeperSwitch3.titleColor = .white
        runkeeperSwitch3.selectedTitleColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        runkeeperSwitch3.frame = CGRect(x: 50.0, y: 70.0 + 80, width: 81, height: 38)
        runkeeperSwitch3.addTarget(self, action: #selector(ViewController.switchValueDidChange(sender:)), for: .valueChanged)
        view.addSubview(runkeeperSwitch3)
    }
    
    
    // MARK: -
    
    @IBAction func switchValueDidChange(sender: DGRunkeeperSwitch!) {
        print("valueChanged: \(sender.selectedIndex)")
    }
    
}

