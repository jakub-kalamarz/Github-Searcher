//
//  Author.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 14/01/2021.
//

import Foundation

struct Author: Hashable {
    let name: String
    let photo: String

    init(name: String, photo: String) {
        self.name = name
        self.photo = photo
    }
}
