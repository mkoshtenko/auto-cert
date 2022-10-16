// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AutoCert",
    platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/drmohundro/SWXMLHash.git", from: "7.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "AutoCert",
            dependencies: [
                .product(name: "SWXMLHash", package: "SWXMLHash"),
            ]),
        .testTarget(
            name: "AutoCertTests",
            dependencies: ["AutoCert"]),
    ]
)
