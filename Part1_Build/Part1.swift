import SwiftUI

private let title: any View = VStack {
    Text("Let's Build").title
}

private let end: any View = VStack {
    Text("End").title
}

public let pages: [any View] = [title] + spms + simples + makes + [end]

