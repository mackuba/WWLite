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

        for (i, key) in store.videoMap.keys.enumerated() {
            store.videoMap[key]!.isDownloaded = (i % 2 == 1)
        }

        return store
    }

    var videos: [SessionVideo] {
        return videoMap.values.sorted(by: { ($0.eventId, $0.id) < ($1.eventId, $1.id) })
    }

    func video(id: String) -> SessionVideo? {
        return videoMap[id]
    }

    func downloadVideo(id: String) {
        guard var video = videoMap[id],
              !video.isDownloaded && !video.isDownloading,
              let downloadURL = video.videoDownloadLinkHD,
              let targetLocation = video.downloadPath else {
            return
        }

        self.objectWillChange.send()
        video.isDownloading = true
        videoMap[id] = video

        print("Downloading video from \(downloadURL)")

        let task = URLSession.shared.downloadTask(with: downloadURL) { (url, response, error) in
            guard let url = url else {
                print("Error downloading file: \(String(describing: error)) \(String(describing: response))")
                return
            }

            do {
                let directory = targetLocation.deletingLastPathComponent()

                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
                try FileManager.default.moveItem(at: url, to: targetLocation)
                print("Saved video to \(targetLocation)")

                DispatchQueue.main.async {
                    video.isDownloading = false
                    video.isDownloaded = true

                    self.objectWillChange.send()
                    self.videoMap[id] = video
                }
            } catch let error {
                print("Error saving file: \(error)")
            }
        }

        task.resume()
    }

    func importFromFeed(_ feed: ContentsFeed) {
        for item in feed.contents where item.type == .video || item.type == .session {
            let video = SessionVideo(feedItem: item)
            videoMap[video.id] = video
        }

        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
}
