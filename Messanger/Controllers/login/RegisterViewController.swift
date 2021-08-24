//
//  RegisterViewController.swift
//  Messanger
//
//  Created by Meheretab M on 23/08/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    private let firstNameField :UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue //cont to pasword field
        field.layer.cornerRadius  = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name.."
        field.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    private let lastNameField :UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue //cont to pasword field
        field.layer.cornerRadius  = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name.."
        field.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let emailField :UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue //cont to pasword field
        field.layer.cornerRadius  = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address.."
        field.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    private let passwordField :UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done ///after finishing typing email just make login
        field.layer.cornerRadius  = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    // MARK: Login button
    private let registerButton: UIButton =  {
        let button  = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.masksToBounds = true
        return button
    }()
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
       
        // when user types password field it calls login button
        //when the user finshes type email it calls activate passoword field
        emailField.delegate = self
        passwordField.delegate = self
        
        // Add subview first scrollview then other elements to scrollview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)

        let gusture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilepic))
        gusture.numberOfTouchesRequired = 1
        gusture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gusture)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    } 
    @objc private func didTapChangeProfilepic(){
        print("change pics called")
        
    }
    //MARK: view did layout subview
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = view.width / 3
        imageView.frame = CGRect(x: (scrollView.width -  size) / 2, y: 20 , width: size, height: size)
        firstNameField.frame = CGRect(x: 30 , y: imageView.bottom + 10 , width: scrollView.width - 60, height: 52)
        lastNameField.frame = CGRect(x: 30 , y: firstNameField.bottom + 10 , width: scrollView.width - 60, height: 52)
        emailField.frame = CGRect(x: 30 , y: lastNameField.bottom + 10 , width: scrollView.width - 60, height: 52)
        passwordField.frame = CGRect(x: 30 , y: emailField.bottom + 10 , width: scrollView.width - 60, height: 52)
        registerButton.frame = CGRect(x: 30 , y: passwordField.bottom + 10 , width: scrollView.width - 60, height: 52)
        
      
    }
    //MARK: login butun tapped
    @objc private func registerButtonTapped(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text ,
              let password = passwordField.text,
              !email.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !password.isEmpty,
              password.count >= 6 else {
            alertUserLoginError()
            return
        }
    }
    //MARK: Alert
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to create new acount", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    @objc private func didTapRegister(){
        let vc  = RegisterViewController()
        
        vc.title  = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
 

}

extension RegisterViewController: UITextFieldDelegate {
      func textFieldShouldReturn( _ textField:UITextView) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
            
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}

