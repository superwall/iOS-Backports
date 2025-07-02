//
//  BackDeployedImagePlaygroundSheet.swift
//  SwiftUIBackports
//
//  Created by Ricky Witherspoon on 7/2/25.

import SwiftUI
import ImagePlayground

/// Presents the Image Playground sheet if the device is running iOS 18.1 or later.
///
/// This view modifier conditionally presents an AI image generation sheet using Apple's
/// Image Playground framework. If the OS version is below iOS 18.1, the modifier has no effect.
///
/// Use this to back-deploy support for the Image Playground experience while maintaining compatibility
/// with earlier OS versions.
///
/// - Parameters:
///   - isPresented: A binding to a Boolean value that determines whether the sheet is presented.
///   - sourceImage: An optional image that can be used as a starting point in the playground (currently unused).
///   - onCompletion: A closure that is called with the generated image file URL when the user finishes the playground.
///   - onCancellation: An optional closure that is called if the user cancels the playground experience.
/// - Returns: A view that conditionally presents the Image Playground sheet on supported OS versions.
@MainActor
public extension Backport where Content: View {
    func backDeployedImagePlaygroundSheet(
        isPresented: Binding<Bool>,
        sourceImage: Image? = nil,
        onCompletion: @escaping (URL) -> Void,
        onCancellation: (() -> Void)? = nil
    ) -> some View {
        if #available(iOS 18.1, *) {
            return content.imagePlaygroundSheet(
                isPresented: isPresented,
                onCompletion: onCompletion,
                onCancellation: onCancellation
            )
        } else {
            return content
        }
    }
}
