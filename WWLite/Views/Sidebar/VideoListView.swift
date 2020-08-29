//
//  VideoListView.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import Foundation
import SwiftUI

class VideoListView: NSView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        let list = NSHostingView(rootView: VideoList(dataStore: dataStore))
        list.frame = self.bounds
        list.autoresizingMask = [.width, .height]
        addSubview(list)
    }
}
