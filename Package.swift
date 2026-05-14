// swift-tools-version: 6.2

import Foundation
import PackageDescription

let packageDirectory = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
let localQuiverPackagesRoot = Context.environment["QUIVER_PACKAGES_PATH"] ?? ".."

func quiverPackage(_ repository: String) -> Package.Dependency {
    let localURL = URL(fileURLWithPath: localQuiverPackagesRoot, relativeTo: packageDirectory)
        .appendingPathComponent(repository)
        .standardizedFileURL
    let manifestURL = localURL.appendingPathComponent("Package.swift")

    if FileManager.default.fileExists(atPath: manifestURL.path) {
        return .package(path: localURL.path)
    }

    return .package(url: "https://github.com/hironichu/\(repository).git", branch: "main")
}

let package = Package(
    name: "quiver-webtransport",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2),
    ],
    products: [
        .library(name: "WebTransport", targets: ["WebTransport"]),
    ],
    dependencies: [
        quiverPackage("quiver-http3"),
    ],
    targets: [
        .target(
            name: "WebTransport",
            dependencies: [
                .product(name: "HTTP3", package: "quiver-http3"),
            ],
            path: "Sources/WebTransport"
        ),
    ]
)
