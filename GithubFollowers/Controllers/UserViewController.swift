//
//  UserViewController.swift
//  GithubFollowers
//
//  Created by Sergio Gomes on 07/03/2023.
//

import UIKit

class UserViewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        
        getUser()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    func getUser(){
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
