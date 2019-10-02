//
//  ColumnFlowLayout.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-08-29.
//  Copyright © 2019 Isaacballas. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    private let minColumnWidth: CGFloat = 300.0
    private let cellHeight: CGFloat = 100.0
    
    // MARK: Layout Overrides
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea
    }
}
