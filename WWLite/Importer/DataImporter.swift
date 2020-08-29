//
//  DataImporter.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import Foundation

class DataImporter {
    // TODO: figure out where this comes from
    private let feedURL = "https://devimages-cdn.apple.com/wwdc-services/n233a99f/5D23F1E9-9551-4768-ACF3-E3920F9C572D/contents.json"

    func importData() {
        let task = URLSession.shared.dataTask(with: URL(string: feedURL)!) { (data, response, error) in
            guard let data = data else {
                print("Error importing data: \(String(describing: error)), \(String(describing: response))")
                return
            }

            do {
                let feed = try JSONDecoder().decode(ContentsFeed.self, from: data)
                dataStore.importFromFeed(feed)
            } catch let error {
                print("Error parsing data: \(error)")
            }
        }

        task.resume()
    }
}
