//
//  Button+cmd.swift
//  CodeView
//
//  Created by Yume on 2023/3/6.
//

import CodeView
import Foundation
import SwiftUI

public extension Text {
    var title: Text {
        self.font(.system(size: 80))
    }

    var content: Text {
        self.font(.system(size: 60))
    }
}

public extension Button where Label == Text {
    var styled: some View {
        self
        .padding(.all)
        .font(.system(size: 30))
        .foregroundColor(.white)
        .buttonStyle(.borderless)
        .background(Color.blue)
    }
    
    static func cmd(_ term: TerminalView, _ title: String, _ command: String? = nil) -> some View {
        return Button(title) {
            term.send(command ?? title)
        }
        .styled
    }

    static func cmd(_ title: String, action: @escaping () -> ()) -> some View {
        return Button(title) {
            action()
        }
        .styled
    }
}
