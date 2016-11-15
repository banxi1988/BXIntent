
public protocol ControllerPresenter {
  func present(viewController: UIViewController, from: UIViewController)
}

open class ControllerPushPresenter: ControllerPresenter{
  public func present(viewController: UIViewController, from: UIViewController) {
    if let navigationController = from.navigationController{
      navigationController.pushViewController(viewController, animated: true)
    }else{
      fatalError("No UINavigationController")
    }
  }
}

open class ControllerPresentationPresenter: ControllerPresenter{
  public func present(viewController: UIViewController, from: UIViewController) {
    let nav = UINavigationController(rootViewController: viewController)
    from.present(nav, animated: true, completion: nil)
  }
}

public protocol IntentResult{
  
}


public protocol IntentComponent{
  func setExtras(_ extras: [String:Any]?)
}

public enum IntentResultCode: Int{
  case ok
  case cancel
}

public protocol IntentResultDelegate{
  func onIntentResult(requestCode:Int, resultCode:IntentResultCode, result: IntentResult?)
}

public protocol IntentForResultComponent: IntentComponent{
  var requestCode : Int { set get }
  var intentResultDelegate: IntentResultDelegate? { set get }
}

public struct Intent<T:UIViewController> where T:IntentComponent{
  public var controllerPresenter:ControllerPresenter = ControllerPushPresenter()
  public fileprivate(set) var extras = [String:Any]()
  
  public init(){
  }
  
  public mutating func putExtra(name: String ,data: Any){
    extras[name]   = data
  }
  
}



public extension UIViewController{
 
  func startController<T>(intent:Intent<T>){
    startControllerForResultInternal(intent: intent, requestCode: 0)
  }
  
  func startControllerForResult<T: IntentForResultComponent>(intent: Intent<T>, requestCode:Int){
    assert(requestCode > 0, "requestCode should > 0")
    var adjustIntent = intent
    if intent.controllerPresenter is ControllerPushPresenter{
      adjustIntent.controllerPresenter = ControllerPresentationPresenter()
    }
    startControllerForResultInternal(intent: adjustIntent, requestCode: requestCode)
  }
  
  private func startControllerForResultInternal<T>(intent:Intent<T>, requestCode:Int){
    let controller = T(nibName: nil,  bundle: nil)
    controller.setExtras(intent.extras)
    if requestCode > 0{
      if var resultController = controller as? IntentForResultComponent{
          resultController.intentResultDelegate = self as? IntentResultDelegate
          resultController.requestCode = requestCode
      }else{
        fatalError("controllerClass should conform to IntentForResultComponent")
      }
    }
    
    intent.controllerPresenter.present(viewController: controller, from: self)
    
    
  }
  
}
