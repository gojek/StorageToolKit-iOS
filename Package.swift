// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "StorageCleaner",
    platforms: [
        .iOS(.v12),
        .macOS(.v12),
        .watchOS(.v4)],
    products: [
        .library(
            name: "StorageCleaner",
            type: .static, targets: ["StorageCleaner"])
    ],
    dependencies: [
        .package(url: "git@github.com:gojekfarm/WorkManager.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.0.0")],
    targets: [
        .target(
            name: "StorageCleaner",
            dependencies: ["WorkManager"],
            path: "StorageCleaner/Sources"),
        .testTarget(
            name: "StorageCleanerTests",
            dependencies: ["StorageCleaner"],
            path: "StorageCleaner/Tests"),
    ]
)

