//
//  CalcResultViewController.swift
//  BXIntent
//
//  Created by Haizhen Lee on 11/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import BXIntent

struct  CalcResult: IntentResult{
  let result: Double
  init(result: Double){
    self.result = result
  }
}

class CalcResultViewController: UIViewController ,IntentForResultComponent {
   var requestCode: Int = 0
   var intentResultDelegate: IntentResultDelegate? = nil
 
    private var intentExtras:[String:Any] = [:]
    func setExtras(_ extras: [String : Any]?) {
      self.intentExtras = extras ?? [:]
    }

    var resultValue: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
      let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
      navigationItem.rightBarButtonItem = doneItem
      
      let a = intentExtras["a"] as? Int ?? 0
      let b = intentExtras["b"] as? Int ?? 0
      resultValue = Double(a) * Double(b)
      let label = UILabel(frame: CGRect.zero)
      label.translatesAutoresizingMaskIntoConstraints = false
      
      self.view.addSubview(label)
      label.pac_center()
      
      label.font = UIFont.systemFont(ofSize: 18)
      label.textColor = .darkGray
      label.text = "\(a) * \(b) = \(resultValue)"
      
    }
  
    func onDone(sender:AnyObject){
      dismiss(animated: true, completion: nil)
      let result = CalcResult(result: resultValue)
      intentResultDelegate?.onIntentResult(requestCode: requestCode, resultCode: .ok, result:result)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

