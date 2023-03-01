//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Sergio Gomes on 01/03/2023.
//

import UIKit

class FollowersViewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
