//
//  CategoryCell.swift
//  PodcastsAppHomeScreen
//
//  Created by Simran Preet Narang on 2022-07-11.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with title: String) {
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        
        titleLabel.text = title
    }
}
