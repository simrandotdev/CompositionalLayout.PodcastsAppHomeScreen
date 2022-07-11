//
//  ImageTitleSubtitleCell.swift
//  PodcastsAppHomeScreen
//
//  Created by Simran Preet Narang on 2022-07-11.
//

import UIKit
import SDWebImage

class ImageTitleSubtitleCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(withPodcast podcast: Podcast) {
        layer.cornerRadius = 10
        backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 10
        
        
        titleLabel.text = podcast.trackName
        subtitleLabel.text = podcast.artistName
        imageView.sd_setImage(with: URL(string: podcast.artworkUrl600))
    }
    
    func configure(withEpisode episode: RecentlyPlayedEpisode) {
        layer.cornerRadius = 10
        backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 10
        
        
        titleLabel.text = episode.title
        subtitleLabel.text = episode.title
        imageView.sd_setImage(with: URL(string: episode.thumbnail))
    }
}
