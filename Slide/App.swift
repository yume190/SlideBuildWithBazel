//
//  CodeViewApp.swift
//  CodeView
//
//  Created by Yume on 2023/2/2.
//

import CodeView
import SwiftUI
import Util
import Part1
import Part2
import Part3
import DL

let allPage: [[AnyView]] = [
    Part1.pages.map(\.anyView),
    Part2.pages.map(\.anyView),
    Part3.pages.map(\.anyView),
    DL.pages.map(\.anyView),
]

@main
struct CodeViewApp: App {
    @State var index = 0
    @State var part = 0
    @State var scale: CGFloat = 1
    @State var fontSize: CGFloat = 18
    var currentPart: [AnyView] { allPage[part] }

    var body: some Scene {
        WindowGroup {
            ZStack {
                currentPart[index]
                    .frame(
                        idealWidth: .infinity,
                        maxWidth: .infinity,
                        minHeight: 400,
                        idealHeight: .infinity,
                        maxHeight: .infinity
                    )
                    .padding(.all, 60)

                VStack(alignment: .trailing) {
                    Spacer()
                    HStack(alignment: .bottom) {
                        Spacer()
                        Text("\(index + 1)/\(currentPart.count)")
                    }
                }.padding()

                FocusView()
                    .frame(width: 0, height: 0)
                    .touchBar {
                        Button("Let's Build") {
                            index = 0
                            part = 0
                        }
                        Button("Part 2") {
                            index = 0
                            part = 1
                        }

                        Button("Part 3") {
                            index = 0
                            part = 2
                        }

                        Button("Dynamic Loading") {
                            index = 0
                            part = 3
                        }
                        Divider()

                        Button {
                            index = max(index - 1, 0)
                        } label: {
                            Image(systemName: "arrowshape.turn.up.left.circle")
                        }

                        Button {
                            index = min(index + 1, max(currentPart.count - 1, 0))
                        } label: {
                            Image(systemName: "arrowshape.turn.up.right.circle")
                        }
                    }
            }
            .font(Font.system(size: fontSize))
            .foregroundColor(.white)
        }

        .commands {
            CommandMenu("Slide") {
                Divider()
                Button("Next") {
                    index = min(index + 1, max(currentPart.count - 1, 0))
                    print("Page: \(index)")
                }.keyboardShortcut("]")

                Button("Previous") {
                    index = max(index - 1, 0)
                    print("Page: \(index)")
                }.keyboardShortcut("[")

                Divider()

                Button("Clear Terminal") {
                    NotificationCenter.default.post(name: .clearTerm, object: nil)
                }.keyboardShortcut("k", modifiers: [.command])

                Button("Save Code") {
                    NotificationCenter.default.post(name: .save, object: nil)
                }.keyboardShortcut("s", modifiers: [.command])
            }

            CommandGroup(after: CommandGroupPlacement.help) {
                Divider()

                Button("Part 1") {
                    index = 0
                    part = 0
                }.keyboardShortcut("1", modifiers: [.command])
                Button("Part 2") {
                    index = 0
                    part = 1
                }.keyboardShortcut("2", modifiers: [.command])

                Button("Part 3") {
                    index = 0
                    part = 2
                }.keyboardShortcut("3", modifiers: [.command])

                Button("Part 4") {
                    index = 0
                    part = 3
                }.keyboardShortcut("4", modifiers: [.command])
            }

//            CommandGroup(replacing: .appInfo) {
//                Button("About MyGreatApp") {
//                    NSApplication.shared.orderFrontStandardAboutPanel(
//                        options: [
//                            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
//                                string: "Some custom info about my app.",
//                                attributes: [
//                                    NSAttributedString.Key.font: NSFont.boldSystemFont(
//                                        ofSize: NSFont.smallSystemFontSize)
//                                ]
//                            ),
//                            NSApplication.AboutPanelOptionKey(
//                                rawValue: "Copyright"
//                            ): "© 2020 NATALIA PANFEROVA"
//                        ]
//                    )
//                }
//            }
        }
    }
}
