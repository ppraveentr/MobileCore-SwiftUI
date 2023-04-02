// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MobileTheme",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(name: "MobileTheme", targets: ["Theme", "Core"])
    ],
    dependencies: [
        // .package(url: "https://github.com/apple/swift-docc-plugin", branch: "main")
    ],
    targets: [
        // Theme
        .target(name: "Theme", dependencies: ["Core"]),
        .testTarget(name: "ThemeTests", dependencies: ["Theme"]),
        // Extensions
        .target(name: "Core"),
        .testTarget(name: "CoreTests", dependencies: ["Core"])
    ]
)
