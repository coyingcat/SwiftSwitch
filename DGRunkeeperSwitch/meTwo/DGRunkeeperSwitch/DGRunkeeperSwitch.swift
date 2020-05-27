//
//  DGRunkeeperSwitch.swift
//  DGRunkeeperSwitchExample
//
//  Created by Danil Gontovnik on 9/3/15.
//  Copyright © 2015 Danil Gontovnik. All rights reserved.
//

import UIKit

// MARK: - DGRunkeeperSwitchRoundedLayer

open class DGRunkeeperSwitchRoundedLayer: CALayer {

    override open var bounds: CGRect {
        didSet { cornerRadius = bounds.height / 2.0 }
    }
    
}

// MARK: - DGRunkeeperSwitch


@IBDesignable
open class DGRunkeeperSwitch: UIControl {
    
    // MARK: - Public vars
    
    open var titles: [String] {
        set {
            let titleFont = UIFont.regular(ofSize: 20)
            
            (titleLabels + selectedTitleLabels).forEach { $0.removeFromSuperview() }
            titleLabels = newValue.map { title in
                let label = UILabel()
                label.text = title
                label.textColor = UIColor(rgb: 0x725A7C)
                label.alpha = 0.5
                label.font = titleFont
                label.textAlignment = .center
                label.lineBreakMode = .byTruncatingTail
                titleLabelsContentView.addSubview(label)
                return label
            }
            selectedTitleLabels = newValue.map { title in
                let label = UILabel()
                label.text = title
                label.textColor = UIColor.white
                label.font = titleFont
                label.textAlignment = .center
                label.lineBreakMode = .byTruncatingTail
                selectedTitleLabelsContentView.addSubview(label)
                return label
            }
        }
        get { return titleLabels.map { $0.text! } }
    }
    
    fileprivate(set) open var selectedIndex: Int = 0
    
    open var selectedBackgroundInset: CGFloat = 2.0 {
        didSet { setNeedsLayout() }
    }
    
    open var animationDuration: TimeInterval = 0.3
    open var animationSpringDamping: CGFloat = 0.75
    open var animationInitialSpringVelocity: CGFloat = 0.0
    
    // MARK: - Private vars
    
    fileprivate var titleLabelsContentView = UIView()
    fileprivate var titleLabels = [UILabel]()
    
    fileprivate var selectedTitleLabelsContentView = UIView()
    fileprivate var selectedTitleLabels = [UILabel]()
    
    fileprivate(set) var selectedBackgroundView = UIView()
    
    fileprivate var titleMaskView: UIView = UIView()
    
    fileprivate var tapGesture: UITapGestureRecognizer!
    fileprivate var panGesture: UIPanGestureRecognizer!
    
    fileprivate var initialSelectedBackgroundViewFrame: CGRect?
    
    
    private var selectedBackgroundViewFrameObserver: NSKeyValueObservation?
    
    
    
    // MARK: - Constructors
    
    public init(){
        super.init(frame: CGRect.zero)
        
        
        finishInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        finishInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        finishInit()
        
    }
    
    fileprivate func finishInit() {
        
        titles = ["练习模式", "测评模式"]
        
        // Setup views
        addSubview(titleLabelsContentView)
        
        object_setClass(selectedBackgroundView.layer, DGRunkeeperSwitchRoundedLayer.self)
        addSubview(selectedBackgroundView)
        
        addSubview(selectedTitleLabelsContentView)
        
        object_setClass(titleMaskView.layer, DGRunkeeperSwitchRoundedLayer.self)
        titleMaskView.backgroundColor = .black
        selectedTitleLabelsContentView.layer.mask = titleMaskView.layer
        
        // Setup defaul colors
        
        backgroundColor = UIColor(rgb: 0xF0EEF1)
        
        
        selectedBackgroundView.backgroundColor = UIColor(rgb: 0x725A7C)
        
        // Gestures
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGesture)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
       
