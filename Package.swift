// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AdvanceFilter",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .executable(
            name: "AdvanceFilter",
            targets: ["AdvanceFilter"]
        )
    ],
    targets: [
        .executableTarget(
            name: "AdvanceFilter",
            path: "AdvanceFilter"
        )
    ]
)
