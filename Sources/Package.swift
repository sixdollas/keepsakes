// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KeepsakesApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .iOSApplication(
            name: "Keepsakes",
            targets: ["KeepsakesApp"],
            bundleIdentifier: "com.yourname.keepsakes",
            teamIdentifier: "YOUR_TEAM_ID",
            displayVersion: "1.0",
            bundleVersion: "1",
            iconAssetName: "AppIcon",
            accentColorAssetName: "AccentColor",
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .portraitUpsideDown,
                .landscapeLeft,
                .landscapeRight
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "KeepsakesApp",
            path: "Sources"
        )
    ]
)