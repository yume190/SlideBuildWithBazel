//
//  BazelTerm.swift
//  Example
//
//  Created by Yume on 2023/3/8.
//

import CodeView
import Foundation
import SwiftUI

let bazelTerm: [any View] = [
    VStack(spacing: 20) {
        Text("Term").title
        VStack(alignment: .leading, spacing: 20) {
            Text("WORKSPACE").content
            Text("BUILD").content
            Text("label").content
            Text("rule").content
            Text("target").content
        }
    },
] + bazelWS + bazelBuild + bazelLabel + [BazelRulePage0()]

private struct BazelRulePage0: View {
    var body: some View {
        VStack {
            Text("rule").title
            
            HStack {
                CodeView(.md("""
                # rule
                
                > load("@//path/to/package:file.bzl", "rule_name")
                
                > from package_name import rule_name
                
                ---
                
                ## 常見 rule
                
                 * xxx_library
                 * xxx_binary
                 * xxx_test
                
                ---
                
                ## 常見參數
                
                 * name
                 * srcs(label)
                 * deps(label)
                 * visibility
                """))
                
                CodeView(.init(.python, """
                load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
                load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

                filegroup(
                    name = "Assets",
                    srcs = glob([
                        "Assets.xcassets/**",
                        "Preview Content/Preview Assets.xcassets/**",
                    ]),
                    visibility = [
                        "//visibility:private",
                    ],
                )

                swift_library(
                    name = "Example_library",
                    module_name = "Example",
                    srcs = [
                        "//Example:ContentView.swift",
                        "//Example:ExampleApp.swift",
                        "//Example:Test.swift",
                    ],
                    testonly = False,
                    deps = [
                        "//Framework1:Framework1_library",
                    ],
                    data = [
                        ":Assets",
                    ],
                    visibility = [
                        "//visibility:private",
                    ],
                )
                
                filegroup(
                    name = "Strings",
                    srcs = [
                        "//Example:en.lproj/Localizable.strings",
                        "//Example:zh-Hant.lproj/Localizable.strings",
                    ],
                    visibility = [
                        "//visibility:private",
                    ],
                )

                ios_application(
                    name = "Example",
                    bundle_id = "com.bazel.Example",
                    families = [
                        "iphone",
                        "ipad",
                    ],
                    minimum_os_version = "16.2",
                    infoplists = [
                        "info.plist",
                    ],
                    deps = [
                        
                    ],
                    strings = [
                        ":Strings",
                    ],
                    visibility = [
                        "//visibility:public",
                    ],
                )
                """))
            }
        }
    }
}
