//
//  RegisterViewController.swift
//  Messanger
//
//  Created by Meheretab M on 23/08/2021.
//

import UIKit
import FirebaseAuth
class RegisterViewController: UIViewController,UINavigationControllerDelegate {

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
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
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
       // emailField.delegate = self
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
        presentPhotoActionSheet()
        
        
    }
    //MARK: view did layout subview
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = view.width / 3
        imageView.frame = CGRect(x: (scrollView.width -  size) / 2, y: 20 , width: size, height: size)
        imageView.layer.cornerRadius = imageView.width / 2.0
        firstNameField.frame = CGRect(x: 30 , y: imageView.bottom + 10 , width: scrollView.width - 60, height: 52)
        lastNameField.frame = CGRect(x: 30 , y: firstNameField.bottom + 10 , width: scrollView.width - 60, height: 52)
        emailField.frame = CGRect(x: 30 , y: lastNameField.bottom + 10 , width: scrollView.width - 60, height: 52)
        passwordField.frame = CGRect(x: 30 , y: emailField.bottom + 10 , width: scrollView.width - 60, height: 52)
        registerButton.frame = CGRect(x: 30 , y: passwordField.bottom + 10 , width: scrollView.width - 60, height: 52)
        
      
    }
    //MARK: login butun tapped
    @objc private func registerButtonTapped(){
       // emailField.resignFirstResponder()
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
        
        DatabaseManager.shared.userExist(with: email) {[weak self] exists in
            guard let strongSelf = self else{ return }
            guard !exists else{
                strongSelf.alertUserLoginError(message: "User already exists")
                return
            }
            
            //Firebae login
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
               
                guard result != nil, error == nil else {
                    print("Errror while creating the user")
                    return
                }
                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
                
                strongSelf.navigationController?.dismiss(animated: true,completion: nil)
            }
        }
        
        
    }
    //MARK: Alert
    func alertUserLoginError(message:String = "Please enter all information to create new acount") {
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
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

extension RegisterViewController: UIImagePickerControllerDelegate {
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "how would you like to select a picture?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(  UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(  UIAlertAction(title: "Take Photo", style: .default, handler: {
            [weak self] _ in  self?.presentCamera()
        }))
        actionSheet.addAction(  UIAlertAction(title: "Choose Photo ", style: .default, handler: {
            [weak self]  _ in self?.presentPhotoPicker()
        }))
        present(actionSheet, animated: true)
    }
    func presentCamera(){
     let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing  = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
              vc.delegate = self
              vc.allowsEditing  = true
              present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard  let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        self.imageView.image = selectedImage
            print(info)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
