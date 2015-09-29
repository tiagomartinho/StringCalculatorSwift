import UIKit
import SVProgressHUD

class StringCalculatorViewController: UIViewController {
    
    @IBOutlet weak var stringInput: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    @IBAction func calculate() {
        showLoadingInterface()
        executeInBackground {
           let result = self.stringCalculatorResult(self.stringInput.text)
            self.executeInMainThread {
                self.hideLoadingInterface()
                self.result.text = result
            }
        }
    }
    
    func executeInBackground(block:Void->Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            block()
        }
    }
    
    func executeInMainThread(block:Void->Void){
        dispatch_async(dispatch_get_main_queue()) {
            block()
        }
    }
    
    func stringCalculatorResult(input:String?)->String{
        let calculator = StringCalculator(numbers: input ?? "")
        do {
            return "\(try calculator.add())"
        } catch StringCalculatorError.NegativeNotAllowed(let negativeNumbers){
            return "Negative numbers are not allowed. Negative Numbers: \(negativeNumbers)"
        }
        catch {
            return ""
        }
    }
    
    func showLoadingInterface(){
        SVProgressHUD.show()
    }
    
    func hideLoadingInterface(){
        SVProgressHUD.dismiss()
    }
}

