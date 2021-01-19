//
//  RepositoryDetailCoordinator.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 14/01/2021.
//

import Foundation
import RxSwift
import UIKit
import SafariServices

enum RepositoryDetailCoordinationResult {
    case back
    case web
}

class RepositoryDetailCoordinator: BaseCoordinator<RepositoryDetailCoordinationResult> {
    private let disposeBag = DisposeBag()
    private let navigationController: UINavigationController
    private let query: String

    init(navigationController: UINavigationController, query: String) {
        self.navigationController = navigationController
        self.query = query
    }

    override func start() -> Observable<RepositoryDetailCoordinationResult> {
        let view = RepositoryDetailView()
        let viewModel = RepositoryDetailViewModel(for: self.query)
        view.viewModel = viewModel

        navigationController.pushViewController(view, animated: true)

        viewModel.openWebsite.subscribe(onNext: {
            self.openWeb()
        })
        .disposed(by: disposeBag)

        let back = viewModel.backAction.map { _ in
            RepositoryDetailCoordinationResult.back
        }

        return Observable.single(back)()
    }

    private func openWeb() {
        let url = URL(string: "https://github.com/\(self.query)")
        let vc = SFSafariViewController(url: url!)
        self.navigationController.present(vc, animated: true, completion: nil)
    }
}
