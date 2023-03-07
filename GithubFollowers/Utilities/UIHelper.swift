//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Sergio Gomes on 07/03/2023.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let itemSpacing: CGFloat = 2
        let itemsPerLine: CGFloat = 3
        let itemWidth = (UIScreen.main.bounds.size.width - (itemSpacing * CGFloat(itemsPerLine - 1))) / itemsPerLine
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.minimumLineSpacing = itemSpacing
        
        return flowLayout
    }
}
