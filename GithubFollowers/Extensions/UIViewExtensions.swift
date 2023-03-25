//
//  UIViewExtensions.swift
//  GithubFollowers
//
//  Created by Sergio Gomes on 25/03/2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
