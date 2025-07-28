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

public extension View {
    var backport: Backport<Self> { Backport(self) }
}


// MARK: iOS 17 Extensions

/// Backport for ContentTransition (iOS 17)
public enum BackDeployedContentTransition {
    case identity
    case opacity
    case numericText
}

@MainActor
public extension Backport where Content: View {
    @ViewBuilder
    func contentTransition(_ transition: BackDeployedContentTransition) -> some View {
        if #available(iOS 17.0, *) {
            switch transition {
            case .identity:
                content.contentTransition(.identity)
            case .opacity:
                content.contentTransition(.opacity)
            case .numericText:
                content.contentTransition(.numericText())
            }
        } else {
            content
        }
    }
}

// MARK: iOS 18 Extensions

@MainActor
public extension Backport where Content: View {
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
    case clear
    case identity
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
        case .clear:
            return .clear
        case .identity:
            return .identity
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
    case materialize
}

@available(iOS 26, *)
public extension BackportGlassEffectTransition {
    var toTransition: GlassEffectTransition {
        switch self {
        case .identity:
            return .identity
        case .materialize:
            return .materialize
        }
    }
}

public enum BackportScrollEdgeEffectStyle: Hashable, Sendable {
    case automatic
    case hard
    case soft
}

@available(iOS 26.0, *)
public extension BackportScrollEdgeEffectStyle {
    var toStyle: ScrollEdgeEffectStyle {
        switch self {
        case .automatic: return .automatic
        case .hard: return .hard
        case .soft: return .soft
        }
    }
}

@available(iOS 26.0, *)
public extension BackportSymbolColorRenderingMode {
    var toMode: SymbolColorRenderingMode {
        switch self {
        case .flat: return .flat
        case .gradient: return .gradient
        }
    }
}

public enum BackportSymbolColorRenderingMode: Equatable, Sendable {
    case flat
    case gradient
}

public enum BackportSymbolVariableValueMode: Equatable, Sendable {
    case color
    case draw
}

@available(iOS 26.0, *)
public extension BackportSymbolVariableValueMode {
    var toMode: SymbolVariableValueMode {
        switch self {
        case .color: return .color
        case .draw: return .draw
        }
    }
}

public enum BackportTabBarMinimizeBehavior: Hashable, Sendable {
    case automatic
    case onScrollDown
    case onScrollUp
    case never
}

@available(iOS 26.0, *)
public extension BackportTabBarMinimizeBehavior {
    var toBehavior: TabBarMinimizeBehavior {
        switch self {
        case .automatic:
            return .automatic
        case .onScrollDown:
            return .onScrollDown
        case .onScrollUp:
            return .onScrollUp
        case .never:
            return .never
        }
    }
}

@MainActor
public extension Backport where Content: View {
    @ViewBuilder func presentationBackground(in shape: some ShapeStyle = Material.thin) -> some View {
        if #available(iOS 26.0, *) {
            content
        } else {
            content.presentationBackground(shape)
        }
    }
    
    @ViewBuilder func glassEffectTransition(_ transition: BackportGlassEffectTransition) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffectTransition(transition.toTransition)
        } else {
            content
        }
    }
    
    @ViewBuilder func glassEffect(
        _ backportGlass: BackportGlass = .regular,
        in shape: some Shape = Capsule()
    ) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffect(backportGlass.toGlass, in: shape)
        } else {
            content
        }
    }
    
    @ViewBuilder func glassEffect(
        _ backportGlass: BackportGlass = .regular,
        in shape: some Shape = Capsule(),
        fallbackBackground: some ShapeStyle) -> some View {
            if #available(iOS 26.0, *) {
                content.glassEffect(backportGlass.toGlass, in: shape)
            } else {
                content.background(fallbackBackground)
            }
        }
    
    @ViewBuilder func glassButtonStyle(fallbackStyle: some PrimitiveButtonStyle = DefaultButtonStyle()) -> some View {
        if #available(iOS 26.0, *) {
            content.buttonStyle(.glass)
        } else {
            content.buttonStyle(fallbackStyle)
        }
    }

    @ViewBuilder func glassProminentButtonStyle() -> some View {
        if #available(iOS 26.0, *) {
            content.buttonStyle(.glassProminent)
        } else {
            content.buttonStyle(.borderedProminent)
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
    
    @ViewBuilder func scrollEdgeEffectHidden(
        _ hidden: Bool = true,
        for edges: Edge.Set = .all
    ) -> some View {
        if #available(iOS 26.0, *) {
            content.scrollEdgeEffectHidden(hidden, for: edges)
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
    
    @ViewBuilder func symbolColorRenderingMode(_ mode: BackportSymbolColorRenderingMode?) -> some View {
        if #available(iOS 26.0, *) {
            content.symbolColorRenderingMode(mode?.toMode)
        } else {
            content
        }
    }
    
    @ViewBuilder func symbolVariableValueMode(_ mode: BackportSymbolVariableValueMode?) -> some View {
        if #available(iOS 26.0, *) {
            content.symbolVariableValueMode(mode?.toMode)
        } else {
            content
        }
    }
    
    @ViewBuilder func tabBarMinimizeBehavior(_ behavior: BackportTabBarMinimizeBehavior) -> some View {
        if #available(iOS 26.0, *) {
            content.tabBarMinimizeBehavior(behavior.toBehavior)
        } else {
            content
        }
    }
    
    @ViewBuilder func listSectionMargins(_ edges: Edge.Set = .all, _ length: CGFloat?) -> some View {
        if #available(iOS 26.0, *) {
            content.listSectionMargins(edges, length)
        } else {
            content
        }
    }
}
