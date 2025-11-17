// swift-tools-version: 5.7
import PackageDescription
let package = Package(
    name: "DynamicIslandDemoProject",
    platforms: [
        .iOS(.v16)
    ],
    dependencies: [
        .package(
            url: "https://github.com/OneSignal/OneSignal-XCFramework.git",
            from: "5.0.0"
        )
    ],
    targets: [
        .target(
            name: "DynamicIslandDemoProject",
            dependencies: [
                .product(name: "OneSignalFramework", package: "OneSignal-XCFramework"),
                .product(name: "OneSignalLiveActivities", package: "OneSignal-XCFramework")
            ]
        )
    ]
)
