//
//  SimplePage.swift
//  CodeView
//
//  Created by Yume on 2023/3/3.
//

import CodeView
import Foundation
import SwiftUI
import Util

var simples: [any View] {
    [
        VStack {
            Text("純指令執行").title
        },
        SimplePage1(),
        SimplePage2(),
        SimplePage3(),
    ]
}

private struct SimplePage1: View {
    let term = TerminalView(.default)

    var body: some View {
        VStack {
            Text("Compile c code").title
            HStack {
                CodeView(.cMain, .default, true)
                VStack {
                    Button.cmd(term, "clang -c main.c -o main.o")
                    Button.cmd(term, "clang -c add.c -o add.o")
                    Button.cmd(term, "clang main.o add.o -o main")
                    Button.cmd(term, "執行", "./main")
                }
            }
            term
                .initialize(.cMain, .cAdd, .cAdd2, .hAdd)
        }
    }
}

private struct SimplePage2: View {
    let term = TerminalView(.default)

    var body: some View {
        VStack {
            Text("Compile swift code").title
            HStack {
                CodeView(.swiftA, .default, true)
                CodeView(.swiftB, .default, true)
                VStack {
                    Button.cmd(term, "compile a.swift", """
                    swiftc a.swift -o a.o
                    """)
                }
            }
            term
                .initialize(.swiftA, .swiftB)
        }
    }
}

private struct SimplePage3: View {
    let term = TerminalView(.default)

    var body: some View {
        VStack {
            Text("Compile swift code").title
            HStack {
                CodeView(.swiftA, .default, true)
                CodeView(.swiftB, .default, true)
                VStack {
                    Button.cmd(term, "compile a.swift", """
                    swiftc -frontend \
                            -c \
                            b.swift \
                            -primary-file a.swift \
                            -o a.o \
                            -module-name Temp \
                            -sdk `xcrun --sdk macosx --show-sdk-path` \
                            -target \(arch)-apple-macos11.0
                    """)

                    Button.cmd(term, "compile b.swift", """
                    swiftc -frontend \
                            -c \
                            a.swift \
                            -primary-file b.swift \
                            -o b.o \
                            -module-name Temp \
                            -sdk `xcrun --sdk macosx --show-sdk-path` \
                            -target \(arch)-apple-macos11.0
                    """)
                    Button.cmd(term, "link all", """
                    swiftc \
                            a.o b.o \
                            -o main
                    """)
                    Button.cmd(term, "執行", "./main")
                }
            }
            term
                .initialize(.swiftA, .swiftB)
        }
    }
}
