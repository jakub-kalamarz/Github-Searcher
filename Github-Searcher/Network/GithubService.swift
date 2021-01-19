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

    func fetchCommits(for repository: String, count: Int) -> Observable<[Commit]> {
        let url = URL(string: "https://api.github.com/repos/\(repository)/commits?per_page=\(count)")!
        return session.rx
            .json(url: url)
            .flatMap { json throws -> Observable<[Commit]> in
                guard
                    let json = json as? [[String: Any]]
                else { return Observable.error(ServiceError.cannotParse) }
                let commits = json.compactMap(Commit.init)
                return Observable.just(commits)
            }

    }

    func fetchRepository(for repository: String) -> Observable<Repository> {
        let url = URL(string: "https://api.github.com/repos/\(repository)")!
        return session.rx
            .json(url: url)
            .flatMap { json throws -> Observable<Repository> in
                guard
                    let json = json as? [String: Any]
                else { return Observable.error(ServiceError.cannotParse) }
                let repository = Repository(from: json)
                return Observable.just(repository ?? Repository(name: "xd", id: 1, stars: 123, author: "xD", authorPhoto: "xd", repoQuery: "xd"))
                }
    }
}
