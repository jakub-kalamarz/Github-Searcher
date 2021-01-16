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
}

class RepositoryDetailCoordinator: BaseCoordinator<RepositoryDetailCoordinationResult> {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() -> Observable<RepositoryDetailCoordinationResult> {
        let view = RepositoryDetailView()
        let viewModel = RepositoryDetailViewModel()
        view.viewModel = viewModel

        navigationController.pushViewController(view, animated: true)

        return Observable.never()
    }
}
