//
//  Bazel4_1BUILD.swift
//  Example
//
//  Created by Yume on 2023/3/9.
//

import Foundation
import CodeView
import SwiftUI

let bazelBuild: [any View] = [
    VStack(spacing: 40) {
        Text("BUILD").title
        VStack(alignment: .leading, spacing: 40) {
            Text("名稱: BUILD.bazel/BUILD").content
            Text("含有 `BUILD` 的資料夾，則視為 package。").content
            Text("並涵蓋其所有子資料夾").content
        }
    },
    VStack(spacing: 40) {
        Text("BUILD").title
        CodeView(.cBuild)
    },
    VStack(spacing: 40) {
        Text("Package").title
        VStack(alignment: .leading, spacing: 0) {
            Text("buck -> BUCK").content
            Text("bazel -> BUILD").content
        }
        Image("buck")
            .resizable()
            .frame(width: 600, height: 600)
        Text("原圖 https://speakerdeck.com/qcl/using-buck-to-save-ios-project-build-time?slide=22")
    },
]
