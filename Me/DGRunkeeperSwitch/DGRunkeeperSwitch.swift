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
    

    fileprivate(set) open var selectedIndex: Int = 0
    let selectedBackgroundInset: CGFloat = 2.0
    
    open var animationDuration: TimeInterval = 0.3
    open var animationSpringDamping: CGFloat = 0.75
    open var animationInitialSpringVelocity: CGFloat = 0.0
    
    // MARK: - Private vars
    
    fileprivate var titleLabelsContentView = UIView()
    fileprivate var titleLabels = [UILabel]()
    
    fileprivate var selectedTitleLabelsContentView = UIView()
    fileprivate var selectedTitleLabels = [UILabel]()
    
    fileprivate(set) var selectedBackgroundView = {() -> UIView in
        let v =  UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    
    fileprivate var titleMaskView: UIView = UIView()
    
    fileprivate var tapGesture: UITapGestureRecognizer!
    fileprivate var panGesture: UIPanGestureRecognizer!
    
    fileprivate var initialSelectedBackgroundViewFrame: CGRect?
    
    
    private var selectedBackgroundViewFrameObserver: NSKeyValueObservation?
    
    
    lazy var lhs = titleC()
    
    let startColor = UIColor(rgb: 0xEDEDED)
    
    // MARK: - Constructors
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("没实现")
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        
        (titleLabels + selectedTitleLabels).forEach { $0.removeFromSuperview() }

        let rhs = titleC()
        
        titleLabels = [lhs, rhs]
        
        
        let titleSelectedC = { num in
            return (1...num).map{ _ in
                let label = UILabel()
                self.selectedTitleLabelsContentView.addSubview(label)
                return label
            }
        } as (Int) -> [UILabel]
        
        
        selectedTitleLabels = titleSelectedC(2)
        finishInit()
        backgroundColor = startColor
    }
    
    
    
    func configLhs(_ num: Int){
        lhs.text = "\(num)"
    }
    
    
    
    fileprivate func finishInit() {
        // Setup views
        addSubview(titleLabelsContentView)
        
        
        // 这一手，真漂亮
        
        object_setClass(selectedBackgroundView.layer, DGRunkeeperSwitchRoundedLayer.self)
        addSubview(selectedBackgroundView)
        
        addSubview(selectedTitleLabelsContentView)
        
        object_setClass(titleMaskView.layer, DGRunkeeperSwitchRoundedLayer.self)
        titleMaskView.backgroundColor = .black
        selectedTitleLabelsContentView.layer.mask = titleMaskView.layer
        
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
    

    func titleC() -> UILabel{
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.regular(ofSize: 18)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        titleLabelsContentView.addSubview(label)
        return label
    }

    
    // MARK: -
    
    override open class var layerClass : AnyClass {
        return DGRunkeeperSwitchRoundedLayer.self
    }
    
    
    
    @objc
    func tapped(_ gesture: UITapGestureRecognizer!) {
        let location = gesture.location(in: self)
        let index = Int(location.x / (bounds.width / CGFloat(titleLabels.count)))
        setSelectedIndex(index)
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
        default:
            // .ended,   .failed,   .cancelled
            let stepOne = min(titleLabels.count - 1, Int(selectedBackgroundView.center.x / (bounds.width / CGFloat(titleLabels.count))))
            let index = max(0,stepOne)
            setSelectedIndex(index)
        }
    
    }
    
    open func setSelectedIndex(_ selectedIndex: Int) {
        guard 0..<titleLabels.count ~= selectedIndex else { return }
        
        // Reset switch on half pan gestures
        var catchHalfSwitch = false
        if self.selectedIndex == selectedIndex {
            catchHalfSwitch = true
        }
        
        self.selectedIndex = selectedIndex

        
        if catchHalfSwitch{
            UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: animationSpringDamping, initialSpringVelocity: animationInitialSpringVelocity, options: [.beginFromCurrentState, .curveEaseOut], animations: { () -> Void in
                switch selectedIndex {
                case 0:
                    self.backgroundColor = self.startColor
                default:
                    //  1
                    self.backgroundColor = UIColor.scoreSwitch
                }
                self.layoutSubviews()
                
            }, completion: nil)
        }
        else{
            self.sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Layout
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let selectedBackgroundWidth = bounds.width / CGFloat(titleLabels.count) - selectedBackgroundInset * 2.0
        selectedBackgroundView.frame = CGRect(x: selectedBackgroundInset + CGFloat(selectedIndex) * (selectedBackgroundWidth + selectedBackgroundInset * 2.0), y: selectedBackgroundInset, width: selectedBackgroundWidth, height: bounds.height - selectedBackgroundInset * 2.0)
        
        
        // 有点意思
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
    
    
    // 相当于， hit test
}
