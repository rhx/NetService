// swift-tools-version:5.9

import PackageDescription

var package = Package(
    name: "NetService",
    products: [
        .library(name: "NetService", targets: ["NetService"]),
        .executable(name: "dns-sd", targets: ["dns-sd"])
    ],
    targets: [
        .target(name: "NetService", dependencies: ["Cdns_sd"]),
        .executableTarget(name: "dns-sd", dependencies: ["NetService"]),
        .testTarget(name: "NetServiceTests", dependencies: ["NetService"]),
    ]
)

#if !os(Linux)
    package.targets.append(
        .systemLibrary(name: "Cdns_sd"))
#else
    package.targets.append(
        .systemLibrary(name: "Cdns_sd",
                       pkgConfig: "avahi-compat-libdns_sd",
                       providers: [
                           .apt(["libavahi-compat-libdnssd-dev"])
                       ]))
#endif
