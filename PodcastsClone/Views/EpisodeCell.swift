//
//  EpisodeCell.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 25.11.2022.
//

import UIKit
import SDWebImage

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 3
        }
    }
    @IBOutlet weak var episodeTitleLabel: UILabel! {
        didSet {
            episodeTitleLabel.numberOfLines = 2
        }
    }
    
    var episode: Episode! {
        didSet {
            descriptionLabel.text = episode.description
            episodeTitleLabel.text = episode.title
            episodeImageView.sd_setImage(with: URL(string: episode.imageUrl))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, YYYY"
            pubDateLabel.text = dateFormatter.string(from: episode.pubDate)
        }
    }
}
