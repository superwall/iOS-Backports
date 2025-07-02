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

extension WidgetConfiguration {
    
    /// A back deployed method for `disfavoredLocations`
    public func backDeployedDisfavoredLocations(
        _ locations: [WidgetDisfavoredLocation],
        for families: [WidgetFamily]
    ) -> some WidgetConfiguration {
        if #available(iOS 17.0, *) {
            return self.disfavoredLocations(
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
            return self
        }
    }
}
