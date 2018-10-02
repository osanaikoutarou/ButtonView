//
//  ButtonView.swift
//  ButtonView
//
//  Created by osanai on 2018/01/11.
//  Copyright © 2018年 jp.co.osanai.buttonview.demo. All rights reserved.
//

import UIKit

@objcMembers
class ButtonView: UIControl {
    
    var coverImageName:String?
    let defaultAlpha:CGFloat = 1.0
    var type:ButtonViewType = .componentLight
    let viewHilightModes = ViewHilightModes()
    
    // for cover
    var coverImageViewViews:[UIView] = []
    var coverViewViews:[UIView] = []
    var allCoverView:UIView?
    
    // タッチ状態
    var onTouch:Bool = false
    // タッチしたポイント
    var touchDownPoint:CGPoint = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    func commonInit() {
        addTargets()
        setup(type: .likeUIButtonPlane)
    }
    
    func addTargets() {
        addTarget(self, action: #selector(touchDown),           for: .touchDown)
        addTarget(self, action: #selector(touchUpInside),       for: .touchUpInside)
        addTarget(self, action: #selector(touchUpOutside),      for: .touchUpOutside)
        addTarget(self, action: #selector(touchDragInside),     for: .touchDragInside)
        addTarget(self, action: #selector(touchDragOutside),    for: .touchDragOutside)
        addTarget(self, action: #selector(touchDragEnter),      for: .touchDragEnter)
        addTarget(self, action: #selector(touchDragExit),       for: .touchDragExit)
        addTarget(self, action: #selector(touchCancel),         for: .touchCancel)
    }
    
    // interface
    func setup(type:ButtonViewType) {
        if self.superview != nil {
            superview?.layoutIfNeeded()
        }
        
        self.type = type
        viewHilightModes.setupHighlight(type: self.type)
        
        if (self.type == .darkerTheWhole ||
            self.type == .whiteTheWhole) {
            addAllCoverView()
        }
        
        createCoverView()
    }
    
    // bridge
    //TODO:enum of objective-cに
    @objc func setup(typeString:String) {
        var type:ButtonViewType = .componentLight
        
        if typeString == "componentLight" {
            type = .componentLight
        }
        else if typeString == "componentDark" {
            type = .componentDark
        }
        else if typeString == "lighterTheWhole" {
            type = .lighterTheWhole
        }
        else if typeString == "darkerTheWhole" {
            type = .darkerTheWhole
        }
        else if typeString == "likeUIButtonPlane" {
            type = .likeUIButtonPlane
        }
        else if typeString == "likeUIButtonCustom" {
            type = .likeUIButtonCustom
        }
        else if typeString == "likeUIButton" {
            type = .likeUIButton
        }
        else if typeString == "noChange" {
            type = .noChange
        }
        setup(type: type)
    }
    
    // event
    @objc func touchDown() {
        //        print("touch down")
        showTouchState(animation: false)
    }
    @objc func touchUpInside() {
        //        print("touch up inside")
        showUpState(animation: true)
    }
    @objc func touchUpOutside() {
        //        print("touch up outside")
        showUpState(animation: true)
    }
    @objc func touchDragInside() {
    }
    @objc func touchDragOutside() {
        showUpState(animation: true)
    }
    @objc func touchDragEnter() {
        showTouchState(animation: true)
    }
    @objc func touchDragExit() {
        showUpState(animation: true)
    }
    @objc func touchCancel() {
        showUpState(animation: true)
    }
    
    //
    func showTouchState(animation:Bool) {
        if onTouch {
            return
        }
        else {
            onTouch = true
        }
        
        UIView.animate(
            withDuration: animation ? 0.2 : 0,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                
                if self.viewHilightModes.cover == .light {
                    self.alpha = 0.2
                    return;
                }
                if self.viewHilightModes.cover == .dark {
                    self.allCoverView?.isHidden = false
                    return;
                }
                if self.viewHilightModes.cover == .white {
                    self.allCoverView?.isHidden = false
                    return;
                }
                
                if self.viewHilightModes.label == .light {
                    for v in self.subviews {
                        if v is UILabel {
                            v.alpha = 0.2
                        }
                    }
                }
                if self.viewHilightModes.imageView == .light {
                    for v in self.subviews {
                        if v is UIImageView {
                            v.alpha = 0.2
                        }
                    }
                }
                
                if self.viewHilightModes.imageView == .dark {
                    for v in self.coverImageViewViews {
                        v.isHidden = false
                    }
                }
                
                if self.viewHilightModes.uiView == .light {
                    for v in self.subviews {
                        if self.isView(v: v) {
                            v.alpha = 0.2
                        }
                    }
                }
                if self.viewHilightModes.uiView == .dark {
                    for v in self.coverViewViews {
                        v.isHidden = false
                    }
                }
                
        },
            completion: nil)
    }
    
    // 離された状態
    func showUpState(animation:Bool) {
        if onTouch {
            onTouch = false
        }
        else {
            return
        }
        
        UIView.animate(
            withDuration: animation ? 0.2 : 0,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                
                if self.viewHilightModes.cover == .light {
                    self.alpha = self.defaultAlpha
                    return
                }
                
                if self.viewHilightModes.cover == .dark {
                    self.allCoverView?.isHidden = true
                    return
                }
                if self.viewHilightModes.cover == .white {
                    self.allCoverView?.isHidden = true
                    return;
                }
                
                if self.viewHilightModes.label == .light {
                    for v in self.subviews {
                        if v is UILabel {
                            v.alpha = 1.0
                        }
                    }
                }
                
                if self.viewHilightModes.imageView == .light {
                    for v in self.subviews {
                        if v is UIImageView {
                            v.alpha = 1.0
                        }
                    }
                }
                
                if self.viewHilightModes.imageView == .dark {
                    for v in self.coverImageViewViews {
                        v.isHidden = true
                    }
                }
                
                if self.viewHilightModes.uiView == .light {
                    for v in self.subviews {
                        if self.isView(v: v) {
                            //TODO:default alpha
                            v.alpha = 1.0
                        }
                    }
                }
                
                if self.viewHilightModes.uiView == .dark {
                    for v in self.coverViewViews {
                        v.isHidden = true
                    }
                }
                
                
        },
            completion: nil)
    }
    
    //MARK:UIControlState function
    
    var highlightedView:UIView?
    var disabledView:UIView?
    var selectedView:UIView?
    // 未実装:fucused,application,reserved
    
    struct StateStyle {
        let state:UIControlState
        let textColor:UIColor
        let backgroundColor:UIColor
    }
    
    var stateStyles:[StateStyle] = []
}

// ControlState
extension ButtonView {
    
    func setView(view:UIView?, forState:UIControlState) {
        guard let view = view else {
            return;
        }
        
        if forState == UIControlState.highlighted {
            highlightedView = view
            highlightedView!.tag = 1
            highlightedView!.isUserInteractionEnabled = false
            removeView(tag: 1)
            self.addSubviewAndFit(subview: highlightedView!, parentView: self)
            
        }
        if forState == UIControlState.disabled {
            disabledView = view
            disabledView!.tag = 2
            disabledView!.isUserInteractionEnabled = false
            removeView(tag: 2)
            self.addSubviewAndFit(subview: disabledView!, parentView: self)
            
        }
        if forState == UIControlState.selected {
            selectedView = view
            selectedView!.tag = 3
            selectedView!.isUserInteractionEnabled = false
            removeView(tag: 3)
            self.addSubviewAndFit(subview: selectedView!, parentView: self)
        }
        
        didSetControlStates()
    }
    
    func addStateStyle(style: StateStyle) {
        stateStyles.append(style)
    }
    
    func removeView(tag:Int) {
        for v:UIView in self.subviews {
            if v.tag == tag {
                v.removeFromSuperview()
            }
        }
    }
    
    override var isHighlighted: Bool {
        willSet {
        }
        
        didSet {
            self.didSetControlStates()
        }
    }
    
    override var isEnabled: Bool {
        willSet {
        }
        
        didSet {
            self.didSetControlStates()
        }
    }
    
    override var isSelected: Bool {
        willSet {
        }
        
        didSet {
            self.didSetControlStates()
        }
    }
    
    func didSetControlStates() {
        allControlStatesSubviewHidden()
        
        if self.isHighlighted {
            if let highlightedView = highlightedView {
                highlightedView.isHidden = false
            }
        }
        if !self.isEnabled {
            if let disabledView = disabledView {
                disabledView.isHidden = false
            }
        }
        if self.isSelected {
            if let selectedView = selectedView {
                selectedView.isHidden = false
            }
        }
        
        if self.state == .normal {
            let style = stateStyles.filter { $0.state == .normal }
            if let style = style.first {
                self.backgroundColor = style.backgroundColor
                setLabelsTextColor(color: style.textColor)
            }
        }
        if self.state == .highlighted {
            let style = stateStyles.filter { $0.state == .highlighted }
            if let style = style.first {
                self.backgroundColor = style.backgroundColor
                setLabelsTextColor(color: style.textColor)
            }
        }
        if self.state == .disabled {
            let style = stateStyles.filter { $0.state == .disabled }
            if let style = style.first {
                self.backgroundColor = style.backgroundColor
                setLabelsTextColor(color: style.textColor)
            }
        }
        if self.state == .selected {
            let style = stateStyles.filter { $0.state == .selected }
            if let style = style.first {
                self.backgroundColor = style.backgroundColor
                setLabelsTextColor(color: style.textColor)
            }
        }
    }
    
}

// Util
extension ButtonView {
    
    func isView(v:Any?) -> Bool {
        // UIView (without label,image)
        
        guard let _ = v else {
            return false
        }
        
        if v is UILabel {
            return false
        }
        if v is UIImage {
            return false
        }
        if v is UIView {
            return true
        }
        
        return false
    }
    
    func setLabelsTextColor(color:UIColor) {
        self.subviews.forEach { (view) in
            if (view is UILabel) {
                (view as! UILabel).textColor = color
            }
        }
    }
}

// Layout
extension ButtonView {
    
    func addSubviewAndFit(subview:UIView, parentView:UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(subview)
        parentView.addConstraint(NSLayoutConstraint(item: subview, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: 0.0))
        parentView.addConstraint(NSLayoutConstraint(item: subview, attribute: .leading, relatedBy: .equal, toItem: parentView, attribute: .leading, multiplier: 1.0, constant: 0.0))
        parentView.addConstraint(NSLayoutConstraint(item: parentView, attribute: .bottom, relatedBy: .equal, toItem: subview, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        parentView.addConstraint(NSLayoutConstraint(item: parentView, attribute: .trailing, relatedBy: .equal, toItem: subview, attribute: .trailing, multiplier: 1.0, constant: 0.0))
    }
    
    func allControlStatesSubviewHidden() {
        for subview:UIView in self.subviews {
            if (subview.isEqual(highlightedView) ||
                subview.isEqual(disabledView) ||
                subview.isEqual(selectedView)) {
                
                subview.isHidden = true
            }
        }
    }
    
    // AutoLayout
    func fill(subView:UIView) {
        if let parentView = subView.superview {
            parentView.addConstraint(
                NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: 0.0))
            parentView.addConstraint(
                NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: parentView, attribute: .leading, multiplier: 1.0, constant: 0.0))
            parentView.addConstraint(
                NSLayoutConstraint(item: parentView, attribute: .bottom, relatedBy: .equal, toItem: subView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
            parentView.addConstraint(
                NSLayoutConstraint(item: parentView, attribute: .trailing, relatedBy: .equal, toItem: subView, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        }
    }
}


//MARK: - enum
extension ButtonView {
    
    enum ButtonViewType {
        case componentLight     //Default. It get lighter all subviews（without background）. 
        case componentDark      //It get darker all subviews（without background and label）.
        
        case lighterTheWhole    //It get lighter parent view by alpha.
        case darkerTheWhole     //It get darker parent view by cover view.
        case whiteTheWhole      //It get whiter by cover view
        
        case likeUIButtonPlane  //It get lighter only labels.
        case likeUIButtonCustom //It get darker only images.
        case likeUIButton       //if(exist images) -> likeUIButtonCustom else -> likeUIButtonPlane
        
        case noChange           //No change in visible.
        
        case customMode         //Specify individually
    }
    
    enum HilightMode {
        case none       // Nothing todo
        case dark
        case light
        case white
    }
}

extension ButtonView {
    
    // 各パーツ毎の設定
    class ViewHilightModes {
        var cover:HilightMode = .none
        var label:HilightMode = .none
        var imageView:HilightMode = .none
        var uiView:HilightMode = .none
        
        func setModes(cover:HilightMode, label:HilightMode, imageView:HilightMode, uiView:HilightMode) {
            self.cover = cover
            self.label = label
            self.imageView = imageView
            self.uiView = uiView
        }
        
        func setToNone() {
            cover = .none
            label = .none
            imageView = .none
            uiView = .none
        }
        
        func setupHighlight(type:ButtonViewType) {
            
            switch type {
            case .likeUIButton:
                setToNone()
            case .likeUIButtonPlane:
                setModes(cover: .none, label: .light, imageView: .none, uiView: .none)
            case .likeUIButtonCustom:
                setModes(cover: .none, label: .none, imageView: .dark, uiView: .dark)
            case .componentLight:
                setModes(cover: .none, label: .light, imageView: .light, uiView: .light)
            case .componentDark:
                setModes(cover: .none, label: .dark, imageView: .dark, uiView: .dark)
            case .lighterTheWhole:
                setModes(cover: .light, label: .none, imageView: .none, uiView: .none)
            case .darkerTheWhole:
                setModes(cover: .dark, label: .none, imageView: .none, uiView: .none)
            case .noChange:
                setToNone()
            case .whiteTheWhole:
                setModes(cover: .white, label: .none, imageView: .none, uiView: .none)
            case .customMode:
                setToNone()
            }
        }
    }
}

extension ButtonView {
    func createCoverView() {
        // ImageViewとUIViewを暗くするために、上にViewを重ねている
        // 必要な場合、必要な分生成する
        if viewHilightModes.imageView == .dark {
            self.addDarkCoverViewsForImageView()
        }
        
        if viewHilightModes.uiView == .dark {
            self.addDarkCoverViewsForViews()
        }
    }
    
    // imageviewを覆うdark view
    func addDarkCoverViewsForImageView() {
        if (coverImageViewViews.count > 0) {
            // 作成済み
            return
        }
        
        for subview in self.subviews {
            if subview is UIImageView {
                let coverView = UIView()
                coverView.frame = subview.bounds
                coverView.backgroundColor = UIColor.black
                coverView.alpha = 0.5 //DARK_VIEW_ALPHA
                coverView.isHidden = true
                coverView.isUserInteractionEnabled = false
                // 階層を壊さないためにsubviewにaddする
                //（孫階層は壊してしまうので今後の課題）
                subview.addSubview(coverView)
                coverImageViewViews.append(coverView)
            }
        }
    }
    
    // viewを覆うdark view
    func addDarkCoverViewsForViews() {
        if (coverViewViews.count > 0) {
            // 作成済み
            return;
        }
        
        for subview in self.subviews {
            
            if isView(v: subview) {
                let coverView = UIView()
                coverView.frame = subview.bounds
                coverView.backgroundColor = UIColor.black
                coverView.alpha = 0.5 //DARK_VIEW_ALPHA
                coverView.isHidden = true
                coverView.isUserInteractionEnabled = false
                subview.addSubview(coverView)
                coverViewViews.append(coverView)
            }
        }
    }
    
    // 全体を覆うView（white,black）
    func addAllCoverView() {
        
        if (allCoverView != nil) {
            return
        }
        
        allCoverView = UIView()
        
        guard let allCoverView = allCoverView else {
            print("🤔")
            return
        }
        
        allCoverView.frame = self.bounds
        if (self.type == .whiteTheWhole) {
            allCoverView.backgroundColor = UIColor.white
            allCoverView.alpha = 0.7
        }
        else {
            allCoverView.backgroundColor = UIColor.black
            allCoverView.alpha = 0.5
        }
        allCoverView.isHidden = true
        allCoverView.isUserInteractionEnabled = false
        self.addSubview(allCoverView)
    }
}
