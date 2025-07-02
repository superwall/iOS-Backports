//
//  Backport+Zoom.swift
//  SwiftUIBackports
//
//  Created by Ricky Witherspoon on 7/2/25.
//

import SwiftUI

@MainActor
public extension Backport where Content: View {
    @ViewBuilder func zoom(
        sourceID: some Hashable,
        in namespace: Namespace.ID
    ) -> some View {
        if #available(iOS 18.0, *) {
            content
                .navigationTransition(.zoom(sourceID: sourceID, in: namespace))
                .interactiveDismissDisabled()
        } else {
            content
        }
    }
}