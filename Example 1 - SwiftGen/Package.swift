// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "SwiftGenExample",
    defaultLocalization: "en",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(
            name: "SwiftGenExampleLibrary",
            targets: ["SwiftGenExampleLibrary"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftGenExampleLibrary",
            exclude: [
                "Resources/swiftgen.yml"
            ],
            plugins: [
                "SwiftGenPlugin",
            ]
        ),
        // The plugin that generates build tool commands to invoke SwiftGen.
        .plugin(
            name: "SwiftGenPlugin",
            capability: .buildTool(),
            dependencies: [
                "SwiftGenBinary",
            ]
        ),
        // The vended executable that generates source files.
        .binaryTarget(
            name: "SwiftGenBinary",
            path: "Binaries/SwiftGenBinary.artifactbundle"
        ),
        .testTarget(
            name: "SwiftGenExampleLibraryTests",
            dependencies: [
                .init(stringLiteral: "SwiftGenExampleLibrary"),
            ]
        ),
    ]
)
