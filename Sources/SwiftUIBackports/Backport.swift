//
//  Backport.swift
//  SwiftUIBackports
//
//  Created by Ricky Witherspoon on 7/2/25.
//

import SwiftUI

public struct Backport<Content> {
    public let content: Content
    
    public init(_ content: Content) {
        self.content = content
    }
}

public extension View {
    var backport: Backport<Self> { Backport(self) }
}
