//
//  APIService.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 24.11.2022.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    static let shared = APIService()
    let baseUrl = "https://itunes.apple.com/search"
    
    
    struct ResponseModel: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
    
    func fetchPodcasts(with searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        let parameters = [
            "term": searchText,
            "media": "podcast"
        ]
        
        AF.request(baseUrl, method: .get, parameters: parameters).response { response in
            guard response.error == nil else { return }
            guard let data = response.data else { return }
            
            do {
                let response = try JSONDecoder().decode(ResponseModel.self, from: data)
                completionHandler(response.results)
            } catch {
//                print(error)
            }
        }
    }
    
    func fetchEpisodes(with feedUrl: URL, completionHandler: @escaping ([RSSFeedItem]) -> ()) {
        let parser = FeedParser(URL: feedUrl)
        
        parser.parseAsync { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let rss):
                guard let items = rss.rssFeed?.items else { return }
                completionHandler(items)
            }
        }
    }
}
