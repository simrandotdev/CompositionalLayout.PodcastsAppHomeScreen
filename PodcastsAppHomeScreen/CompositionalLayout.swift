//
//  CompositionalLayout.swift
//  PodcastsAppHomeScreen
//
//  Created by Simran Preet Narang on 2022-07-11.
//

import Foundation
import UIKit

enum GroupAlignment {
    case horizontal
    case vertical
}


struct CompositionalLayout {
    
    static func createItem(width: NSCollectionLayoutDimension,
                           height: NSCollectionLayoutDimension,
                           spacing: CGFloat) -> NSCollectionLayoutItem {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: width,
                                                            heightDimension: height))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return item
    }
    
    
    
    static func createGroup(alignment: GroupAlignment,
                            width: NSCollectionLayoutDimension,
                            height: NSCollectionLayoutDimension,
                            subitems: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
        switch alignment {
            case .horizontal:
                return NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: width, heightDimension: height),
                    subitems: subitems)
            case .vertical:
                return NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: width, heightDimension: height),
                    subitems: subitems)
        }
    }
    
    
    static func createGroup(alignment: GroupAlignment,
                            width: NSCollectionLayoutDimension,
                            height: NSCollectionLayoutDimension,
                            subitem: NSCollectionLayoutItem,
                            count: Int) -> NSCollectionLayoutGroup {
        switch alignment {
            case .horizontal:
                return NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: width, heightDimension: height),
                    subitem: subitem,
                    count: count)
            case .vertical:
                return NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: width, heightDimension: height),
                    subitem: subitem,
                    count: count)
        }
    }
    
    
    static func createStaggeredLayout() -> UICollectionViewCompositionalLayout {
        // 2 images one below other
        let itemForVerticalGroup = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                                  height: .fractionalHeight(1),
                                                                  spacing: 2)
        let verticalGroup = CompositionalLayout.createGroup(alignment: .vertical,
                                                            width: .fractionalWidth(0.5),
                                                            height: .fractionalHeight(1.0),
                                                            subitem: itemForVerticalGroup,
                                                            count: 2)
        
        // 1 image taking height of 2 images above
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.5),
                                                  height: .fractionalHeight(1),
                                                  spacing: 2)
        let horizontalGroup = CompositionalLayout.createGroup(alignment: .horizontal,
                                                              width: .fractionalWidth(1),
                                                              height: .absolute(400),
                                                              subitems: [verticalGroup, item])
        
        
        let mainItem = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                      height: .absolute(100),
                                                      spacing: 1)
        let mainGroup = CompositionalLayout.createGroup(alignment: .vertical,
                                                        width: .fractionalWidth(1),
                                                        height: .absolute(500),
                                                        subitems: [mainItem, horizontalGroup])
        
        // section
        let section = NSCollectionLayoutSection(group: mainGroup)
        
        // return
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    static func createGridLayout(numberOfColumns: Int = 2, withSpacing spacing: CGFloat = 2) -> UICollectionViewCompositionalLayout {
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                  height: .fractionalHeight(1),
                                                  spacing: spacing)
        let group = CompositionalLayout.createGroup(alignment: .horizontal,
                                                    width: .fractionalWidth(1),
                                                    height: .fractionalWidth(CGFloat(1) / CGFloat(numberOfColumns)),
                                                    subitem: item, count: numberOfColumns)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    
    static func createListLayout(withSpacing spacing: CGFloat = 2) -> UICollectionViewCompositionalLayout {
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                  height: .fractionalHeight(1),
                                                  spacing: spacing)
        let group = CompositionalLayout.createGroup(alignment: .vertical,
                                                    width: .fractionalWidth(1),
                                                    height: .absolute(100),
                                                    subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
}
