//
//  RepositoryCollectionViewCell.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 15/01/2021.
//

import Foundation
import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {
    var data: Repository? {
        didSet {
            contentView.backgroundColor = .red
        }
    }
}
