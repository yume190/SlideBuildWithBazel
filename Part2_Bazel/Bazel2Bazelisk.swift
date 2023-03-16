//
//  Bazelisk.swift
//  Example
//
//  Created by Yume on 2023/3/8.
//

import CodeView
import Foundation
import SwiftUI

let bazelisk: [any View] = [
    VStack {
        Text("brew install bazelisk").title
    },

    BazeliskPage0(),
    BazeliskPage1(),
]

private struct BazeliskPage0: View {
    let term = TerminalView(.default)
    private let ver5: SourceFile = .init(.python, """
    5.0.0
    """, ".bazelversion")
    var body: some View {
        VStack {
            Text("bazelisk & .bazelversion").title
            HStack {
                CodeView(ver5, .default, true)
                VStack {
                    Button.cmd(term, "bazel --version")
                }
            }
            term
                .initialize(ver5, .workspace)
        }
    }
}

private struct BazeliskPage1: View {
    let term = TerminalView(.default)
    private let ver6: SourceFile = .init(.python, """
    6.0.0
    """, ".bazelversion")
    var body: some View {
        VStack {
            Text("bazelisk & .bazelversion").title
            HStack {
                CodeView(ver6, .default, true)
                VStack {
                    Button.cmd(term, "bazel --version")
                }
            }
            term
                .initialize(ver6, .workspace)
        }
    }
}
