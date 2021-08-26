//
//  ViewController.swift
//  Messanger
//
//  Created by Meheretab M on 23/08/2021.
//

import UIKit
import FirebaseAuth
class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
         
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //checks if the user is login before like preference thing
       /// let logedIn = UserDefaults.standard.bool(forKey: "login_key")
        validateAuth()
         
    }
    
    
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc  = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }

}

