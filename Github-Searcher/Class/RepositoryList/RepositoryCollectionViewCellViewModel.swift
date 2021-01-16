//
//  RepositoryCollectionViewCellViewModel.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 16/01/2021.
//

import Foundation
import RxSwift

class RepositoryCollectionViewCellViewModel {
    let photoURL: Observable<String>
    let name: Observable<String>
    let stars: Observable<Int>

    init(repository: Repository) {
        name = Observable.just(repository.name)
        stars = Observable.just(repository.stars)
        photoURL = Observable.just(repository.author.photo)
    }
}
