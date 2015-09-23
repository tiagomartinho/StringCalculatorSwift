import UIKit

class StringCalculatorViewController: UIViewController {
    
    @IBOutlet weak var stringInput: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    @IBAction func calculate() {
        let calculator = StringCalculator(numbers: stringInput.text ?? "")
        do {
            result.text = "\(try calculator.add())"
        }
        catch {
        }
    }
}

