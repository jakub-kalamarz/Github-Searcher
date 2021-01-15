//
//  Repository.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 14/01/2021.
//

import Foundation

struct Repository: Hashable {
    let id: Int
    let name: String
    let stars: Int

    init?(from data: [String: Any]) {
        guard
            let name = data["full_name"] as? String,
            let id = data["id"] as? Int,
            let stars = data["stargazers_count"] as? Int
        // let author = data["owner"] as? [String: Any]
        else { return nil }

        self.init(name: name, id: id, stars: stars)
    }

    init(name: String, id: Int, stars: Int) {
        self.id = id
        self.name = name
        self.stars = stars
        // self.author = Author.init()
    }

    static func == (lhs: Repository, _: Repository) -> Bool { lhs.id == lhs.id }
}
