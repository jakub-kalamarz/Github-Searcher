//
//  RepositoryDetailCoordinator.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 14/01/2021.
//

import Foundation
import RxSwift
import UIKit

enum RepositoryDetailCoordinationResult {
    case back
    case open(String)
}

class RepositoryDetailCoordinator: BaseCoordinator<RepositoryDetailCoordinationResult> {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // TODO: Start && Open Web method
}
