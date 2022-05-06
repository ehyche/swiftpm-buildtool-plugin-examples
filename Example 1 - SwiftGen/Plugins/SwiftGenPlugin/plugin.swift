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

        // Return a command to run `swiftgen` as a prebuild command. It will be run before
        // every build and generates source files into an output directory provided by the
        // build context.
        return [
            .prebuildCommand(
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
                outputFilesDirectory: swiftGenOutputsDir
            )
        ]
    }
}
