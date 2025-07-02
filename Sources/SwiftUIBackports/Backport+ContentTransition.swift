//
//  BackDeployedContentTransition.swift
//  SwiftUIBackports
//
//  Created by Ricky Witherspoon on 7/2/25.

import SwiftUI

public struct BackDeployedContentTransition {
    let value: Double
    
    /// Creates a content transition intended to be used with `Text`
    /// views displaying numeric text. In certain environments changes
    /// to the text will enable a nonstandard transition tailored to
    /// numeric characters that count up or down.
    ///
    /// - Returns: a new content transition.
    public static func numericText(value: Double) -> Self {
        return BackDeployedContentTransition(value: value)
    }
}

public extension Backport where Content: View {
    /// A back deployed version of `contentTransition`
    ///
    /// https://developer.apple.com/documentation/swiftui/view/contenttransition(_:)
    @ViewBuilder func backDeployedContentTransition(_ transition: BackDeployedContentTransition) -> some View {
        if #available(iOS 17.0, *) {
            content
                .contentTransition(.numericText(value: transition.value))
        } else {
            content
                .contentTransition(.numericText())
        }
    }
}
