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
        configureCell()
        configureSearchController()
    }
}

// MARK: - TableView Cell

extension SearchTableVC {
    func configureCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// MARK: - TableViewDataSource

extension SearchTableVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(podcasts[indexPath.row].trackName ?? "")\n\(podcasts[indexPath.row].artistName ?? "")"
        cell.imageView?.image = UIImage(named: "appicon")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        132
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
