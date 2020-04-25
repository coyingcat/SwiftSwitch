//
//  ViewController.swift
//  SwipeView
//
//  Created by Jz D on 2020/4/25.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var swipeView: SwipeView!
    
    
    @IBOutlet weak var label: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        swipeView.alignment = .center
        swipeView.isPagingEnabled = true
        swipeView.itemsPerPage = 1
        swipeView.truncateFinalPage = true
        
        
        
    }


}


extension ViewController: SwipeViewDelegate{
    
    
    
    
}


extension ViewController: SwipeViewDataSource{
 
    func numberOfItems(in swipeView: SwipeView!) -> Int {
        return 100
    }
    
    func viewForItem(swipeView v: SwipeView, at index: Int, reusing view: UIView) -> UIView{
       
        if (view == nil){
            if let views = Bundle.main.loadNibNamed("EventCell", owner: self, options: nil) as? [EventCell]{
                let v = views[0]
                v.delegate = self
                return v
            }
       }
       return view
    }
    
    
}


extension ViewController: EventCellDelegate{

    func click(btn b: UIButton) {
        label.text = "Button \(swipeView.index(of: b)) pressed"
    }
    
    
    
    func toggle(switch s: UISwitch) {
        label.text = "Switch \(swipeView.index(of: s)) toggled"
    }


    func change(slide s: UISlider) {
        label.text = "Slider \(swipeView.index(of: s)) changed"
    }

}
