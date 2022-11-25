//
//  PodcastCell.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 25.11.2022.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView! {
        didSet {
            podcastImageView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCount: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel! {
        didSet {
            trackNameLabel.numberOfLines = 2
        }
    }
    
    var podcast: Podcast! {
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            episodeCount.text = "\(podcast.trackCount ?? 0) Episodes"
            podcastImageView.sd_setImage(with: URL(string: podcast.artworkUrl600 ?? ""))
        }
    }
}
