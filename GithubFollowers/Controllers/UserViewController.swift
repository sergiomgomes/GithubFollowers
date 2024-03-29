//
//  UserViewController.swift
//  GithubFollowers
//
//  Created by Sergio Gomes on 07/03/2023.
//

import UIKit

protocol UserViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserViewController: UIViewController {
    
    let headerView = UIView()
    let githubProfileView = UIView()
    let followersDetailsView = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var username: String!
    weak var delegate: UserViewControllerDelegate!
    
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
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        let reposItemViewController = ReposItemViewController(user: user)
        reposItemViewController.delegate = self
        
        let followerItemViewController = FollowerItemViewController(user: user)
        followerItemViewController.delegate = self
        
        self.add(childViewController: UserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childViewController: reposItemViewController, to: self.githubProfileView)
        self.add(childViewController: followerItemViewController, to: self.followersDetailsView)
        self.dateLabel.text = "GitHub since \(user.createdAt)"
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func layoutUI() {
        let itemViews = [headerView, githubProfileView, followersDetailsView, dateLabel]
        itemViews.forEach { itemView in
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            githubProfileView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            githubProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            githubProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            githubProfileView.heightAnchor.constraint(equalToConstant: 140),
            
            followersDetailsView.topAnchor.constraint(equalTo: githubProfileView.bottomAnchor, constant: padding),
            followersDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            followersDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            followersDetailsView.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: followersDetailsView.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childViewController: UIViewController, to containerView: UIView){
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}


extension UserViewController: ItemInfoViewControllerDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: "Invalid URL", message: "The URL attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        presentSafariViewController(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentAlertOnMainThread(title: "No followers", message: "This user has no followers!", buttonTitle: "Ok")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissViewController()
    }
}
