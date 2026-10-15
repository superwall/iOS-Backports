import SwiftUI

@available(iOS 14, macOS 10.15, *)
public extension ToolbarContent {
    var backport: Backport<Self> { Backport(self) }
}

public enum BackDeployedToolbarItemAxisBehavior {
    /// The automatic axis behavior.
    ///
    /// The system infers the supported axes based on the content type
    /// of the item. Image items support both axes; text and custom view
    /// items support only the horizontal axis.
    case automatic

    /// The item only supports horizontal bars. If an item only supports
    /// horizontal bars and no horizontal bars are present, the item is
    /// not shown.
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    @available(visionOS, unavailable)
    case horizontalOnly

    /// The item supports both horizontal and vertical bars, and prefers
    /// a vertical placement when both horizontal and vertical bars are
    /// present.
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    @available(visionOS, unavailable)
    case verticalPreferred
}

public extension Backport where Content: ToolbarContent {
    /// The bar axis behavior of the toolbar item.
    ///
    /// Use this modifier to control which bar axes a toolbar item can
    /// appear in.
    ///
    /// The following example restricts an item to the horizontal axis.
    /// The item can only appear in a horizontal bar.
    ///
    ///     .toolbar {
    ///         ToolbarItem(placement: .primaryAction) {
    ///             Toggle(isOn: $isOn) { ... }
    ///         }
    ///         .axisBehavior(.horizontalOnly)
    ///     }
    ///
    /// If both horizontal & vertical bars are present and the item is
    /// `.verticalPreferred`, the system prefers placing the item in
    /// the vertical bar.
    ///
    /// - Parameter behavior: The axis behavior of the item.
    @ViewBuilder func axisBehavior(_ behavior: BackDeployedToolbarItemAxisBehavior) -> some ToolbarContent {
        if #available(anyAppleOS 27.1, *) {
            switch behavior {
            case .automatic: content.axisBehavior(.automatic)
            case .horizontalOnly: content.axisBehavior(.horizontalOnly)
            case .verticalPreferred: content.axisBehavior(.verticalPreferred)
            }
        } else {
            content
        }
    }
}

