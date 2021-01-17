//
//  Commit.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 14/01/2021.
//

import Foundation

struct Commit {
    let author:String
    let authorAddress:String
    let commitMessage: String

    init?(from data: [String: Any]) {
        guard
            let commit = data["commit"] as? [String: Any]
        else { return nil }

        let author = commit["author"] as! [String: Any]
        let name = author["name"] as! String
        let email = author["email"] as! String
        let message = commit["message"] as! String

        self.init(author: name, authorAddress: email, commitMessage: message)

    }

    init(author: String, authorAddress: String, commitMessage: String) {
        self.author = author
        self.authorAddress = authorAddress
        self.commitMessage = commitMessage
    }
}
