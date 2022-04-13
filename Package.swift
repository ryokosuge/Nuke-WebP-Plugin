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
        .package(url: "https://github.com/kean/Nuke.git", from: "10.0.0"),
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
                "libwebp/src/Makefile.am",
                "libwebp/src/dec/Makefile.am",
                "libwebp/src/demux/libwebpdemux.rc",
                "libwebp/src/demux/libwebpdemux.pc.in",
                "libwebp/src/demux/Makefile.am",
                "libwebp/src/dsp/Makefile.am",
                "libwebp/src/enc/Makefile.am",
                "libwebp/src/libwebp.pc.in",
                "libwebp/src/libwebp.rc",
                "libwebp/src/libwebpdecoder.pc.in",
                "libwebp/src/libwebpdecoder.rc",
                "libwebp/src/mux/libwebpmux.pc.in",
                "libwebp/src/mux/libwebpmux.rc",
                "libwebp/src/mux/Makefile.am",
                "libwebp/src/utils/Makefile.am",
                "libwebp/ChangeLog",
                "libwebp/doc/README",
                "libwebp/doc/template.html",
                "libwebp/doc/TODO",
                "libwebp/doc/webp-container-spec.txt",
                "libwebp/doc/webp-lossless-bitstream-spec.txt",
                "libwebp/Makefile.am",
                "libwebp/makefile.unix",
                "libwebp/m4/ax_pthread.m4",
                "libwebp/PATENTS",
                "libwebp/README.mux",
                "libwebp/codereview.settings",
                "libwebp/gradlew.bat",
                "libwebp/configure.ac",
                "libwebp/AUTHORS",
                "libwebp/README",
                "libwebp/gradlew",
                "libwebp/autogen.sh",
                "libwebp/Makefile.vc",
                "libwebp/gradle.properties",
                "libwebp/NEWS",
                "libwebp/Android.mk",
                "libwebp/COPYING",
                "libwebp/build.gradle",
                "libwebp/iosbuild.sh",
                "libwebp/CMakeLists.txt",
                "libwebp/README.webp_js",
            ],
            publicHeadersPath: "WebP",
            cSettings: [
                .headerSearchPath("libwebp"),
                .headerSearchPath("libwebp/src"),
            ],
            cxxSettings: [
                .headerSearchPath("libwebp"),
                .headerSearchPath("libwebp/src"),
            ]
        ),
    ]
)
