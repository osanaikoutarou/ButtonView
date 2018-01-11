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
    let defaultAlpha:CGFloat = 0.0
    var type:ButtonViewType = .componentLight
    
//    // typeで指定
//    - (void)setupType:(CustomButtonViewType)customButtonViewType;
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
            
            if imageView == .dark {
//                addDarkCoverViewsForImageView
            }
            
            if uiView == .dark {
//                addDarkCoverViewsForViews
            }
        }
    }
    let viewHilightModes = ViewHilightModes()
    
    // カバー用
    var coverImageViewViews:[UIView] = []
    var coverViewViews:[UIView] = []
    
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

        
    }
    
    // interface
    func setup(type:ButtonViewType) {
        self.type = type
        viewHilightModes.setupHighlight(type: self.type)
    }
    
    
    // event
    @objc func touchDown() {
    }
    @objc func touchUpInside() {
    }
    @objc func touchUpOutside() {
    }
    @objc func touchDragInside() {
    }
    @objc func touchDragOutside() {
    }
    @objc func touchDragEnter() {
    }
    @objc func touchDragExit() {
    }
    @objc func touchCancel() {
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

