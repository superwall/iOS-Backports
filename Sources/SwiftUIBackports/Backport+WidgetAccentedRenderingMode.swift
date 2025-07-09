//
//  WidgetAccentedRenderingMode+BackDeploy.swift
//  SwiftUIBackports
//
//  Created by Ricky Witherspoon on 7/2/25.

import SwiftUI
import WidgetKit

/// A back deployed enum for `WidgetAccentedRenderingMode`
public enum BackDeployedWidgetAccentedRenderingMode {
    /// Specifies that the Image should be included as part of the accented widget group.
    case accented
    /// Maps the luminance of the Image in to the alpha channel, replacing color channels with the color applied to the default group.
    case desaturated
    /// Maps the luminance of the Image in to the alpha channel, replacing color channels with the color applied to the accent group.
    case accentedDesaturated
    /// Specifies that the Image should be rendered at full color with no other color modifications. Only applies to iOS.
    case fullColor
}

@available(iOS 18.0, *)
extension BackDeployedWidgetAccentedRenderingMode {
    /// A back deployed method for `WidgetAccentedRenderingMode`
    fileprivate var value: WidgetAccentedRenderingMode {
        switch self {
        case .accented: .accented
        case .desaturated: .desaturated
        case .accentedDesaturated: .accentedDesaturated
        case .fullColor: .fullColor
        }
    }
}

public extension Backport where Content == Image {
    /// A back deployed method for `widgetAccentedRenderingMode` view modifier
    func widgetAccentedRenderingMode(_ renderingMode: BackDeployedWidgetAccentedRenderingMode?) -> some View {
        if #available(iOS 18.0, *) {
            return content
                .widgetAccentedRenderingMode(renderingMode?.value)
        } else {
            return content
        }
    }
}
