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
        .library(
            name: "ExampleAppDependencies",
            targets: ["ExampleAppDependencies"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/marksands/BetterCodable", exact: "0.4.0"),
    ],
    targets: [
        .target(
            name: "ExampleAppDependencies",
            dependencies: [
                "SwiftGenExampleLibrary",
                "BetterCodable",
            ]
        ),
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
