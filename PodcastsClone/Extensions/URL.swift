//
//  URL.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 25.11.2022.
//

import Foundation

extension URL {
    init?(httpToHttps url: String) {
        let secureUrl = url.contains("https") ? url : url.replacingOccurrences(of: "http", with: "https")
        self.init(string: secureUrl)
    }
}
