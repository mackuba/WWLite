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
    @Binding var selectedId: String?

    var body: some View {
        List(selection: $selectedId) {
            ForEach(dataStore.videos) { video in
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(video.title)
                            Text(video.id).font(.caption)
                        }

                        Spacer()

                        if video.isDownloaded {
                            Text("⬇")
                        }
                    }

                    Divider()
                }
                .tag(video.id)
            }
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList(dataStore: DataStore.previewStore, selectedId: .constant(nil))
    }
}
