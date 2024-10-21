//
//  RegViewController.swift
//  qChat
//
//  Created by Highest on 12.09.2024.
//

import UIKit

class RegViewController: UIViewController {

    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var servise = Servise.shared
    
    @IBOutlet weak var mainView: UIView!
    
    var tapGest: UITapGestureRecognizer?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var rePasswordField: UITextField!
    @IBOutlet weak var rePasswordView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
    }
    
    @IBAction func closeVc(_ sender: Any) {
        delegate.closeVC()
    }
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    @IBAction func regBtnClick(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField)
        {
            if passwordField.text == rePasswordField.text{
                servise.createNewUser(LoginField(email: emailField.text!, password: passwordField.text!)) {[weak self]code in
                    switch code.code{
                    case 0:
                        print("Произошла ошибка рег")
                    case 1:
                        self?.servise.confimEmail()
                        let alert = UIAlertController(title: "Успешно", message: "Регистрация прошла успешно", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "OK", style: .default) { _ in
                            self?.delegate.closeVC()
                        }
                        alert.addAction(okBtn)
                        self?.present(alert, animated: true)
                        
                    default:
                        print("Неизвестная ошибка")
                    }
                }
            }else {
                print("пароли не совпадают")
            }
        }
    }
}

