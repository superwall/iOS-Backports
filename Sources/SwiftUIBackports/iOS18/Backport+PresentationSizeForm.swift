//
//  Backport+PresentationSizeForm.swift
//  SwiftUIBackports
//
//  Created by Ricky Witherspoon on 7/2/25.
//

import SwiftUI

@MainActor
public extension Backport where Content: View {
    @ViewBuilder func presentationSizeForm() -> some View {
        if #available(iOS 18, *) {
            content.presentationSizing(.form)
        } else {
            content
        }
    }
}