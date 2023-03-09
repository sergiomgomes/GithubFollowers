//
//  ReposItemViewController.swift
//  GithubFollowers
//
//  Created by Sergio Gomes on 09/03/2023.
//

import UIKit

class FollowerItemViewController: ItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
}
