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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedYellowButtonView(_ sender: ButtonView) {
        print("tapped yellow button view")
    }
    


}

