//
//  BazelIntro.swift
//  Example
//
//  Created by Yume on 2023/3/8.
//

import Foundation
import SwiftUI

let bazelIntro: [any View] = [
    VStack {
        Text("Let's Build with Bazel").title
    },

    VStack {
        Text("What is Bazel?").title
        VStack(alignment: .leading) {
            Text("— Open source build system from Google").content
            Text("— { Fast, Correct }").content
            Text("    — Only rebuilds what is neccessary").content
            Text("    — Reproducible").content
            Text("    — Advanced local & remote caching").content
            Text("— Supports building many languages").content
        }
    },
    VStack {
        Text("brew install bazel").title
    },
]