        selectedBackgroundViewFrameObserver = selectedBackgroundView.observe(\.frame, options: NSKeyValueObservingOptions.new) { [weak self] (object, changes) in
            if let newValue = changes.newValue {
                self?.titleMaskView.frame = newValue
            }
        }
    }
    
    

    
    // MARK: -
    
    override open class var layerClass : AnyClass {
        return DGRunkeeperSwitchRoundedLayer.self
    }
    
    
    
    @objc
    func tapped(_ gesture: UITapGestureRecognizer!) {
        let location = gesture.location(in: self)
        let index = Int(location.x / (bounds.width / CGFloat(titleLabels.count)))
        setSelectedIndex(index, animated: true)
    }
    
    
    @objc
    func pan(_ gesture: UIPanGestureRecognizer!) {
        switch gesture.state {
        case .began:
            initialSelectedBackgroundViewFrame = selectedBackgroundView.frame
        case .changed:
            var frame = initialSelectedBackgroundViewFrame!
            frame.origin.x += gesture.translation(in: self).x
            frame.origin.x = max(min(frame.origin.x, bounds.width - selectedBackgroundInset - frame.width), selectedBackgroundInset)
            selectedBackgroundView.frame = frame
        case .ended , .failed, .cancelled:
            let index = max(0, min(titleLabels.count - 1, Int(selectedBackgroundView.center.x / (bounds.width / CGFloat(titleLabels.count)))))
            setSelectedIndex(index, animated: true)
        default:
            ()
        }
    }
    
    open func setSelectedIndex(_ selectedIndex: Int, animated: Bool) {
        guard 0..<titleLabels.count ~= selectedIndex else { return }
        
        // Reset switch on half pan gestures
        var catchHalfSwitch = false
        if self.selectedIndex == selectedIndex {
            catchHalfSwitch = true
        }
        
        self.selectedIndex = selectedIndex
        if animated {
            if (!catchHalfSwitch) {
                self.sendActions(for: .valueChanged)
            }
            UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: animationSpringDamping, initialSpringVelocity: animationInitialSpringVelocity, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut], animations: { () -> Void in
                self.layoutSubviews()
                }, completion: nil)
        } else {
            layoutSubviews()
            sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Layout
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let selectedBackgroundWidth = bounds.width / CGFloat(titleLabels.count) - selectedBackgroundInset * 2.0
        selectedBackgroundView.frame = CGRect(x: selectedBackgroundInset + CGFloat(selectedIndex) * (selectedBackgroundWidth + selectedBackgroundInset * 2.0), y: selectedBackgroundInset, width: selectedBackgroundWidth, height: bounds.height - selectedBackgroundInset * 2.0)
        
        (titleLabelsContentView.frame, selectedTitleLabelsContentView.frame) = (bounds, bounds)
        
        let titleLabelMaxWidth = selectedBackgroundWidth
        let titleLabelMaxHeight = bounds.height - selectedBackgroundInset * 2.0
        
        zip(titleLabels, selectedTitleLabels).forEach { label, selectedLabel in
            let index = titleLabels.firstIndex(of: label)!
            
            var size = label.sizeThatFits(CGSize(width: titleLabelMaxWidth, height: titleLabelMaxHeight))
            size.width = min(size.width, titleLabelMaxWidth)
          
            let x = floor((bounds.width / CGFloat(titleLabels.count)) * CGFloat(index) + (bounds.width / CGFloat(titleLabels.count) - size.width) / 2.0)
            let y = floor((bounds.height - size.height) / 2.0)
            let origin = CGPoint(x: x, y: y)
            
            let frame = CGRect(origin: origin, size: size)
            label.frame = frame
            selectedLabel.frame = frame
        }
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension DGRunkeeperSwitch: UIGestureRecognizerDelegate {
    
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture {
            return selectedBackgroundView.frame.contains(gestureRecognizer.location(in: self))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
    
}
