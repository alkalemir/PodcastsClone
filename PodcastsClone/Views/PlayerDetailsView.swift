//
//  PlayerDetailsView.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 25.11.2022.
//

import UIKit

class PlayerDetailsView: UIView {
    var episode: Episode! {
        didSet {
            episodeTitle.text = episode.title
            authorLabel.text = episode.author
            episodeImageView.sd_setImage(with: URL(string: episode.imageUrl))
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel! {
        didSet {
            episodeTitle.numberOfLines = 2
        }
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        removeFromSuperview()
    }
}
