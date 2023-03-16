//
//  BazelSwift.swift
//  Example
//
//  Created by Yume on 2023/3/6.
//

import CodeView
import Foundation
import SwiftUI
import Util

public let pages: [any View] = [
    VStack {
        Text("Let's Build iOS with Bazel").title
    },

    VStack {
        Text("Find repo rules_xxx").title
    },

    RuleSwift(),
    RuleApple(),

    Text("Bzlmod").title,
    VStack {
        Text("BCR").title
        Text("bazelbuild/bazel-central-registry").content
    },
    VStack {
        Text("Bzlmod").title
        Text("--experimental_enable_bzlmod").content

        CodeView(.init(.python, """
        module(
           name = "MyModule",
           version = "0.0.1",
        )

        bazel_dep(name = "rules_apple", version = "2.1.0", repo_name = "build_bazel_rules_apple")
        bazel_dep(name = "rules_swift", version = "1.5.1", , repo_name = "build_bazel_rules_swift")
        """, "MODULE.bazel"), nil, true)
    },
    
    
    VStack {
        Text("WORKSPACE vs Bzlmod").title
        Text("https://github.com/bazel-contrib/Bazel-learning-paths")
        
        HStack {
            CodeView(.init(.python, """
            load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

            RULES_JVM_EXTERNAL_TAG = "4.0"
            RULES_JVM_EXTERNAL_SHA = "31701ad93dbfe544d597dbe62c9a1fdd76d81d8a9150c2bf1ecf928ecdf97169"

            http_archive(
                name = "rules_jvm_external",
                strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
                sha256 = RULES_JVM_EXTERNAL_SHA,
                url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
            )

            load("@rules_jvm_external//:defs.bzl", "maven_install")

            maven_install(
                artifacts = [
                    "org.apache.commons:commons-configuration2:2.7",
                    "commons-beanutils:commons-beanutils:1.9.2",
                    "junit:junit:4.13.2"
                ],
                repositories = [
                    "https://repo1.maven.org/maven2",
                ],
            )
            """, "WORKSPACE"), nil, true)
                
            CodeView(.init(.python, """
            bazel_dep(name = "rules_jvm_external", version = "4.5")

            maven = use_extension("@rules_jvm_external//:extensions.bzl", "maven")
            maven.install(
                artifacts = [
                    # This line is an example coordinate, you'd copy-paste your actual dependencies here
                    # from your build.gradle or pom.xml file.
                    "org.apache.commons:commons-configuration2:2.7",
                    "commons-beanutils:commons-beanutils:1.9.2",
                    "junit:junit:4.13.2",
                ],
                repositories = [
                    # Private repositories are supported through HTTP Basic auth
                    "http://username:password@localhost:8081/artifactory/my-repository",
                    "https://maven.google.com",
                    "https://repo1.maven.org/maven2",
                ],
                lock_file = "//:maven_install.json",
            )
            use_repo(maven, "maven", "unpinned_maven")
            """, "MODULE.bazel"), nil, true)
        }
    },

    VStack {
        Text("整合 Swift Lib").title
    },

    VStack {
        Text("整合 Cocoapod").title
        VStack(alignment: .leading, spacing: 40) {
            Text("bazel-xcode/PodToBUILD").title
        }
    },

    VStack {
        Text("整合 SPM").title
        VStack(alignment: .leading, spacing: 40) {
            Text("cgrindel/swift_bazel").title
        }
    },

    BazelThirdLib(),

    VStack {
        Text("整合 XCode").title
        VStack(alignment: .leading, spacing: 40) {
            Text("buildbuddy-io/rules_xcodeproj").title
        }
    },

    BazelSwiftPage3(),
]

private struct BazelSwiftPage1: View {
    let code: SourceFile = .init(.python, """
    load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
    load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

    # rules_apple
    http_archive(
        name = "build_bazel_rules_apple",
        sha256 = "43737f28a578d8d8d7ab7df2fb80225a6b23b9af9655fcdc66ae38eb2abcf2ed",
        url = "https://github.com/bazelbuild/rules_apple/releases/download/2.0.0/rules_apple.2.0.0.tar.gz",
    )

    load(
        "@build_bazel_rules_apple//apple:repositories.bzl",
        "apple_rules_dependencies",
    )

    apple_rules_dependencies()

    load(
        "@build_bazel_apple_support//lib:repositories.bzl",
        "apple_support_dependencies",
    )

    apple_support_dependencies()

    # rules_swift
    http_archive(
        name = "build_bazel_rules_swift",
        sha256 = "84e2cc1c9e3593ae2c0aa4c773bceeb63c2d04c02a74a6e30c1961684d235593",
        url = "https://github.com/bazelbuild/rules_swift/releases/download/1.5.1/rules_swift.1.5.1.tar.gz",
    )

    load(
        "@build_bazel_rules_swift//swift:repositories.bzl",
        "swift_rules_dependencies",
    )

    swift_rules_dependencies()

    load(
        "@build_bazel_rules_swift//swift:extras.bzl",
        "swift_rules_extra_dependencies",
    )

    swift_rules_extra_dependencies()

    """)
    let term = TerminalView(.default)
    var body: some View {
        VStack {
            Text("WORKSPACE").title
            HStack {
                CodeView(code)
            }
        }
    }
}

