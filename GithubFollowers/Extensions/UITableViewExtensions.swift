//
//  UITableViewExtensions.swift
//  GithubFollowers
//
//  Created by Sergio Gomes on 4/15/23.
//

import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
