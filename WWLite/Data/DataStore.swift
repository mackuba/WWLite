//
//  DataStore.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import Combine
import Foundation

let dataStore = DataStore()

class DataStore: ObservableObject {
    private var videoMap: [String:SessionVideo] = [:]

    fileprivate init() {}

    static var previewStore: DataStore {
        let store = DataStore()
        
        let feed = try! JSONDecoder().decode(ContentsFeed.self, from: previewFeedJSON.data(using: .utf8)!)
        store.importFromFeed(feed)

        return store
    }

    var videos: [SessionVideo] {
        return videoMap.values.sorted(by: { ($0.eventId, $0.id) < ($1.eventId, $1.id) })
    }

    func importFromFeed(_ feed: ContentsFeed) {
        objectWillChange.send()

        for item in feed.contents where item.type == .video || item.type == .session {
            let video = SessionVideo(feedItem: item)
            videoMap[video.id] = video
        }
    }
}
