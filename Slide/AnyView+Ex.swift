//
//  Util.swift
//  CodeView
//
//  Created by Yume on 2023/3/1.
//

import SwiftUI

public extension View {
    var anyView: AnyView {
        .init(erasing: self)
    }
}
