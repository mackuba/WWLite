//
//  SessionVideo.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import Foundation

let baseDownloadPath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
    .appendingPathComponent("WWDC")

struct SessionVideo: Identifiable {
    let id: String
    let eventId: String
    let webPermalink: String
    let title: String
    let description: String
    let videoDownloadLinkSD: URL?
    let videoDownloadLinkHD: URL?
    let videoDuration: Int?

    var isDownloaded = false
    var isDownloading = false

    var downloadPath: URL? {
        guard let fileName = videoDownloadLinkHD?.lastPathComponent else { return nil }
        guard eventId.hasPrefix("wwdc") else { return nil }

        let year = eventId.replacingOccurrences(of: "wwdc", with: "")
        guard !year.isEmpty else { return nil }

        return baseDownloadPath.appendingPathComponent(year).appendingPathComponent(fileName)
    }

    init(feedItem item: ContentsFeed.Item) {
        self.id = item.id
        self.eventId = item.eventId
        self.webPermalink = item.webPermalink
        self.title = item.title
        self.description = item.description

        self.videoDownloadLinkSD = item.media?.downloadHD
        self.videoDownloadLinkHD = item.media?.downloadHD
        self.videoDuration = item.media?.duration

        if let downloadPath = downloadPath {
            self.isDownloaded = FileManager.default.fileExists(atPath: downloadPath.path)
        }
    }
}
