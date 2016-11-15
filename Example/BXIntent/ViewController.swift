//
//  ViewController.swift
//  BXIntent
//
//  Created by banxi1988 on 11/15/2016.
//  Copyright (c) 2016 banxi1988. All rights reserved.
//

import UIKit
import PinAuto
import BXIntent

struct IntentRequestCode{
  static let calcResult = 1
}

class ViewController: UIViewController {
  
    let calcButton = UIButton(type: .system)
    let normalButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
      
      calcButton.setTitle("计算 3 + 4 = ?", for: .normal)
      normalButton.setTitle("普通打开一个 VC", for: .normal)
      
      self.view.backgroundColor = .white
      var previewButton:UIButton?
      for button in [calcButton, normalButton]{
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        button.pac_horizontal(16)
        button.pa_height.eq(38).install()
        
        if let previewItem = previewButton{
            button.pa_below(previewItem, offset: 16).install()
        }else{
          button.pa_below(topLayoutGuide, offset: 36).install()
        }
        
        previewButton = button
        
        button.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        
      }
        // Do any additional setup after loading the view, typically from a nib.
    }
 
  
   @IBAction func onTapButton(sender:UIButton){
    switch sender {
    case calcButton:
        var intent = Intent<CalcResultViewController>()
        intent.putExtra(name: "a", data: 3)
        intent.putExtra(name: "b", data: 4)
        startControllerForResult(intent: intent, requestCode: IntentRequestCode.calcResult)
      break
    case normalButton:
      let intent = Intent<NormalViewController>()
      startController(intent: intent)
      break
    default: break
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func show(tip:String){
    let alert = UIAlertController(title: "提示", message: tip, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }

}

extension ViewController: IntentResultDelegate{
  public func onIntentResult(requestCode: Int, resultCode: IntentResultCode, result: IntentResult?) {
    switch requestCode {
    case IntentRequestCode.calcResult:
      if let result = result as? CalcResult{
        show(tip:"计算结果为: \(result.result)")
      }
      break
    default:
      break
    }
  }
}

