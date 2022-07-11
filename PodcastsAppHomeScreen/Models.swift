//
//  Models.swift
//  PodcastsAppHomeScreen
//
//  Created by Simran Preet Narang on 2022-07-10.
//

import Foundation

// MARK: - Welcome
struct APIResponse: Codable {
    let recentlyPlayedEpisodes: [RecentlyPlayedEpisode]
    let categories: [String]
    let topPodcasts, recentlyVisitedPodcasts: [Podcast]
}


struct RecentlyPlayedEpisode: Codable {
    
    let title, pubDate: String
    let link: String
    let guid: String
    let author: String
    let thumbnail: String
    let recentlyPlayedEpisodeDescription, content: String
    
    enum CodingKeys: String, CodingKey {
        case title, pubDate, link, guid, author, thumbnail
        case recentlyPlayedEpisodeDescription = "description"
        case content
    }
}


struct Podcast: Codable {
    
    let collectionID, trackID: Int
    let artistName, collectionName, trackName, collectionCensoredName: String
    let trackCensoredName: String
    let collectionViewURL: String
    let feedURL: String
    let trackViewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice, trackRentalPrice, collectionHDPrice: Int
    let trackHDPrice, trackHDRentalPrice: Int
    let trackCount: Int
    let primaryGenreName: String
    let artworkUrl600: String
    let genreIDS, genres: [String]
    let artistID: Int?
    let artistViewURL: String?
    
    enum CodingKeys: String, CodingKey {
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case collectionViewURL = "collectionViewUrl"
        case feedURL = "feedUrl"
        case trackViewURL = "trackViewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case trackCount, primaryGenreName, artworkUrl600
        case genreIDS = "genreIds"
        case genres
        case artistID = "artistId"
        case artistViewURL = "artistViewUrl"
    }
}
