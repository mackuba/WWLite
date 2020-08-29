//
//  VideoList.swift
//  WWLite
//
//  Created by Kuba Suder on 29.08.2020.
//  Copyright © 2020 Kuba Suder. All rights reserved.
//

import SwiftUI

struct VideoList: View {
    @ObservedObject var dataStore: DataStore

    var body: some View {
        List {
            ForEach(dataStore.videos) { video in
                VStack(alignment: .leading, spacing: 3) {
                    Text(video.title)
                    Text(video.id).font(.caption)
                    Divider().padding(.top, 5)
                }
            }
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList(dataStore: DataStore.previewStore)
    }
}
