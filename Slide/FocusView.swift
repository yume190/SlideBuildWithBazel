//
//  FocusView.swift
//  Example
//
//  Created by Yume on 2023/3/13.
//

import Foundation
import SwiftUI


/// https://stackoverflow.com/questions/59919050/how-can-i-display-touch-bar-buttons-using-swiftui
/// Bit of a hack to enable touch bar support.
class FocusNSView: NSView {
    override var acceptsFirstResponder: Bool {
        return true
    }
}

/// Gets the keyboard focus if nothing else is focused.
struct FocusView: NSViewRepresentable {

    func makeNSView(context: NSViewRepresentableContext<FocusView>) -> FocusNSView {
        return FocusNSView()
    }

    func updateNSView(_ nsView: FocusNSView, context: Context) {

        // Delay making the view the first responder to avoid SwiftUI errors.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if let window = nsView.window {

                // Only set the focus if nothing else is focused.
                if let _ = window.firstResponder as? NSWindow {
                    window.makeFirstResponder(nsView)
                }
            }
        }
    }
}
