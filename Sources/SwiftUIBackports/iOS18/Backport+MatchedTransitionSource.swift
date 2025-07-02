//
//  Backport+MatchedTransitionSource.swift
//  SwiftUIBackports
//
//  Created by Ricky Witherspoon on 7/2/25.
//

import SwiftUI

@MainActor
public extension Backport where Content: View {
    @ViewBuilder func matchedTransitionSource(
        id: some Hashable,
        in namespace: Namespace.ID
    ) -> some View {
        if #available(iOS 18.0, *) {
            content.matchedTransitionSource(id: id, in: namespace)
        } else {
            content
        }
    }
}