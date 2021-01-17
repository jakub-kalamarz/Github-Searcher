//
//  RepositoryCommitViewModel.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 17/01/2021.
//

import Foundation
import RxSwift

class RepositoryCommitViewModel {
    let author: Observable<String>
    let email: Observable<String>
    let position: Observable<Int>
    let message: Observable<String>

    init(from commit:Commit, position: Int) {
        self.position = Observable.just(position + 1)
        self.author = Observable.just(commit.author)
        self.email = Observable.just(commit.authorAddress)
        self.message = Observable.just(commit.commitMessage)
    }
}
