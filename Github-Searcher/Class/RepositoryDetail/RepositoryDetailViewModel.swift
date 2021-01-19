//
//  RepositoryDetailViewModel.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 14/01/2021.
//

import Foundation
import RxSwift

class RepositoryDetailViewModel {
    let disposeBag = DisposeBag()

    let openWeb: AnyObserver<Void>
    let back: AnyObserver<Void>
    let share: AnyObserver<Void>

    let commits: Observable<[Commit]>
    let repository: Observable<Repository>
    let openWebsite: Observable<Void>
    let backAction: Observable<Void>
    var shareItem = [Any]()

    init(for query: String, networkService: GithubService = GithubService()) {

        self.commits = networkService.fetchCommits(for: query, count: 3)

        self.repository = networkService.fetchRepository(for: query)

        let _openWeb = PublishSubject<Void>()
        self.openWeb = _openWeb.asObserver()
        self.openWebsite = _openWeb.asObservable()

        let _back = PublishSubject<Void>()
        self.back = _back.asObserver()
        self.backAction = _back.asObservable()

        let _share = PublishSubject<Void>()
        self.share = _share.asObserver()

        repository.subscribe(onNext: { repository in
            self.shareItem.append(repository.name)
            self.shareItem.append(URL(string: "https://github.com/\(repository.repoQuery)")!)
        })
        .disposed(by: disposeBag)
    }

    func shareButton(_ vc: UIViewController) {
        let ac = UIActivityViewController(activityItems: self.shareItem, applicationActivities: nil)
        vc.present(ac, animated: true)
    }
}
