//
//  ViewController.swift
//  ButtonViewDemo
//
//  Created by osanai on 2018/01/11.
//  Copyright © 2018年 jp.co.osanai.buttonview.demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var simpleTableView: UITableView!
    
    //    @IBOutlet weak var yellowButtonView: ButtonView!
    
    @IBOutlet var selectedView: UIView!
    @IBOutlet var disabledView: UIView!
    @IBOutlet var highlightView: UIView!
    
    enum CellType {
        case componentLight
        case componentDark
        case baseDark
        case lighterTheWhole
        case likeButtonPlane
        case likeButtonCustom
        case whiteTheWhole
        
        case toggle
        case buttonAndButtonView
        
        func reuseIdentifier() -> String {
            switch self {
            case .componentLight:
                return "componentLight"
            case .componentDark:
                return "componentDark"
            case .baseDark:
                return "baseDark"
            case .lighterTheWhole:
                return "lighterTheWhole"
            case .likeButtonPlane:
                return "likeButtonPlane"
            case .likeButtonCustom:
                return "likeButtonCustom"
            case .whiteTheWhole:
                return "whiteTheWhole"
            case .toggle:
                return "ToggleTableViewCell"
            case .buttonAndButtonView:
                return "ButtonAndButtonViewTableViewCell"
            }
        }
    }
    let cellTypes:[CellType] = [.componentLight,
                                .componentDark,
                                .baseDark,
                                .lighterTheWhole,
                                .likeButtonPlane,
                                .likeButtonCustom,
                                .whiteTheWhole,
                                .toggle,
                                .buttonAndButtonView]
    
    //    @IBOutlet weak var buttonView: ButtonView!
    //    @IBOutlet weak var componentLightButtonView: ButtonView!
    //    @IBOutlet weak var componentDarkButtonView: ButtonView!
    //    @IBOutlet weak var baseDarkButtonView: ButtonView!
    //    @IBOutlet weak var lighterTheWholeButtonView: ButtonView!
    //    @IBOutlet weak var likeButtonPlaneButtonView: ButtonView!
    //    @IBOutlet weak var likeButtonCustomButtonView: ButtonView!
    //    @IBOutlet weak var whiteTheWholeButtonView: ButtonView!
    
    //    @IBOutlet weak var iconImageView1: UIImageView!
    //    @IBOutlet weak var iconImageView2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleTableView.delegate = self
        simpleTableView.dataSource = self
        simpleTableView.delaysContentTouches = false
        //        iconImageView1.layer.cornerRadius = iconImageView1.frame.size.height/2
        //        iconImageView1.clipsToBounds = true
        //        iconImageView2.layer.cornerRadius = iconImageView2.frame.size.height/2
        //        iconImageView2.clipsToBounds = true
        
        
        //        buttonView.setView(view: selectedView, forState: .selected)
        //        buttonView.setView(view: disabledView, forState: .disabled)
        //        buttonView.setView(view: highlightView, forState: .highlighted)
        //
        //        componentLightButtonView.setup(type: .componentLight)
        //        componentDarkButtonView.setup(type: .componentDark)
        //        baseDarkButtonView.setup(type: .darkerTheWhole)
        //        lighterTheWholeButtonView.setup(type: .lighterTheWhole)
        //        likeButtonPlaneButtonView.setup(type: .likeUIButtonPlane)
        //        likeButtonCustomButtonView.setup(type: .likeUIButtonCustom)
        //        whiteTheWholeButtonView.setup(type: .whiteTheWhole)
    }
    
    //    @IBAction func tappedYellowButtonView(_ sender: ButtonView) {
    //        print("tapped yellow button view")
    //    }
    //
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = cellTypes[indexPath.row]
        
        if (cellType == .toggle) {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier(), for: indexPath) as! ToggleTableViewCell
            cell.buttonView.setView(view: selectedView, forState: .selected)
            cell.buttonView.setView(view: disabledView, forState: .disabled)
            cell.buttonView.setView(view: highlightView, forState: .highlighted)
            
            return cell
        }
        else if (cellType == .buttonAndButtonView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier(), for: indexPath) as! ButtonAndButtonViewTableViewCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier(), for: indexPath) as! SimpleTableViewCell
            
            switch cellType {
            case .componentLight:
                cell.buttonView.setup(type: .componentLight)
            case .componentDark:
                cell.buttonView.setup(type: .componentDark)
            case .baseDark:
                cell.buttonView.setup(type: .darkerTheWhole)
            case .lighterTheWhole:
                cell.buttonView.setup(type: .lighterTheWhole)
            case .likeButtonPlane:
                cell.buttonView.setup(type: .likeUIButtonPlane)
            case .likeButtonCustom:
                cell.buttonView.setup(type: .likeUIButtonCustom)
            case .whiteTheWhole:
                cell.buttonView.setup(type: .whiteTheWhole)
            default:
                break
            }
            
            return cell
        }
    }
}

class SimpleTableViewCell:UITableViewCell {
    @IBOutlet weak var buttonView: ButtonView!
    @IBOutlet weak var circleIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if circleIconImageView != nil {
            circleIconImageView.layer.cornerRadius = circleIconImageView.frame.size.height/2
            circleIconImageView.clipsToBounds = true
        }
    }
}

class ToggleTableViewCell:UITableViewCell {
    @IBOutlet weak var buttonView: ButtonView!
    
    @IBAction func tappedToggleSelected(_ sender: UIButton) {
        buttonView.isSelected = !buttonView.isSelected
    }
    @IBAction func tappedToggleEnabled(_ sender: UIButton) {
        buttonView.isEnabled = !buttonView.isEnabled
    }
    
}

class ButtonAndButtonViewTableViewCell:UITableViewCell {
    @IBOutlet weak var faceLabel1: UILabel!
    @IBOutlet weak var faceLabel2: UILabel!
    
    var face1 = false
    var face2 = false
    
    @IBAction func tappedButton(_ sender: UIButton) {
        face1 = !face1
        faceLabel1.text = face1 ? "😃" : "🙂"
    }
    @IBAction func tappedButtonView(_ sender: ButtonView) {
        face2 = !face2
        faceLabel2.text = face2 ? "😃" : "🙂"
    }
}
