// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "SmartOrbit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SmartOrbit",
            targets: ["SmartOrbit"]),
    ],
    targets: [
        .target(
            name: "SmartOrbit",
            path: ".",
            sources: ["Models", "ViewModels", "Views", "App"]),
    ]
)
