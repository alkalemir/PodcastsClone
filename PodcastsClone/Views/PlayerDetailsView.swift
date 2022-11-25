//
//  PlayerDetailsView.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 25.11.2022.
//

import UIKit
import AVKit

class PlayerDetailsView: UIView {
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    var episode: Episode! {
        didSet {
            episodeTitle.text = episode.title
            authorLabel.text = episode.author
            episodeImageView.sd_setImage(with: URL(string: episode.imageUrl))
            playEpisode()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet {
            playPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        }
    }
    
    @objc func handlePlayPause() {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        } else if player.timeControlStatus == .playing {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
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
    
    fileprivate func playEpisode() {
        guard let url = URL(httpToHttps: episode.mp3url) else { return }
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        player.play()
    }
}
