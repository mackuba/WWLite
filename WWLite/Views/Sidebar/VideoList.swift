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
    @State var searchQuery: String = ""

    func matchesQuery(_ video: SessionVideo) -> Bool {
        if searchQuery.isEmpty {
            return true
        } else {
            let words = searchQuery.lowercased().components(separatedBy: .whitespaces)
            let title = video.title.lowercased()
            return words.allSatisfy { title.contains($0) }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            TextField("Search", text: $searchQuery)
            .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(5)

            List(selection: $selectedId) {
                ForEach(dataStore.videos) { video in
                    if self.matchesQuery(video) {
                        VideoRow(video: video)
                            .tag(video.id)
                            .contextMenu(ContextMenu() {
                                Button("Download") {
                                    self.dataStore.downloadVideo(id: video.id)
                                }
                                .disabled(video.isDownloaded)
                            })
                    }
                }
            }
        }
    }
}

struct VideoRow: View {
    var video: SessionVideo

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text(video.title)
                    Text(video.id).font(.caption)
                }

                Spacer()

                if video.isDownloaded {
                    Text("⬇")
                } else if video.isDownloading {
                    Text("…")
                }
            }

            Divider()
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList(dataStore: DataStore.previewStore, selectedId: .constant(nil))
    }
}
