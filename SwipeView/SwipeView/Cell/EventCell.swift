//
//  EventCell.swift
//  SwipeView
//
//  Created by Jz D on 2020/4/25.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit


protocol EventCellDelegate: class {
    func click(btn b: UIButton)
    func toggle(switch s: UISwitch)
    func change(slide s: UISlider)
}



class EventCell: UITableViewCell {

    
    weak var delegate: EventCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func press(_ sender: UIButton) {
        
        delegate?.click(btn: sender)
        
    }
    
    
    
    @IBAction func toggle(_ sender: UISwitch) {
        
        delegate?.toggle(switch: sender)
    }
    
    
    
    
    @IBAction func change(_ sender: UISlider) {
        delegate?.change(slide: sender)
    }
    
    
}
