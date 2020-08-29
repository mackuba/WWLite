//
//  MainWindowController.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import Combine
import Cocoa

class MainWindowController: NSWindowController {

    var selectionObserver: AnyCancellable?

    override func windowDidLoad() {
        super.windowDidLoad()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let splitView = self.contentViewController as! NSSplitViewController
        let listVC = splitView.splitViewItems[0].viewController as! VideoListController
        let detailVC = splitView.splitViewItems[1].viewController as! VideoDetailViewController
        let list = listVC.videoList

        selectionObserver = list?.selectedIdDidChange.sink { id in
            if let selectedId = id, let video = dataStore.video(id: selectedId) {
                DispatchQueue.main.async {
                    detailVC.showVideo(video)
                }
            }
        }
    }
}
