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
        // Do any additional setup after loading the view.
        fetchData()
        collectionView.collectionViewLayout = createCategoryLayout()
    }
    
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
    
    private func createCategoryLayout() -> UICollectionViewCompositionalLayout {
        // Categories
        let categoriesItem = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                            height: .fractionalHeight(0.5),
                                                            spacing: 5)
        
        let categoriesGroup = CompositionalLayout.createGroup(alignment: .vertical,
                                                              width: .fractionalWidth(0.8),
                                                              height: .fractionalHeight(0.25),
                                                              subitem: categoriesItem,
                                                              count: 3)
        
        let categoriesSection = NSCollectionLayoutSection(group: categoriesGroup)
        categoriesSection.orthogonalScrollingBehavior = .groupPaging
        
        
        
        // Recently Played Episode
        let recentlyPlayedEpisodeItem = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                                       height: .fractionalHeight(0.5),
                                                                       spacing: 5)
        
        let recentlyPlayedEpisodeGroup = CompositionalLayout.createGroup(alignment: .vertical,
                                                                         width: .fractionalWidth(0.9),
                                                                         height: .fractionalHeight(0.5),
                                                                         subitem: recentlyPlayedEpisodeItem,
                                                                         count: 3)
        
        let recentlyPlayedEpisodeSection = NSCollectionLayoutSection(group: recentlyPlayedEpisodeGroup)
        recentlyPlayedEpisodeSection.orthogonalScrollingBehavior = .continuous
        
        
        
        // Podcasts
        let podcastItem = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                         height: .absolute(125),
                                                         spacing: 5)
        
        let podcastGroup = CompositionalLayout.createGroup(alignment: .horizontal,
                                                           width: .fractionalWidth(1),
                                                           height: .absolute(125),
                                                           subitem: podcastItem,
                                                           count: 1)
        
        let podcastSection = NSCollectionLayoutSection(group: podcastGroup)
        
        
        
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        podcastSection.boundarySupplementaryItems = [header]
        categoriesSection.boundarySupplementaryItems = [header]
        recentlyPlayedEpisodeSection.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout { index, environment in
            
            if index == 0 {
                return categoriesSection
            }
            
            if index == 2 {
                return podcastSection
            }
            
            return recentlyPlayedEpisodeSection
        }
        
        return layout
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as! CategoryCell
            if let categoryTitle = dataSource?.categories[indexPath.row] {
                cell.configure(with: categoryTitle)
            }
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageTitleSubtitleCell.self)", for: indexPath) as! ImageTitleSubtitleCell
            if let episode = dataSource?.recentlyPlayedEpisodes[indexPath.row] {
                cell.configure(withEpisode: episode)
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageTitleSubtitleCell.self)", for: indexPath) as! ImageTitleSubtitleCell
        if let podcast = dataSource?.topPodcasts[indexPath.row] {
            cell.configure(withPodcast: podcast)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        
        if indexPath.section == 0 {
            sectionHeader.sectionHeaderlabel.text = "Categories"
        }
        
        if indexPath.section == 1 {
            sectionHeader.sectionHeaderlabel.text = "Recently Played"
        }
        
        if indexPath.section == 2 {
            sectionHeader.sectionHeaderlabel.text = "Top Podcasts"
        }
        
        return sectionHeader
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return dataSource?.categories.count ?? 0
        }
        
        if section == 1 {
            return dataSource?.recentlyPlayedEpisodes.count ?? 0
        }
        
        return dataSource?.topPodcasts.count ?? 0
        
    }
}

