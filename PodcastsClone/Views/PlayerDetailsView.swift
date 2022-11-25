//
//  PlayerDetailsView.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 25.11.2022.
//

import UIKit
import AVKit

class PlayerDetailsView: UIView {
    
    var player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()

    var episode: Episode! {
        didSet {
            episodeTitle.text = episode.title
            authorLabel.text = episode.author
            episodeImageView.sd_setImage(with: URL(string: episode.imageUrl))
            episodeImageView.transform = shrunkenTransform
            playEpisode()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    fileprivate let shrunkenTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let time = CMTimeMake(value: 1, timescale: 1)
        let nsValue = NSValue(time: time)
        player.addBoundaryTimeObserver(forTimes: [nsValue], queue: .main) {
            self.enlargeImageView()
        }
    }
    
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet {
            playPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
            playPauseButton.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    @objc func handlePlayPause() {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            enlargeImageView()
        } else if player.timeControlStatus == .playing {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            collapseImageView()
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView! {
        didSet {
            episodeImageView.layer.cornerRadius = 5
            episodeImageView.transform = shrunkenTransform
        }
    }
    
    @IBOutlet weak var episodeTitle: UILabel! {
        didSet {
            episodeTitle.numberOfLines = 2
        }
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        removeFromSuperview()
    }
    
    fileprivate func enlargeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut) {
            self.episodeImageView.transform = .identity
        }
    }
    
    fileprivate func collapseImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseIn) {
            self.episodeImageView.transform = self.shrunkenTransform
        }
    }
    
    
    fileprivate func playEpisode() {
        guard let url = URL(httpToHttps: episode.mp3url) else { return }
        print(url)
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        player.play()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
