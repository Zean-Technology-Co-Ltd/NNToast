// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NNToast",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "NNToast", targets: ["NNToast"]),
        .library(name: "Toast", targets: ["Toast"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Zean-Technology-Co-Ltd/FoundationEx.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "NNToast",
            dependencies: [
              "FoundationEx",
              "Toast"
            ],
            resources: [
                .process("Resources")
            ]),
        .target(
          name: "Toast",
          dependencies: []
        ),
        .testTarget(
            name: "NNToastTests",
            dependencies: ["NNToast"]),
    ]
)
    
