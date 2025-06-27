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

// MARK: iOS 18 Extensions

@MainActor
extension Backport where Content: View {
    @ViewBuilder func presentationSizeForm() -> some View {
        if #available(iOS 18, *) {
            content.presentationSizing(.form)
        } else {
            content
        }
    }
    
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
    
    @ViewBuilder func imagePlayground(
        _ presented: Binding<Bool>,
        completion: @escaping (URL?) -> Void
    ) -> some View {
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

// MARK: iOS 26 Extensions

public enum BackportGlass: Equatable, Sendable {
    case regular
    case tinted(Color?)
    case interactive(isEnabled: Bool)
    case tintedAndInteractive(color: Color?, isEnabled: Bool)
    
    // Default convenience
    public static var regularInteractive: BackportGlass {
        .tintedAndInteractive(color: nil, isEnabled: true)
    }
}

@available(iOS 26, *)
extension BackportGlass {
    public var toGlass: Glass {
        switch self {
        case .regular:
            return .regular
        case .tinted(let color):
            return .regular.tint(color)
        case .interactive(let isEnabled):
            return .regular.interactive(isEnabled)
        case .tintedAndInteractive(let color, let isEnabled):
            return .regular.tint(color).interactive(isEnabled)
        }
    }
}

public enum BackportGlassEffectTransition: Equatable, Sendable {
    case identity
    case matchedGeometry(properties: MatchedGeometryProperties = .frame, anchor: UnitPoint = .center)
}

@available(iOS 26, *)
extension BackportGlassEffectTransition {
    var toTransition: GlassEffectTransition {
        switch self {
        case .identity:
            return .identity
        case .matchedGeometry(let properties, let anchor):
            return .matchedGeometry(properties: properties, anchor: anchor)
        }
    }
}

public enum BackportScrollEdgeEffectStyle: Hashable, Sendable {
    case automatic
    case hard
    case soft
}

@available(iOS 26.0, *)
extension BackportScrollEdgeEffectStyle {
    var toStyle: ScrollEdgeEffectStyle {
        switch self {
        case .automatic: return .automatic
        case .hard: return .hard
        case .soft: return .soft
        }
    }
}

@MainActor
extension Backport where Content: View {
    @ViewBuilder func glassEffectTransition(
        _ transition: BackportGlassEffectTransition,
        isEnabled: Bool = true
    ) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffectTransition(transition.toTransition, isEnabled: isEnabled)
        } else {
            content
        }
    }

    @ViewBuilder func glassEffect(
        _ backportGlass: BackportGlass = .regular,
        in shape: some Shape = Capsule(),
        isEnabled: Bool = true
    ) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffect(backportGlass.toGlass, in: shape, isEnabled: isEnabled)
        } else {
            content
        }
    }
    
    @ViewBuilder func glassEffect(
        _ backportGlass: BackportGlass = .regular,
        in shape: some Shape = Capsule(),
        isEnabled: Bool = true,
        fallbackBackground: some ShapeStyle) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffect(backportGlass.toGlass, in: shape, isEnabled: isEnabled)
        } else {
            content.background(fallbackBackground)
        }
    }
    
    @ViewBuilder func glassButtonStyle() -> some View {
        if #available(iOS 26.0, *) {
            content.buttonStyle(.glass)
        } else {
            content
        }
    }
    
    @ViewBuilder func backgroundExtensionEffect() -> some View {
        if #available(iOS 26.0, *) {
            content.backgroundExtensionEffect()
        } else {
            content
        }
    }

    @ViewBuilder func scrollEdgeEffectStyle(
        _ style: BackportScrollEdgeEffectStyle?,
        for edges: Edge.Set
    ) -> some View {
        if #available(iOS 26.0, *) {
            content.scrollEdgeEffectStyle(style?.toStyle, for: edges)
        } else {
            content
        }
    }

    @ViewBuilder func scrollEdgeEffectDisabled(
        _ disabled: Bool = true,
        for edges: Edge.Set = .all
    ) -> some View {
        if #available(iOS 26.0, *) {
            content.scrollEdgeEffectDisabled(disabled, for: edges)
        } else {
            content
        }
    }
    
    @ViewBuilder func glassEffectID(
        _ id: (some Hashable & Sendable)?,
        in namespace: Namespace.ID
    ) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffectID(id, in: namespace)
        } else {
            content
        }
    }
}
