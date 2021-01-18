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

    init(for query: String, networkService: GithubService = GithubService()) {

        self.commits = networkService.fetchCommits(for: query, count: 3)
    }
}
