//
//  Bazel4_3Label.swift
//  Example
//
//  Created by Yume on 2023/3/9.
//

import CodeView
import Foundation
import SwiftUI

let bazelLabel: [any View] = [
    VStack(alignment: .center, spacing: 40) {
        Text("label").title
        Text("@repo//path/to/package:path/to/target").content
    },
    VStack(alignment: .center, spacing: 40) {
        Text("@bazel_tools//tools/build_defs/repo:git.bzl").title
        VStack(alignment: .leading, spacing: 40) {
            Text("repo - bazel_tools").content
            Text("// - WORKSPACE 所在位置").content
            Text("package - tools/build_defs/repo").content
            Text("target - git.bzl").content
        }
    },
    BazelLabelExplain0(),
    VStack {
        Text("//a/b:lib").title
        VStack(alignment: .leading) {
            Text("repo - '' (省略)").content
            Text("// - WORKSPACE 所在位置").content
            Text("package - a/b").content
            Text("target - lib").content
        }
    },
    BazelLabelExplain1(),
    VStack(alignment: .center, spacing: 40) {
        Text("label").title
    
        Text("package name 的最後一個元素等同於 target name，則可省略").content
    
        VStack(alignment: .leading, spacing: 40) {
            Text("/my/app").content
            Text("//my/app:app").content
        }
    },

    VStack(alignment: .center, spacing: 40) {
        Text("label (在相同 package 底下時)").title
    
        VStack(alignment: .leading, spacing: 40) {
            Text("//my/app:app").content
            Text("//my/app").content
            Text(":app").content
            Text("app").content
        }
    },
]

private struct BazelLabelExplain0: View {
    let term = TerminalView(.default)
    let ws: SourceFile = .init(.shell, "", "external/bazel_tools/WORKSPACE")
    let build: SourceFile = .init(.shell, "", "external/bazel_tools/tools/build_defs/repo/BUILD")
    let file: SourceFile = .init(.shell, "", "external/bazel_tools/tools/build_defs/repo/git.bzl")
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Text("@bazel_tools//tools/build_defs/repo:git.bzl").title
            
            Button.cmd(term, "tree")
                .frame(height: 200)
                
            term
                .initialize(ws, build, file)
        }
    }
}

private struct BazelLabelExplain1: View {
    let term = TerminalView(.default)
    let ws: SourceFile = .init(.shell, "", "WORKSPACE")
    let build: SourceFile = .init(.python, """
    cc_library(
        name = "lib",
        srcs = [
            "main.c",
        ],
    )
    """, "a/b/BUILD")
    let file: SourceFile = .init(.shell, "", "a/b/main.c")
    var body: some View {
        VStack {
            Text("//a/b:lib").title
            HStack {
                CodeView(build)
                Button.cmd(term, "tree")
                    .frame(height: 200)
            }

            term
                .initialize(ws, build, file)
        }
    }
}

private struct BazelLabelPage0: View {
    var body: some View {
        VStack {
            Text("label").title
            
            HStack {
                CodeView(.md("""
                > @bazel_tools//tools/build_defs/repo:git.bzl
                
                > lib
                
                |term|git.bzl|lib|
                |:-|:-|:-|
                |@repo|bazel_tools|repo = ''(省略 '@')|
                |// WORKSPACE|||
                |To Package|tools/build_defs/repo|a/b|
                |target|git.bzl|lib|
                
                > bazel build //a/b:lib
                
                ---
                
                > package name 的最後一個元素等同於 target name，則可省略
                
                //my/app
                
                //my/app:app
                
                ---
                
                > 在相同 package(my/app) 底下時，下列等價
                
                //my/app:app
                
                //my/app
                
                :app
                
                app
                """))
                CodeView(.init(.python, """
                cc_library(
                    name = "lib",
                )
                """, "a/b/BUILD"), nil, true)
            }
        }
    }
}
