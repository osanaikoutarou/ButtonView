//
//  ButtonView.swift
//  ButtonView
//
//  Created by osanai on 2018/01/11.
//  Copyright © 2018年 jp.co.osanai.buttonview.demo. All rights reserved.
//

import UIKit

class ButtonView: UIControl {
    
    enum ButtonViewType {
        case likeUIButton           //UIButtonのようにする、画像がある場合はCustom、ない場合はPlane
        case likeUIButtonPlane      //ラベルを明るくするのみ、imageは無視
        case likeUIButtonCustom    //ラベルを変えない、画像が暗くなる
        case componentLight        //全部の子Viewを明るく（background以外）
        case componentDark         //全部暗く（background以外）
        case baseLight             //全体を明るく（alphaがかかるので親Viewの色が透ける）
        case baseDark              //全体を暗く
        case noChange              //何もしない
        case customMode            //個別に指定する
    }
    
    enum HilightMode {
        case none
        case dark
        case light
    }
    
    var backgroundImageName:String?
    let defaultAlpha:CGFloat = 1.0
    var type:ButtonViewType = .componentLight
    
    
//    // あるいは細かく指定　※直下の子Viewのみに対するルール
//    - (void)setupBackground:(ViewShowMode)backgroundMode
//    label:(ViewShowMode)labelMode
//    image:(ViewShowMode)imageMode
//    view:(ViewShowMode)viewMode;
//
//    // Action
//    - (void)setupTappedAction:(ActionBlock)block;
    
    // 各パーツ毎の設定
    class ViewHilightModes {
        var background:HilightMode = .none
        var label:HilightMode = .none
        var imageView:HilightMode = .none
        var uiView:HilightMode = .none
        
        func resetToNone() {
            background = .none
            label = .none
            imageView = .none
            uiView = .none
        }
        
        func setupHighlight(type:ButtonViewType) {
            resetToNone()
            
            switch type {
            case .likeUIButton:
                
                break
            case .likeUIButtonPlane:
                label = .light
                break
            case .likeUIButtonCustom:
                imageView = .dark
                label = .none
                uiView = .dark
                break
            case .componentLight:
                imageView = .light
                label = .light
                uiView = .light
                break
            case .componentDark:
                imageView = .dark
                label = .dark
                uiView = .dark
                break
            case .baseLight:
                break
            case .baseDark:
//                addAllCoverView
                break
            case .noChange:
                break
            case .customMode:
                break
            }
        }
    }
    let viewHilightModes = ViewHilightModes()
    
    // カバー用
    var coverImageViewViews:[UIView] = []
    var coverViewViews:[UIView] = []
    var allCoverView:UIView?

    func setupCoverView() {
        if viewHilightModes.imageView == .dark {
            self.addDarkCoverViewsForImageView()
        }
        
        if viewHilightModes.uiView == .dark {
            self.addDarkCoverViewsForViews()
        }
    }
    
    // imageviewを覆うdark view
    func addDarkCoverViewsForImageView() {
        if (coverImageViewViews.count>0) {
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
                subview.addSubview(coverView)
                coverImageViewViews.append(coverView)
            }
        }
    }
    
    // viewを覆うdark view
    func addDarkCoverViewsForViews() {
        if (coverViewViews.count>0) {
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
    
    // 全体を覆うdark view
    func addAllCoverView() {
        
        if (allCoverView != nil) {
            return
        }
        
        allCoverView = UIView()
        allCoverView?.frame = self.bounds
        allCoverView?.backgroundColor = UIColor.black
        allCoverView?.alpha = 0.5 //DARK_VIEW_ALPHA
        allCoverView?.isHidden = true
        allCoverView?.isUserInteractionEnabled = false
        self.addSubview(allCoverView!)
        
    }
    
    
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
        
        addTarget(self, action: #selector(touchDown),           for: .touchDown)
        addTarget(self, action: #selector(touchUpInside),       for: .touchUpInside)
        addTarget(self, action: #selector(touchUpOutside),      for: .touchUpOutside)
        addTarget(self, action: #selector(touchDragInside),     for: .touchDragInside)
        addTarget(self, action: #selector(touchDragOutside),    for: .touchDragOutside)
        addTarget(self, action: #selector(touchDragEnter),      for: .touchDragEnter)
        addTarget(self, action: #selector(touchDragExit),       for: .touchDragExit)
        addTarget(self, action: #selector(touchCancel),         for: .touchCancel)

        setup(type: .likeUIButtonPlane)
    }
    
    // interface
    func setup(type:ButtonViewType) {
        self.type = type
        viewHilightModes.setupHighlight(type: self.type)
        setupCoverView()
    }
    
    // event
    @objc func touchDown() {
        print("touch down")
//        UITouch *touch = [[event allTouches] anyObject];
//        touchDownPoint = [touch locationInView:self];
        
        showTouchState(animation: false)
    }
    @objc func touchUpInside() {
        print("touch up inside")
        showUpState(animation: true)

//        if (touchUpInsideAction) {
//            touchUpInsideAction(self);
//        }
    }
    @objc func touchUpOutside() {
        print("touch up outside")
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
                
                if self.viewHilightModes.background == .light {
                    self.alpha = 0.2
                    return;
                }
                if self.viewHilightModes.background == .dark {
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
                
                if self.viewHilightModes.background == .light {
                    self.alpha = self.defaultAlpha
                    return
                }
                
                if self.viewHilightModes.background == .dark {
                    self.allCoverView?.isHidden = true
                    return
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
    
    // util
    func isView(v:Any?) -> Bool {
        // UIViewであり、label、imageではないものすべて
        
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
    
    
}

