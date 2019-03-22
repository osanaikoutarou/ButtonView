//
//  LikeButtonControl.swift
//  ButtonViewDemo
//
//  Created by osanai on 2019/03/22.
//  Copyright © 2019 jp.co.osanai.buttonview.demo. All rights reserved.
//

// UIButtonのような見た目をするUIControl
// ただしNormal状態での挙動のみ
// highlighted,selected,disableなどは含まれていません

import Foundation
import UIKit

class LikeButtonControl: UIControl {
        
    var defaultAlpha:CGFloat = 1.0
    let viewTransparentAlpha:CGFloat = 0.2
    
    // タッチ状態
    fileprivate var onTouch:Bool = false
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    fileprivate func commonInit() {
        addTargets()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultAlpha = self.alpha
    }
    
    fileprivate func addTargets() {
        addTarget(self, action: #selector(touchDown),           for: .touchDown)
        addTarget(self, action: #selector(touchUpInside),       for: .touchUpInside)
        addTarget(self, action: #selector(touchUpOutside),      for: .touchUpOutside)
        addTarget(self, action: #selector(touchDragInside),     for: .touchDragInside)
        addTarget(self, action: #selector(touchDragOutside),    for: .touchDragOutside)
        addTarget(self, action: #selector(touchDragEnter),      for: .touchDragEnter)
        addTarget(self, action: #selector(touchDragExit),       for: .touchDragExit)
        addTarget(self, action: #selector(touchCancel),         for: .touchCancel)
    }
    
}

//MARK: Event handling
extension LikeButtonControl {
    
    @objc func touchDown() {
        showTouchState(animation: false)
    }
    @objc func touchUpInside() {
        showUpState(animation: true)
    }
    @objc func touchUpOutside() {
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
    
    // タップされた時
    func showTouchState(animation:Bool) {
        if onTouch {
            return
        }
        else {
            onTouch = true
        }
        
        UIView.animate(withDuration: animation ? 0.2 : 0, delay: 0, options: .curveEaseOut, animations: {
            self.performAllSubviews(todo: { (view) in
                if view is UILabel {
                    view.alpha = self.viewTransparentAlpha
                }
                if view is UIImageView {
                    view.alpha = self.viewTransparentAlpha
                }
            })
        }, completion: nil)
    }
    
    // 離された時
    func showUpState(animation:Bool) {
        if onTouch {
            onTouch = false
        }
        else {
            return
        }
        
        UIView.animate(withDuration: animation ? 0.25 : 0, delay: 0, options: .curveEaseIn, animations: {
            self.performAllSubviews(todo: { (view) in
                if view is UILabel {
                    view.alpha = self.defaultAlpha
                }
                if view is UIImageView {
                    view.alpha = self.defaultAlpha
                }
            })
        }, completion: nil)
    }
}

private extension UIView {
    func performAllSubviews(todo:((_ view: UIView) -> Void)) {
        todo(self)
        self.subviews.forEach {
            $0.performAllSubviews(todo: todo)
        }
    }
}
