//
//  SessionVideo.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import Foundation

struct SessionVideo: Identifiable {
    let id: String
    let eventId: String
    let webPermalink: String
    let title: String
    let description: String
    let videoDownloadLinkSD: URL?
    let videoDownloadLinkHD: URL?
    let videoDuration: Int?

    init(feedItem item: ContentsFeed.Item) {
        self.id = item.id
        self.eventId = item.eventId
        self.webPermalink = item.webPermalink
        self.title = item.title
        self.description = item.description

        self.videoDownloadLinkSD = item.media?.downloadHD
        self.videoDownloadLinkHD = item.media?.downloadHD
        self.videoDuration = item.media?.duration
    }
}
