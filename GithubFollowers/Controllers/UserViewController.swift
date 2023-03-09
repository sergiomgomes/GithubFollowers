//
//  UserViewController.swift
//  GithubFollowers
//
//  Created by Sergio Gomes on 07/03/2023.
//

import UIKit

class UserViewController: UIViewController {
    
    let headerView = UIView()
    let githubProfileView = UIView()
    let followersDetailsView = UIView()
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
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
                DispatchQueue.main.async {
                    self.add(childViewController: UserInfoHeaderViewController(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func layoutUI() {
        let itemViews = [headerView, githubProfileView, followersDetailsView]
        itemViews.forEach { itemView in
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            githubProfileView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            githubProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            githubProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            githubProfileView.heightAnchor.constraint(equalToConstant: 140),
            
            followersDetailsView.topAnchor.constraint(equalTo: githubProfileView.bottomAnchor, constant: padding),
            followersDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            followersDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            followersDetailsView.heightAnchor.constraint(equalToConstant: 140),
        ])
    }
    
    func add(childViewController: UIViewController, to containerView: UIView){
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}
