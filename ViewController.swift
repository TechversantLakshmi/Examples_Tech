//
//  ViewController.swift
//  FaceID
//
//  Created by Rashif on 30/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var verifyButton: UIButton!
    private let biometricIDAuth = BiometricIDAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyButton.setImage(UIImage(systemName: "faceid"),  for: .normal)
    }
    
    @IBAction func verifyDidTap(_ sender: UIButton) {
        biometricIDAuth.canEvaluate { (canEvaluate, _, canEvaluateError) in
            guard canEvaluate else {
                alert(title: "Error",
                      message: canEvaluateError?.localizedDescription ?? "Face ID/Touch ID may not be configured",
                      okActionTitle: "Darn!")
                return
            }
            
            biometricIDAuth.evaluate { [weak self] (success, error) in
                guard success else {
                    self?.alert(title: "Error",
                                message: error?.localizedDescription ?? "Face ID/Touch ID may not be configured",
                                okActionTitle: "Darn!")
                    return
                }
                
                self?.alert(title: "Success",
                            message: "You have a free pass, now",
                            okActionTitle: "Yay!")
            }
        }
    }
    
    func alert(title: String, message: String, okActionTitle: String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }

}

