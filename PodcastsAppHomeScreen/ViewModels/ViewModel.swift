//
//  ViewModels.swift
//  PodcastsAppHomeScreen
//
//  Created by Simran Preet Narang on 2022-07-12.
//

import Foundation

final class ViewModel {
    
    @Published var dataSource: APIResponse = APIResponse()
    
    func fetchData() {
        Task {
            do {
                dataSource = try await APIManager.getData()
            } catch {
                print("❌", error)
            }
        }
    }
}
