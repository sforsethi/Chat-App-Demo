//
//  ViewController.swift
//  Chat App Demo
//
//  Created by The Taste Affair on 08/02/19.
//  Copyright © 2019 Raghav Sethi. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let newMessageImage = UIImage(named: "newMessage")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: newMessageImage , style: .plain, target: self, action: #selector(handleNewMessage))
        checkiFUserLoggedIn()

    }
    @objc func handleNewMessage() {
        
    }
    
    func checkiFUserLoggedIn()  {
        
        if Auth.auth().currentUser?.uid == nil  {
            handleLogout()
            print("UID thing happened")

        }
        else    {
//            let uid = Auth.auth().currentUser?.uid
//            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
//                print(snapshot)
//                if let dictionary = snapshot.value as? [String : AnyObject] {
//
//                    self.navigationItem.title = dictionary["name"] as? String
//                    print("UID thing happened")
//                }
//            }, withCancel: nil)

            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (arg0) in
                
                let (snapshot) = arg0
                                if let dictionary = snapshot.value as? [String : AnyObject] {
                
                                    self.navigationItem.title = dictionary["name"] as? String
                                    print("UID thing happened")
                }
            }, withCancel: nil)
            
        }
    }
    
    
    
    @objc func handleLogout() {

        do  {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        
        let loginContoller = LoginController()  
        present(loginContoller, animated: true, completion: nil)

    }

}

