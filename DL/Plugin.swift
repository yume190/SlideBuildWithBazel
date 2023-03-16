//
//  Plugin.swift
//  Example
//
//  Created by Yume on 2023/3/10.
//

import Foundation
import SwiftUI

open class PluginBuilder {
    // MARK: Lifecycle

    public init() { }

    // MARK: Open

    open func build() -> any View {
        Text("dummy")
    }
}

weak var _builder: PluginBuilder? = nil
private typealias InitFunction = @convention(c)
    () -> UnsafeMutableRawPointer

// MARK: - DynamicLoadError

enum DynamicLoadError: Error {
    case symbolNotFound(symbolName: String, path: String)
    case openFail(reason: String, path: String)
    case unknown(path: String)
}

// MARK: - PluginLoader

enum PluginLoader {
    /// ## Package.swift
    /// ---
    ///
    /// `.library(name: "Cocoapod", type: .dynamic, targets: ["Cocoapod"]),`
    ///
    /// ### Loadable Plugin Implement
    ///
    /// ```swift
    /// @_cdecl("createPlugin")
    /// public func createPlugin() -> UnsafeMutableRawPointer {
    ///     Unmanaged.passRetained(YourPluginBuilder()).toOpaque()
    /// }
    ///
    /// final class YourPluginBuilder: PluginBuilder {
    ///     override final func build(_ proj: XCodeProject) async throws -> Plugin? {
    ///         try await Pod.load(proj)
    ///     }
    /// }
    /// ```
    static func load(at path: String) throws -> AnyView {
        let openRes = dlopen(path, RTLD_NOW|RTLD_LOCAL)
        if openRes != nil {
            print("open s")
            defer {
                dlclose(openRes)
                print("release")
            }

            let symbolName = "createPlugin"
            let sym = dlsym(openRes, symbolName)

            if sym != nil {
                let f: InitFunction = unsafeBitCast(sym, to: InitFunction.self)
                let pluginPointer = f()
//                defer {
//
//                }
                let builder = Unmanaged<PluginBuilder>.fromOpaque(pluginPointer)
                    .takeRetainedValue()
                
//                _builder = builder
                let v = builder.build()
                
                return AnyView(v)
            } else {
                throw DynamicLoadError.symbolNotFound(symbolName: symbolName, path: path)
            }
        } else {
            print("open fail")
            if let err = dlerror() {
                throw DynamicLoadError.openFail(reason: String(format: "%s", err), path: path)
            } else {
                throw DynamicLoadError.unknown(path: path)
            }
        }
    }
}

