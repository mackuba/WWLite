//
//  VideoListView.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class VideoListView: NSView {
    var selectedId: String? {
        didSet {
            selectedIdDidChange.send(selectedId)
        }
    }

    let selectedIdDidChange = PassthroughSubject<String?, Never>()

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        let list = VideoList(
            dataStore: dataStore,
            selectedId: Binding<String?>(
                get: {
                    self.selectedId
                },
                set: {
                    self.selectedId = $0
                }
            )
        )

        let hostingView = NSHostingView(rootView: list)
        hostingView.frame = self.bounds
        hostingView.autoresizingMask = [.width, .height]
        addSubview(hostingView)
    }
}
