//
//  DatabaseManager.swift
//  Messanger
//
//  Created by Meheretab M on 25/08/2021.
//

import Foundation
import FirebaseDatabase


final class DatabaseManager{
  static  let shared = DatabaseManager()
  private let database = Database.database().reference()

    
        
}

//MARK: --- Account manager
extension DatabaseManager{
    public func userExist(with email:String,completion: @escaping ((Bool) -> Void
    )) {
        database.child("email").observeSingleEvent(of: .value) { snapshot in
            guard  snapshot.value as? String != nil else{
                completion(false)
                return
            }
            completion(true)
            
        }
    }
    ///insert a new user to databse
    public func insertUser(with user:ChatAppUser){
        database.child(user.emailAddress).setValue(
            ["first_name":user.firstName,
             "last_name":user.lastName
            ]
        )
    }

}


struct ChatAppUser{
    let firstName: String
    let lastName: String
    let emailAddress: String
    //let profilePictureUrl :String
    
    
}
