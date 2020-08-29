//
//  VideoDetailViewController.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import AVKit
import Cocoa

class VideoDetailViewController: NSViewController {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var playerView: AVPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.isHidden = true
    }

    func showVideo(_ video: SessionVideo) {
        titleLabel.stringValue = video.title
        descriptionLabel.stringValue = video.description

        if video.isDownloaded, let downloadPath = video.downloadPath {
            playerView.alphaValue = 1.0
            playerView.player = AVPlayer(url: downloadPath)
        } else {
            playerView.alphaValue = 0.5
            playerView.player = nil
        }
        self.view.isHidden = false
    }
}
