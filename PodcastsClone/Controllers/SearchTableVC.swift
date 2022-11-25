//
//  SearchTableVC.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 24.11.2022.
//

import UIKit

class SearchTableVC: UITableViewController {

    // MARK: - Fields
    
    let cellId = "cellId"
    let searchController = UISearchController(searchResultsController: nil)
    var podcasts: [Podcast] = []
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureCell()
    }
}

// MARK: - TableView Cell

extension SearchTableVC {
    func configureCell() {
        tableView.register(UINib(nibName: "PodcastCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
}

// MARK: - TableViewDataSource

extension SearchTableVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastCell
        cell.podcast = podcasts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        132
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter a search term."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        podcasts.count > 0 ? 0 : 150
    }
}


// MARK: - TableView Delegate

extension SearchTableVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodesController = EpisodesTableVC()
        episodesController.podcast = podcasts[indexPath.row]
        
        navigationController?.pushViewController(episodesController, animated: true)
    }
}

// MARK: - SearchController

extension SearchTableVC: UISearchBarDelegate {
    func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchPodcasts(with: searchText) { podcasts in
            self.podcasts = podcasts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
