//
//  EpisodesTableVC.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 25.11.2022.
//

import UIKit

class EpisodesTableVC: UITableViewController {
    let cellId = "cellId"
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
            guard let feedUrl = podcast?.feedUrl else { return }
            let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
            guard let url = URL(string: secureFeedUrl) else { return }
            
            APIService.shared.fetchEpisodes(with: url) { items in
                items.forEach { item in
                    let imageUrl = item.iTunes?.iTunesImage?.attributes?.href ?? ""
                    let safeImageUrl = imageUrl.contains("https") ? imageUrl : imageUrl.replacingOccurrences(of: "http", with: "https")
                    
                    let episode = Episode(
                        title: item.title ?? "",
                        pubDate: item.pubDate ?? Date(),
                        description: item.description ?? "",
                        imageUrl: safeImageUrl)
                    
                    self.episodes.append(episode)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
}

// MARK: - Table view data source

extension EpisodesTableVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        cell.episode = episodes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        132
    }
}
