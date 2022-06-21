//
//  ViewController.swift
//  MaskFor Textfield
//
//  Created by BSergio on 20.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tf: UITextField!
    var formatter: PhoneFormatter = PhoneFormatter(pattern: "+# (###) ###-##-##" )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tf.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            guard let formatter = formatter else { return true }
            return formatter.mask(textField, range: range, replacementString: string)
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tf.text = "+7"
    }
}

