//
//  WidgetConfiguration+BackDeploy.swift
//  SwiftUIBackports
//
//  Created by Ricky Witherspoon on 7/2/25.

import SwiftUI
import WidgetKit

/// A back deployed version of  a`WidgetLocation` object
public enum WidgetDisfavoredLocation {
    case homeScreen
    case lockScreen
    case standBy
    case iPhoneWidgetsOnMac
}

extension Backport where Content: WidgetConfiguration {
    /// A back deployed method for `disfavoredLocations`
    @MainActor
    public func disfavoredLocations(
        _ locations: [WidgetDisfavoredLocation],
        for families: [WidgetFamily]
    ) -> some WidgetConfiguration {
        if #available(iOS 17.0, *) {
            return content.disfavoredLocations(
                locations.map { location in
                    switch location {
                    case .homeScreen:
                        return .homeScreen
                    case .lockScreen:
                        return .lockScreen
                    case .standBy:
                        return .standBy
                    case .iPhoneWidgetsOnMac:
                        return .iPhoneWidgetsOnMac
                    }
                },
                for: families
            )
        } else {
            return content
        }
    }
}
