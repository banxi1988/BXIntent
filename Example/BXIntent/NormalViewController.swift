//
//  NormalViewController.swift
//  BXIntent
//
//  Created by Haizhen Lee on 11/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import BXIntent


class NormalViewController : UIViewController, IntentComponent{
  public func setExtras(_ extras: [String : Any]?) {
    self.intentExtras = extras ?? [:]
  }
  var intentExtras: [String:Any] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    let label = UILabel(frame: CGRect.zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(label)
    label.pac_center()
    
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = .darkGray
    label.text = "I'm a normal Controller"
  }
}
