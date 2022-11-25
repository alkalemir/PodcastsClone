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
            guard let url = URL(httpToHttps: feedUrl) else { return }
            
            APIService.shared.fetchEpisodes(with: url) { items in
                items.forEach { item in
                    var episode = item
                    episode.imageUrl = item.imageUrl == "" ? (self.podcast?.artworkUrl600 ?? "") : item.imageUrl
//                    let episode = Episode(
//                        title: item.title,
//                        pubDate: item.pubDate,
//                        description: item.description,
//                        imageUrl: item.imageUrl == "" ? (self.podcast?.artworkUrl600 ?? "") : item.imageUrl,
//                        author: item.author)
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

// MARK: - TableView Delegate

extension EpisodesTableVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        let window = UIApplication.shared.keyWindow
        let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailsView", owner: self)?.first as! PlayerDetailsView
        playerDetailsView.frame = view.frame
        playerDetailsView.episode = episode
        
        window?.addSubview(playerDetailsView)
        
    }
}
