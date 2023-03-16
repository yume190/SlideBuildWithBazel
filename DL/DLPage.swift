//
//  DL.swift
//  Example
//
//  Created by Yume on 2023/3/10.
//

import CodeView
import Foundation
import SwiftUI
import Util

public let pages: [any View] = [
    DLPage(),
]

private let spm: SourceFile = .init(.swift, """
// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SPM",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(name: "DL", type: .dynamic, targets: ["DL"]),
    ],
    targets: [
        .target(name: "DL")
    ]
)
""", "Package.swift")
private let code: SourceFile = .init(.swift, """
import SwiftUI

struct ContentView: View {
    @State var count = 0
    
    var body: some View {
        VStack {
            Text("\\(count)")
                
            Button("+") {
                count += 1
            }
            
            Button("-") {
                count -= 1
            }
            
            Button("++") {
                count += 100
            }
        }
        .foregroundColor(.white)
        .background(Color.black)
    }
}
""", "Sources/DL/View.swift")
private let loadable: SourceFile = .init(.swift, """
import SwiftUI

open class PluginBuilder {
    // MARK: Lifecycle

    public init() { }

    // MARK: Open

    open func build() -> any View {
        print("dummy")
        return Text("dummy")
    }
}

final class _PluginBuilder: PluginBuilder {
    override final
    func build() -> any View {
        print("Plugin")
        return ContentView()
    }
}

@_cdecl("createPlugin")
public func createPlugin() -> UnsafeMutableRawPointer {
    Unmanaged.passRetained(_PluginBuilder()).toOpaque()
}

""", "Sources/DL/Loadable.swift")

private struct DLPage: View {
    let term = TerminalView(.default)
    
      var body: some View {
        VStack {
//            Text("Dynamic Load").title
            HStack {
                CodeView(code, .default, true)
                VStack {
                    Button.cmd(term, "swift build")
                }
                DLView()
            }
            term
                .initialize(code, spm, loadable)
        }
    }
}

private struct DLView: View {
    let ws: Workspace = .default
    @State var dlView: AnyView = Text("Temp 123").title.anyView
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Load") {
                let path = ws.to + "/.build/debug/libDL.dylib"
                do {
                    dlView = try PluginLoader.load(at: path)
                } catch {
                    dlView = Text("Load Fail").title.anyView
                }
            }.styled
            dlView
        }
    }
}


extension View {
    var anyView: AnyView {
        .init(erasing: self)
    }
}
