//
//  ViewController.swift
//  Messenger
//
//  Created by Thaddeus Dronski on 8/27/23.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    
    
    private let conversationTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(conversationTableView)
        
       
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
      
    }
    
    override func viewDidLayoutSubviews() {
        conversationTableView.frame = view.frame
    }
    
    
    private func validateAuth() {
        if  FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

