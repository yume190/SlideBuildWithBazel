//
//  Bazel4_1WS.swift
//  Example
//
//  Created by Yume on 2023/3/9.
//

import Foundation
import SwiftUI
import CodeView

let bazelWS: [any View] = [
    VStack(spacing: 40) {
        Text("WORKSPACE").title
        VStack(alignment: .leading, spacing: 40) {
            Text("名稱: WORKSPACE.bazel/WORKSPACE").content
            Text("含有 WORKSPACE 的資料夾，將視為 bazel project。").content
            Text("(宣告外部 deps，初始化)").content
        }
    },
    VStack {
        Text("WORKSPACE").title
        CodeView(.init(.python, """
        # import external repo
        
        load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
        load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
        
        http_archive(
            name = "cgrindel_swift_bazel",
            sha256 = "2bcbe2947649f6433bf97258401c387eb41153c8adc378f84295628d879092d2",
            urls = [
                "https://github.com/cgrindel/swift_bazel/releases/download/v0.2.1/swift_bazel.v0.2.1.tar.gz",
            ],
        )
        
        load("@cgrindel_swift_bazel//:deps.bzl", "swift_bazel_dependencies")
        
        swift_bazel_dependencies()
        
        # ...
        """))
    },
]
