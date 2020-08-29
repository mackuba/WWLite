//
//  VideoDetailViewController.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import Cocoa

class VideoDetailViewController: NSViewController {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.isHidden = true
    }

    func showVideo(_ video: SessionVideo) {
        titleLabel.stringValue = video.title
        descriptionLabel.stringValue = video.description

        self.view.isHidden = false
    }
}
