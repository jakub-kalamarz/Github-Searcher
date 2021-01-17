//
//  RepositoryDetailViewModel.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 14/01/2021.
//

import Foundation
import RxSwift

class RepositoryDetailViewModel {

    let commits = PublishSubject<[Commit]>()

    init(networkService: GithubService = GithubService()) {
        
    }

    func fetchCommits() {
        let commitsArray = Array(repeating: Commit(), count: 3)
        self.commits.on(.next(commitsArray))
    }
}
