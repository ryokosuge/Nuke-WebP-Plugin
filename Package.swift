// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Nuke-WebP-Plugin",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13),
        ],
    products: [
        .library(name: "NukeWebPPlugin", targets: ["NukeWebPPlugin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kean/Nuke.git", .upToNextMajor(from: "9.2.3")),
    ],
    targets: [
        .target(
            name: "NukeWebPPlugin",
            dependencies: [
                "NukeWebPPluginC",
                .product(name: "Nuke", package: "Nuke"),
                ],
            path: "Source",
            exclude: [
                "libwebp",
                "WebP",
            ],
            sources: [
                "WebPImage.swift",
                "Extensions",
            ]
        ),
        .target(
            name: "NukeWebPPluginC",
            path: "Source",
            exclude: [
                "WebPImage.swift",
                "Extensions",
                "libwebp/man",
                "libwebp/gradle",
                "libwebp/examples",
                "libwebp/swig",
                "libwebp/cmake/",
                "libwebp/webp_js",
                "libwebp/extras",
                "libwebp/imageio",
            ],
            publicHeadersPath: "WebP",
            cSettings: [
                .headerSearchPath("libwebp"),
            ],
            cxxSettings: [
                .headerSearchPath("libwebp"),
            ]
        ),
    ]
)