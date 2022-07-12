//
//  APIManager.swift
//  PodcastsAppHomeScreen
//
//  Created by Simran Preet Narang on 2022-07-10.
//

import Foundation

struct APIManager {
    
    static func getData() async throws -> APIResponse {
        let urlString = "https://gist.githubusercontent.com/simransdsu/a3ad028201220ee271118afb0d77cbd4/raw/3f508f6b49fd0388c35d1931bd0104af1e6dac72/CompositionalLayout.json"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(APIResponse.self, from: data)
        return response
    }
}
