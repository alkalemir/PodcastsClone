//
//  RSSFeed.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 25.11.2022.
//

import FeedKit

extension RSSFeed {
    func toEpisodes() -> [Episode] {
        var episodes = [Episode]()
        
        self.items?.forEach({ item in
            let imageUrl = item.iTunes?.iTunesImage?.attributes?.href ?? ""
            
            
            let episode = Episode(
                title: item.title ?? "",
                pubDate: item.pubDate ?? Date(),
                description: item.iTunes?.iTunesSubtitle ?? "",
                imageUrl: imageUrl,
                author: item.iTunes?.iTunesAuthor ?? "",
                mp3url: item.enclosure?.attributes?.url ?? "")
            
            episodes.append(episode)
        })
        
        return episodes
    }
}
