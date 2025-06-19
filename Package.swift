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
    dependencies: [
        .package(
            url: "https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker.git",
            .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .executableTarget(
            name: "AdvanceFilter",
            dependencies: ["SSDateTimePicker"],
            path: "AdvanceFilter"
        )
    ]
)
