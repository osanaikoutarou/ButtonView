//
//  ViewController.swift
//  ButtonViewDemo
//
//  Created by osanai on 2018/01/11.
//  Copyright © 2018年 jp.co.osanai.buttonview.demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var yellowButtonView: ButtonView!
    
    @IBOutlet var selectedView: UIView!
    @IBOutlet var disabledView: UIView!
    @IBOutlet var highlightView: UIView!
    
    @IBOutlet weak var buttonView: ButtonView!
    @IBOutlet weak var componentLightButtonView: ButtonView!
    @IBOutlet weak var componentDarkButtonView: ButtonView!
    @IBOutlet weak var baseDarkButtonView: ButtonView!
    @IBOutlet weak var lighterTheWholeButtonView: ButtonView!
    @IBOutlet weak var likeButtonPlaneButtonView: ButtonView!
    @IBOutlet weak var likeButtonCustomButtonView: ButtonView!
    
    @IBOutlet weak var iconImageView1: UIImageView!
    @IBOutlet weak var iconImageView2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconImageView1.layer.cornerRadius = iconImageView1.frame.size.height/2
        iconImageView1.clipsToBounds = true
        iconImageView2.layer.cornerRadius = iconImageView2.frame.size.height/2
        iconImageView2.clipsToBounds = true

        
        buttonView.setView(view: selectedView, forState: .selected)
        buttonView.setView(view: disabledView, forState: .disabled)
        buttonView.setView(view: highlightView, forState: .highlighted)
        
        componentLightButtonView.setup(type: .componentLight)
        componentDarkButtonView.setup(type: .componentDark)
        baseDarkButtonView.setup(type: .darkerTheWhole)
        lighterTheWholeButtonView.setup(type: .lighterTheWhole)
        likeButtonPlaneButtonView.setup(type: .likeUIButtonPlane)
        likeButtonCustomButtonView.setup(type: .likeUIButtonCustom)
    }

    @IBAction func tappedYellowButtonView(_ sender: ButtonView) {
        print("tapped yellow button view")
    }
    
    @IBAction func tappedToggleSelected(_ sender: UIButton) {
        buttonView.isSelected = !buttonView.isSelected
    }
    @IBAction func tappedToggleEnabled(_ sender: UIButton) {
        buttonView.isEnabled = !buttonView.isEnabled
    }


}

