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
                    let imageUrl = item.iTunes?.iTunesImage?.attributes?.href ?? ""
                    
                    let episode = Episode(
                        title: item.title ?? "",
                        pubDate: item.pubDate ?? Date(),
                        description: item.description ?? "",
                        imageUrl: imageUrl)
                    
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
