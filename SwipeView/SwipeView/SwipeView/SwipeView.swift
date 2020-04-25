//
//  SwipeView.swift
//  SwipeView
//
//  Created by Jz D on 2020/4/25.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit

enum SwipeViewAlignment: UInt{
    case edge = 0, center = 1
}



@objc
protocol SwipeViewDelegate: class{
    
    @objc optional func itemSizeOf(swipeView v: SwipeView) -> CGSize
    @objc optional func didScroll(swipeView v: SwipeView)
    @objc optional func swipeView(sV v: SwipeView)

    @objc optional func currentItemIndexDidChange(swipeView v: SwipeView)
    @objc optional func WillBeginDragging(swipeView v: SwipeView)
    @objc optional func didEndDragging(swipeView v: SwipeView, will decelerate: Bool)
        
    @objc optional func willBeginDecelerating(swipeView v: SwipeView)
    @objc optional func didEndDecelerating(swipeView v: SwipeView)
    @objc optional func didEndScrollingAnimation(swipeView v: SwipeView)
    
    @objc optional func shouldSelectItem(swipeView v: SwipeView,at index: Int) -> Bool
    @objc optional func didSelectItem(swipeView v: SwipeView,at index: Int)

}



protocol SwipeViewDataSource: class{
    func numberOfItems(in swipeView: SwipeView) -> Int
    func viewForItem(swipeView v: SwipeView,at index: Int, reusing view: UIView) -> UIView
}


class SwipeView: UIView {

    
    weak var dataSource: SwipeViewDataSource?
    weak var delegate: SwipeViewDelegate?
    
    var numberOfItems = 0
    var numberOfPages: Int
    var itemSize = CGSize.zero
    
    var itemsPerPage: Int = 1
    var truncateFinalPage: Bool = false
    var indexesForVisibleItems = []()
    
    var visibleItemViews = []()
    var currentItemView: UIView
    var currentItemIndex: Int = 0
    
    var currentPage: Int
    var alignment: SwipeViewAlignment
    var scrollOffset = CGFloat.zero
    
    var isPagingEnabled = true
    var isScrollEnabled = true
    var isWrapEnabled = false
    
    var delaysContentTouches = true
    var bounces = true
    var decelerationRate: Float
    
    var autoscroll: CGFloat
    var isDragging: Bool
    var isDecelerating: Bool
    
    var isScrolling: Bool
    var defersItemViewLoading = false
    var isVertical = false
    
    
    lazy var scrollView: UIScrollView = { () -> UIScrollView in
        let s = UIScrollView()
        s.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        s.autoresizesSubviews = true
        s.delegate = self
        s.delaysContentTouches = false
        s.bounces = true
        s.alwaysBounceHorizontal = true
        s.alwaysBounceVertical = false
        s.isPagingEnabled = true
        s.isScrollEnabled = true
        s.showsVerticalScrollIndicator = false
        s.showsHorizontalScrollIndicator = false
        s.scrollsToTop = false
        s.clipsToBounds = false
        return s
    }()
    
    var itemViews = [:]()
    var itemViewPool = Set()
     
    var previousItemIndex = 0
    var previousContentOffset = CGPoint.zero
    
    var suppressScrollEvent: Bool
    var scrollDuration: TimeInterval
    var startTime: TimeInterval
    
    var lastTime: TimeInterval
    var startOffset: CGFloat
    var endOffset: CGFloat
    
    var lastUpdateOffset: CGFloat
    var timer: Timer?


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        tapGesture.delegate = self
        scrollView.addGestureRecognizer(tapGesture)
        clipsToBounds = true
        insertSubview(scrollView, at: 0)
             
    }
    
    
    @objc
    func didTap(gesture g: UITapGestureRecognizer){
        let point = g.location(in: scrollView)
        var index = point.x / itemSize.width
        if isVertical{
            index = point.y / itemSize.height
        }
        if isWrapEnabled{
            index = index % numberOfItems
        }
        
        if index >= 0, index < numberOfItems{
            delegate?.didSelectItem?(swipeView: self, at: index)
        }
    }
    
    func reloadData(){
        
        
    }
    
    
    func reloadItem(at index: Int){
        
        
    }
    
    
    func scrolling(by offset: CGFloat, duration t:TimeInterval){
        
        
        
        
    }
    
    
    func scrolled(to offset:CGFloat, duration t: TimeInterval){
        
        
    }
    
    
    func scrolling(byItems number:Int,duration t: TimeInterval){
        
    }
    
    
    
    func scrolled(toIdx index:Int, duration t: TimeInterval){
        
        
    }
 
    func scrolled(toP page:Int, duration t: TimeInterval){
        
        
    }
    
 
    func itemView(at index: Int) -> UIView{
        
        
    }
    
    
    func index(of itemView: UIView) -> Int{
        
        
        
    }
 
    
    func index(ofAll itemView: UIView) -> Int{
        
        
        
    }

}




extension SwipeView: UIScrollViewDelegate{
    
    
    
    
}


extension SwipeView: UIGestureRecognizerDelegate{
    
    
    
    
}

