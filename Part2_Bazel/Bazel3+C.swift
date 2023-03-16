//
//  Bazel+C.swift
//  Example
//
//  Created by Yume on 2023/3/8.
//

import CodeView
import Foundation
import SwiftUI

let bazelC: [any View] = [
    BazelCPage0()
]

private struct BazelCPage0: View {
    let term = TerminalView(.default)
    var body: some View {
        VStack {
            Text("First bazel in c").title
            HStack {
                CodeView(.cBuild, .default, true)
                CodeView(.cMain, .default, true)
                CodeView(.cAdd, .default, true)
                VStack {
                    Button.cmd(term, "bazel build lib")
                    Button.cmd(term, "bazel run bin")
                }
            }
            term
                .initialize(.cMain, .cAdd, .hAdd, .workspace, .cBuild)
        }
    }
}
