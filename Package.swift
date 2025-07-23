// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SwiftUIBackports",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SwiftUIBackports",
            targets: ["SwiftUIBackports"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftUIBackports",
            dependencies: [
                .framework(name: "WidgetKit")
            ],
            path: "Sources/SwiftUIBackports"
        ),
    ]
)
