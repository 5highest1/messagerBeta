//
//  AuthViewController.swift
//  qChat
//
//  Created by Highest on 12.09.2024.
//

import UIKit

class AuthViewController: UIViewController {
    
    
    var servise = Servise.shared
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var tapGest: UITapGestureRecognizer?
    let userDefault = UserDefaults.standard

    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
    }
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @IBAction func clickAuthBtn(_ sender: Any) {
        if checkField.validField(emailView, emailField),
              checkField.validField(passwordView, passwordField) {
               
               let authData = LoginField(email: emailField.text!, password: passwordField.text!)
               
               servise.authInApp(authData) { [weak self] responce in
                   switch responce {
                   case .succes:
                       self?.userDefault.set(true, forKey: "isLogin")
                       self?.delegate.startApp()
                       self?.delegate.closeVC()
                   case .noVerify:
                       let alert = self?.alertController("Error", "Вы не верифицировали свой email. На вашу почту отправлена ссылка!")
                       let verifyBtn = UIAlertAction(title: "OK", style: .cancel)
                       alert?.addAction(verifyBtn)
                       self?.present(alert!, animated: true)
                       
                   case .error:
                       let alert = self?.alertController("Error", "Email или пароль не подошли")
                       let verifyBtn = UIAlertAction(title: "OK", style: .cancel)
                       alert?.addAction(verifyBtn)
                       self?.present(alert!, animated: true)
                   }
               }
           }
        else {
            let alert = self.alertController("Error", "Заполните все поля!")
            let verifyBtn = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(verifyBtn)
            self.present(alert, animated: true)
        }
       }

       func alertController(_ headler: String?, _ messege: String?) -> UIAlertController {
           let alert = UIAlertController(title: headler, message: messege, preferredStyle: .alert)
           return alert
       }
}
    
//    @IBAction func forgotPassword(_ sender: Any) {
//    }
//
//    @IBAction func clickRegBtn(_ sender: Any) {
//    }
    
    





//                let vc = TabBar()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
