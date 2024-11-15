// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "espeak-ng",
    products: [
        .library(name: "libespeak-ng", targets: ["libespeak-ng"]),
        .library(name: "espeak-ng-data", targets: ["data"]),
    ],
    dependencies: [
        .package(url: "https://github.com/echan00/espeak-ng.git", branch: "main")
    ],
    targets: [
        .target(
            name: "libsonic",
            dependencies: [
                .product(name: "espeak-ng", package: "espeak-ng")
            ],
            exclude: ["_repo"],
            cSettings: []
        ),
        .target(
            name: "libucd",
            dependencies: [
                .product(name: "espeak-ng", package: "espeak-ng")
            ],
            cSettings: []
        ),
        .target(
            name: "data",
            dependencies: [
                .product(name: "espeak-ng", package: "espeak-ng")
            ],
            resources: [
                .copy("espeak-ng-data"),
                .copy("phsource"),
                .copy("dictsource"),
            ]
        ),
        .target(
            name: "libespeak-ng",
            dependencies: [
                .product(name: "espeak-ng", package: "espeak-ng"),
                "libsonic",
                "libucd"
            ],
            exclude: ["_repo"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("_repo/src/include"),
                .define("ESPEAK_NG_API", to: ""),
                .define("N_PATH_HOME", to: "1024"),
            ]
        ),
    ]
)