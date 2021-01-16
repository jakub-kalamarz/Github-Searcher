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
    let author: Author

    init?(from data: [String: Any]) {
        guard
            let name = data["full_name"] as? String,
            let id = data["id"] as? Int,
            let stars = data["stargazers_count"] as? Int,
            let author = data["owner"] as? [String: Any],
            let authorName = author["login"] as? String,
            let authorPhoto = author["avatar_url"] as? String
        else { return nil }

        self.init(name: name, id: id, stars: stars, author: authorName, authorPhoto: authorPhoto)
    }

    init(name: String, id: Int, stars: Int, author: String, authorPhoto: String) {
        self.id = id
        self.name = name
        self.stars = stars
        self.author = Author(name: author, photo: authorPhoto)
    }

    static func == (lhs: Repository, rhs: Repository) -> Bool { lhs.id == rhs.id }
}
