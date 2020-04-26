//
//  TapTB.swift
//  SwipeView
//
//  Created by Jz D on 2020/4/26.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit

class TapTB: UITableView {}



extension TapTB: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UISlider{
            return false
        }
        else{
            return true
        }
        
        
    }
 
}
