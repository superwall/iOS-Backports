// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import ImagePlayground

public struct Backport<Content> {
    public let content: Content
    
    public init(_ content: Content) {
        self.content = content
    }
}

extension View {
    var backport: Backport<Self> { Backport(self) }
}

// MARK: iOS Version Extensions

@MainActor
extension Backport where Content: View {
    @ViewBuilder func presentationSizeForm() -> some View {
        if #available(iOS 18, *) {
            content.presentationSizing(.form)
        } else {
            content
        }
    }
    
    @ViewBuilder func zoom(sourceID: some Hashable, in namespace: Namespace.ID) -> some View {
        if #available(iOS 18.0, *) {
            content
                .navigationTransition(.zoom(sourceID: sourceID, in: namespace))
                .interactiveDismissDisabled()
        } else {
            content
        }
    }
    
    @ViewBuilder func matchedTransitionSource(id: some Hashable, in namespace: Namespace.ID) -> some View {
        if #available(iOS 18.0, *) {
            content.matchedTransitionSource(id: id, in: namespace)
        } else {
            content
        }
    }
    
    @ViewBuilder func imagePlayground(_ presented: Binding<Bool>, completion: @escaping (URL?) -> Void) -> some View {
        if #available(iOS 18.1, *) {
            if ImagePlaygroundViewController.isAvailable {
                content
                    .imagePlaygroundSheet(isPresented: presented) { url in
                        completion(url)
                    }
            } else {
                content
            }
        } else {
            content
        }
    }
}
