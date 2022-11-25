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
        }
    }
    
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// MARK: - Table view data source

extension EpisodesTableVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "\(episodes[indexPath.row])"
        return cell
    }
}
