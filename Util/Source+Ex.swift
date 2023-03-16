//
//  File.swift
//
//
//  Created by Yume on 2023/3/6.
//

import CodeView
import Foundation

public extension Workspace {
    static let iOS: Workspace = {
        let folder = Bundle.main.path(forResource: "iOS", ofType: nil, inDirectory: "Resource.bundle")! + "/"
        return Workspace(from: folder, path: "iOS")
    }()
}

public extension SourceFile {
    static let swiftPackage: SourceFile = .init(.swift, """
    // swift-tools-version: 5.7

    import PackageDescription

    let package = Package(
        name: "SPM",
        targets: [
            .executableTarget(
                name: "SPM",
                dependencies: []),
        ]
    )

    """, "Package.swift")

    static let swiftA: SourceFile = .init(.swift, """
    func a() {
        print(#function, "a")
    }

    @main
    enum Main {
        static func main() {
            a()
            b()
        }
    }

    """, "a.swift")

    static let swiftB: SourceFile = .init(.swift, """
    func b() {
        print(#function)
    }

    """, "b.swift")

    static let cMain: SourceFile = .init(.c, """
    #include <stdio.h>
    #include "add.h"
    int main() {
        printf("Hello world c %d", add(1, 2));
        return 0;
    }
    """, "main.c")

    static let cAdd: SourceFile = .init(.c, """
    int add(int a, int b) {
        return a + b;
    }
    """, "add.c")

    static let cAdd2: SourceFile = .init(.c, """
    int add(int a, int b) {
        return a + b + 2;
    }
    """, "add2.c")

    static let hAdd: SourceFile = .init(.c, """
    int add(int a, int b);
    """, "add.h")

    // MARK: Bazel

    static let cBuild: SourceFile = .init(.python, """
    cc_library(
        name = "lib",
        hdrs = [
            "add.h",
        ],
        srcs = [
            "add.c",
            "main.c",
        ],
    )

    cc_binary(
        name = "bin",
        deps = [
            ":lib",
        ],
    )
    """, "BUILD")

    static let workspace: SourceFile = .init(.python, "", "WORKSPACE")
}
