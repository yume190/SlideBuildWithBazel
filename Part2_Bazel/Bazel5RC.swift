//
//  BazelRC.swift
//  Example
//
//  Created by Yume on 2023/3/8.
//

import CodeView
import Foundation
import SwiftUI
import Util

let bazelRC: [any View] = [
    Text(".bazelrc").title,
    VStack {
        Text("System bazelrc").title
        VStack(alignment: .leading) {
            Text("--nosystem_rc").content
            Text("/etc/bazel.bazelrc").content
        }
    },
    
    VStack {
        Text("WORKSPACE bazelrc").title
        VStack(alignment: .leading) {
            Text("--noworkspace_rc").content
            Text("%workspace%/.bazelrc").content
        }
    },
    
    VStack {
        Text("Home bazelrc").title
        VStack(alignment: .leading) {
            Text("--nohome_rc").content
            Text("$HOME/.bazelrc").content
        }
    },
    
    VStack {
        Text("User-specified").title
        VStack(alignment: .leading) {
            Text("--bazelrc=x.rc").content
            Text("--bazelrc=y.rc").content
            Text("--bazelrc=z.rc").content
        }
    },
    
    VStack {
        Text("rc import rx").title
        VStack(alignment: .leading) {
            CodeView(.init(.shell, """
            import %workspace%/config.bazelrc
            try-import %workspace%/x.bazelrc
            """, ".bazelrc"), nil, true)
        }
    },
    BazelRCPage1(), // build
    BazelRCPage2(), // config
    BazelRCPage3(), // local cache
    BazelRCPage4(), // remote cache
    BazelRCPage5(), // remote execution
]

private struct BazelRCPage1: View {
    let term = TerminalView(.default)
    let code: SourceFile = .init(.shell, """
    # bazel build lib
    # bazel build lib --jobs=50
    build --jobs=50
    """, ".bazelrc")
    var body: some View {
        VStack {
            Text(".bazelrc").title
            HStack {
                CodeView(code, .default, true)
                VStack {
                    Button.cmd(term, "bazel build lib")
                }
            }
            term
                .initialize(.cMain, .cAdd, .hAdd, .workspace, .cBuild, code)
        }
    }
}

private struct BazelRCPage2: View {
    let term = TerminalView(.default)
    let code: SourceFile = .init(.shell, """
    build:j4 --jobs=4
    build:j50 --jobs=50
    """, ".bazelrc")
    var body: some View {
        VStack {
            Text(".bazelrc config").title
            HStack {
                CodeView(code, .default, true)
                VStack {
                    Button.cmd(term, "bazel build lib --config=j4")
                    Button.cmd(term, "bazel build lib --config=j50")
                }
            }
            term
                .initialize(.cMain, .cAdd, .hAdd, .workspace, .cBuild, code)
        }
    }
}

private struct BazelRCPage3: View {
    let code: SourceFile = .init(.shell, """
    build --disk_cache=cache
    """, ".bazelrc")
    var body: some View {
        VStack {
            Text("Local Cache").title
            HStack {
                CodeView(code, .default, true)
            }
        }
    }
}

private struct BazelRCPage4: View {
    let code: SourceFile = .init(.shell, """
    build --remote_cache=grpcs://remote.buildbuddy.io
    build --remote_timeout=3600
    """, ".bazelrc")
    var body: some View {
        VStack {
            Text("Remote Cache").title
            HStack {
                CodeView(code, .default, true)
            }
        }
    }
}

private struct BazelRCPage5: View {
    let term = TerminalView(.default)
    let code: SourceFile = .init(.shell, """
    # some hidden api token

    # remote cache
    build:remote --remote_cache=grpcs://remote.buildbuddy.io
    build:remote --remote_timeout=3600

    # remote execute
    build:remote --remote_executor=grpcs://remote.buildbuddy.io

    build:remote --jobs=50
    build:remote --host_cpu=k8
    build:remote --cpu=k8

    build:remote --crosstool_top=@buildbuddy_toolchain//:ubuntu_cc_toolchain_suite
    build:remote --host_platform=@buildbuddy_toolchain//:platform_linux
    build:remote --extra_toolchains=@buildbuddy_toolchain//:ubuntu_cc_toolchain
    build:remote --nojava_header_compilation
    build:remote --define=EXECUTOR=remote

    """, ".bazelrc")

    let ws: SourceFile = .init(.python, """
    load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

    http_archive(
        name = "io_buildbuddy_buildbuddy_toolchain",
        # sha256 = "e899f235b36cb901b678bd6f55c1229df23fcbc7921ac7a3585d29bff2bf9cfd",
        strip_prefix = "buildbuddy-toolchain-563a6badc8a7f831fb606297cb40dc153bbe3f3f",
        urls = ["https://github.com/buildbuddy-io/buildbuddy-toolchain/archive/563a6badc8a7f831fb606297cb40dc153bbe3f3f.tar.gz"],
    )

    load("@io_buildbuddy_buildbuddy_toolchain//:deps.bzl", "buildbuddy_deps")

    buildbuddy_deps()

    load("@io_buildbuddy_buildbuddy_toolchain//:rules.bzl", "buildbuddy", "UBUNTU20_04_IMAGE")

    buildbuddy(
        name = "buildbuddy_toolchain",
        java_version = "11",
        container_image = UBUNTU20_04_IMAGE,
    )
    """, "WORKSPACE")
    var body: some View {
        VStack {
            Text("Remote Execution").title
            HStack {
                CodeView(code, .default, true)
                CodeView(ws, .default, true)
                VStack {
                    Button.cmd(term, "bazel build bin --config=remote")
                    Button.cmd(term, "bazel run bin --config=remote")
                    Button.cmd(term, "bazel build bin")
                    Button.cmd(term, "bazel run bin")
                    Button.cmd(term, "file bazel-bin/bin")
                }
            }
            term
                .initialize(.cMain, .cAdd, .hAdd, ws, .cBuild, code)
        }
    }
}
