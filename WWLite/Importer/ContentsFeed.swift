//
//  ContentsFeed.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import Foundation

struct ContentsFeed: Codable {
    let events: [Event]
    let contents: [Item]

    struct Event: Codable {
        let id: String
        let name: String
    }

    struct Item: Codable {
        let id: String
        let eventId: String
        let webPermalink: String
        let title: String
        let description: String
        let type: ItemType
        let media: ItemMedia?
    }

    enum ItemType: String, CaseIterable, Codable {
        case video = "Video"
        case session = "Session"
        case other = "Other"

        init?(rawValue: String) {
            switch rawValue {
                case Self.video.rawValue: self = .video
                case Self.session.rawValue: self = .session
                default: self = .other
            }
        }
    }

    struct ItemMedia: Codable {
        let downloadSD: URL?
        let downloadHD: URL?
        let duration: Int
    }
}
