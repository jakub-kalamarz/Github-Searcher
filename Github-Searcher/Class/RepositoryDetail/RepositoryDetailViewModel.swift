//
//  RepositoryDetailViewModel.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 14/01/2021.
//

import Foundation
import RxSwift

class RepositoryDetailViewModel {

    let commits: Observable<[Commit]>

    init(networkService: GithubService = GithubService()) {

        self.commits = networkService.fetchCommits(for: "KlubJagiellonski/pola-ios", count: 3)

        self.commits.subscribe(onNext: { item in
            print(item)
        })
        .disposed(by: DisposeBag())
    }
}
