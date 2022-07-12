//
//  ViewController.swift
//  PodcastsAppHomeScreen
//
//  Created by Simran Preet Narang on 2022-07-10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: APIResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Podcasts"
        fetchData()
        collectionView.collectionViewLayout = CompositionalLayout.createCollectionViewLayoutForHomeScreen()
    }
    
    // MARK: - Helper methods
    private func fetchData() {
        Task {
            do {
                dataSource = try await APIManager.getData()
                self.collectionView.reloadData()
            } catch {
                print("❌", error)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource extension
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as! CategoryCell
                if let categoryTitle = dataSource?.categories[indexPath.row] {
                    cell.configure(with: categoryTitle)
                }
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageTitleSubtitleCell.self)", for: indexPath) as! ImageTitleSubtitleCell
                if let episode = dataSource?.recentlyPlayedEpisodes[indexPath.row] {
                    cell.configure(withEpisode: episode)
                }
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageTitleSubtitleCell.self)", for: indexPath) as! ImageTitleSubtitleCell
                if let podcast = dataSource?.topPodcasts[indexPath.row] {
                    cell.configure(withPodcast: podcast)
                }
                return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        
        switch indexPath.section {
            case 0:
                sectionHeader.sectionHeaderlabel.text = "Categories"
            case 1:
                sectionHeader.sectionHeaderlabel.text = "Recently Played"
            default:
                sectionHeader.sectionHeaderlabel.text = "Top Podcasts"
        }
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
            case 0:
                return dataSource?.categories.count ?? 0
            case 1:
                return dataSource?.recentlyPlayedEpisodes.count ?? 0
            default:
                return dataSource?.topPodcasts.count ?? 0
        }
    }
}

