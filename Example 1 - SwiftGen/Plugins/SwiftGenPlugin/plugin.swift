import PackagePlugin
import Foundation

@main
struct SwiftGenPlugin: BuildToolPlugin {
    
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        // Look for a swiftgen.yml file at Sources/<Target>/Resources/swiftgen.yml
        let swiftGenConfigFile = context.package.directory.appending(["Sources", target.name, "Resources", "swiftgen.yml"])
        _ = try FileManager.default.attributesOfItem(atPath: swiftGenConfigFile.string)

        // This example configures `swiftgen` to write to a "SwiftGenOutputs" directory.
        let swiftGenOutputsDir = context.pluginWorkDirectory.appending("SwiftGenOutputs")
        try FileManager.default.createDirectory(atPath: swiftGenOutputsDir.string, withIntermediateDirectories: true)

        // Specify the input files
        let swiftGenStringsInputFile = context.package.directory.appending(["Sources", target.name, "Resources", "en.lproj"])
        let swiftGenAssetsInputFile = context.package.directory.appending(["Sources", target.name, "Resources", "Media.xcassets"])

        // Specify the output files
        let swiftGenStringsOutputFile = swiftGenOutputsDir.appending("Strings.swift")
        let swiftGenAssetsOutputFile = swiftGenOutputsDir.appending("Media.swift")

        var inputFiles = [Path]()
        var outputFiles = [Path]()
        if FileManager.default.fileExists(atPath: swiftGenStringsInputFile.string) {
            inputFiles.append(swiftGenStringsInputFile)
            outputFiles.append(swiftGenStringsOutputFile)
        }
        if FileManager.default.fileExists(atPath: swiftGenAssetsInputFile.string) {
            inputFiles.append(swiftGenAssetsInputFile)
            outputFiles.append(swiftGenAssetsOutputFile)
        }

        // Return a command to run `swiftgen` as a prebuild command. It will be run before
        // every build and generates source files into an output directory provided by the
        // build context.
        return [
//            .prebuildCommand(
//                displayName: "Running SwiftGen",
//                executable: try context.tool(named: "swiftgen").path,
//                arguments: [
//                    "config",
//                    "run",
//                    "--verbose",
//                    "--config", "\(swiftGenConfigFile)"
//                ],
//                environment: [
//                    "PROJECT_DIR": "\(context.package.directory)",
//                    "TARGET_NAME": "\(target.name)",
//                    "DERIVED_SOURCES_DIR": "\(swiftGenOutputsDir)",
//                ],
//                outputFilesDirectory: swiftGenOutputsDir
//            ),
            .buildCommand(
                displayName: "Running SwiftGen",
                executable: try context.tool(named: "swiftgen").path,
                arguments: [
                    "config",
                    "run",
                    "--verbose",
                    "--config", "\(swiftGenConfigFile)"
                ],
                environment: [
                    "PROJECT_DIR": "\(context.package.directory)",
                    "TARGET_NAME": "\(target.name)",
                    "DERIVED_SOURCES_DIR": "\(swiftGenOutputsDir)",
                ],
                inputFiles: inputFiles,
                outputFiles: outputFiles
            ),
        ]
    }
}
