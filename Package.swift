// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "espeak-ng",
    products: [
        .library(name: "libespeak-ng", targets: ["libespeak-ng"]),
        .library(name: "espeak-ng-data", targets: ["data"]),
    ],
    targets: [
        .target(
            name: "libsonic",
            exclude: ["_repo"],
            sources: ["src"],  // Adjust path as needed
            cSettings: []
        ),
        .target(
            name: "libucd",
            sources: ["src"],  // Adjust path as needed
            cSettings: []
        ),
        .target(
            name: "data",
            resources: [
                .copy("espeak-ng-data"),
                .copy("phsource"),
                .copy("dictsource"),
            ]
        ),
        .target(
            name: "libespeak-ng",
            dependencies: ["libsonic", "libucd"],
            exclude: ["_repo"],
            sources: ["src"],  // Adjust path as needed
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("src/include"),  // Adjusted from _repo/src/include
                .define("ESPEAK_NG_API", to: ""),
                .define("N_PATH_HOME", to: "1024"),
            ]
        ),
    ]
)