//
//  Podcast.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 24.11.2022.
//

import Foundation

struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
}
