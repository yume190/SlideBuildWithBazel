//
//  SwiftPage.swift
//  CodeView
//
//  Created by Yume on 2023/3/3.
//

import CodeView
import Foundation
import SwiftUI
import Util

var spms: [any View] {
    [
        VStack {
            Text("SPM").title
        },
        SwiftPage1(),
    ]
}

private struct SwiftPage1: View {
    let code: SourceFile = .swiftMain("""
    // Main.swift
    print("hello")
    """)
    let term = TerminalView(.default)

    var body: some View {
        VStack {
            Text("SPM").title
            HStack {
                CodeView(code, .default, true)
                VStack {
                    Button.cmd(term, "tree")
                    Button.cmd(term, "swift run")
                }
            }
            term
                .initialize(code, .swiftPackage)
        }
    }
}
