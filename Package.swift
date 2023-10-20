// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NNToast",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "NNToast", targets: ["NNToast"]),
        .library(name: "Toast", targets: ["Toast"]),
        .library(name: "HUD", targets: ["HUD"]),
    ],
    dependencies: [
        .package(url: "https://github.com/relatedcode/ProgressHUD.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/Zean-Technology-Co-Ltd/FoundationEx.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "NNToast",
            dependencies: [
              "Toast",
              "FoundationEx"
            ],
            resources: [
                .process("Resources")
            ]),
        .target(
          name: "Toast",
          dependencies: []
        ),
        .target(
          name: "HUD",
          dependencies: [
            "ProgressHUD"
          ],
          resources: [
              .process("Resources")
          ]
        ),
        .testTarget(
            name: "NNToastTests",
            dependencies: ["NNToast"]),
    ]
)
    
