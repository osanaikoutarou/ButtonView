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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonView.setView(view: selectedView, forState: .selected)
        buttonView.setView(view: disabledView, forState: .disabled)
        buttonView.setView(view: highlightView, forState: .highlighted)
        
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

