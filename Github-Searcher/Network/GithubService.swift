//
//  GithubService.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 16/01/2021.
//

import Foundation
import RxCocoa
import RxSwift

enum ServiceError: Error {
    case cannotParse
}

class GithubService {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func searchByQuery(by query: String) -> Observable<[Repository]> {
        var queries = query.isEmpty ? "?q=language:swift&sort=stars&order=desc" : "?q=" + query
        queries = queries.trimmingCharacters(in: .whitespacesAndNewlines)
        let url = URL(string: "https://api.github.com/search/repositories\(queries)")!
        return session.rx
            .json(url: url)
            .flatMap { json throws -> Observable<[Repository]> in
                guard
                    let json = json as? [String: Any],
                    let itemsJSON = json["items"] as? [[String: Any]]
                else { return Observable.error(ServiceError.cannotParse) }

                let repositories = itemsJSON.compactMap(Repository.init)
                return Observable.just(repositories)
            }
    }
}