private struct BazelSwiftPage2: View {
    let code: SourceFile = .init(.python, """
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
            "info.plist"
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
    """)
    let term = TerminalView(.default)
    var body: some View {
        VStack {
            Text("BUILD").title
            HStack {
                CodeView(code)
            }
        }
    }
}

private struct BazelSwiftPage3: View {
    let term = TerminalView(.iOS)
    var body: some View {
        VStack {
            Text("WORKSPACE").title
            HStack {
                CodeView(.init(.python, origin: .iOS, "Example/BUILD"), .iOS, true)
                CodeView(.init(.python, origin: .iOS, "Framework2Tests/BUILD"), .iOS, true)
                CodeView(.init(.swift, origin: .iOS, "Framework2Tests/Framework2Tests.swift"), .iOS, true)
                VStack {
                    Button.cmd(term, "open", "open Example.xcodeproj")
                    Button.cmd(term, "build", "make build")
                    Button.cmd(term, "run", "make run")
                    Button.cmd(term, "test", "make test")
                }
            }

            term.initialize()
        }
    }
}

private struct BazelThirdLib: View {
    let ws: SourceFile = .init(.python, """
    load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
    load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

    http_archive(
        name = "build_bazel_rules_swift",
        sha256 = "d25a3f11829d321e0afb78b17a06902321c27b83376b31e3481f0869c28e1660",
        url = "https://github.com/bazelbuild/rules_swift/releases/download/1.6.0/rules_swift.1.6.0.tar.gz",
    )

    load(
        "@build_bazel_rules_swift//swift:repositories.bzl",
        "swift_rules_dependencies",
    )

    swift_rules_dependencies()

    load(
        "@build_bazel_rules_swift//swift:extras.bzl",
        "swift_rules_extra_dependencies",
    )

    swift_rules_extra_dependencies()

    new_git_repository(
        name = "AlamofireCustomRepo",
        tag = "5.6.1",
        remote = "https://github.com/Alamofire/Alamofire",
        build_file = "//:bazel/Alamofire.BUILD",
    )
    """, "WORKSPACE")
    let alamo: SourceFile = .init(.python, """
    load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

    swift_library(
        name = "Alamofire_CustomLib",
        # import Alamofire
        module_name = "Alamofire",
        srcs = glob(["Source/*.swift"]),
        copts = ["-DSWIFT_PACKAGE"],
        visibility = ["//visibility:public"],
    )
    """, "bazel/Alamofire.BUILD")
    let build: SourceFile = .init(.python, """
    load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

    swift_library(
        name = "lib",
        deps = [
            "@AlamofireCustomRepo//:Alamofire_CustomLib",
        ],
    )
    """, "BUILD")
    let term = TerminalView(.default)
    var body: some View {
        VStack {
            Text("整合 Alamofire").title
            HStack {
                CodeView(ws, nil, true)
                CodeView(alamo, nil, true)
                Button.cmd(term, "build", "bazel build @AlamofireCustomRepo//:Alamofire_CustomLib")
            }
            term.initialize(ws, build, alamo)
        }
    }
}

private struct RuleApple: View {
    var body: some View {
        VStack {
            Text("Rule Apple").title
            CodeView(.init(.python, """
            load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

            http_archive(
                name = "build_bazel_rules_apple",
                sha256 = "3e2c7ae0ddd181c4053b6491dad1d01ae29011bc322ca87eea45957c76d3a0c3",
                url = "https://github.com/bazelbuild/rules_apple/releases/download/2.1.0/rules_apple.2.1.0.tar.gz",
            )

            load(
                "@build_bazel_rules_apple//apple:repositories.bzl",
                "apple_rules_dependencies",
            )

            apple_rules_dependencies()

            load(
                "@build_bazel_rules_swift//swift:repositories.bzl",
                "swift_rules_dependencies",
            )

            swift_rules_dependencies()

            load(
                "@build_bazel_rules_swift//swift:extras.bzl",
                "swift_rules_extra_dependencies",
            )

            swift_rules_extra_dependencies()

            load(
                "@build_bazel_apple_support//lib:repositories.bzl",
                "apple_support_dependencies",
            )

            apple_support_dependencies()
            """, "WORKSPACE"), nil, true)
        }
    }
}

private struct RuleSwift: View {
    var body: some View {
        VStack {
            Text("Rule Swift").title
            CodeView(.init(.python, """
            load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

            http_archive(
                name = "build_bazel_rules_swift",
                sha256 = "d25a3f11829d321e0afb78b17a06902321c27b83376b31e3481f0869c28e1660",
                url = "https://github.com/bazelbuild/rules_swift/releases/download/1.6.0/rules_swift.1.6.0.tar.gz",
            )

            load(
                "@build_bazel_rules_swift//swift:repositories.bzl",
                "swift_rules_dependencies",
            )

            swift_rules_dependencies()

            load(
                "@build_bazel_rules_swift//swift:extras.bzl",
                "swift_rules_extra_dependencies",
            )

            swift_rules_extra_dependencies()
            """, "WORKSPACE"), nil, true)
        }
    }
}
