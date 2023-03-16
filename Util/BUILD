load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "Util_library",
    srcs = glob(["*.swift"]),
    testonly = False,
    deps = [
        "@swiftpkg_codeview//:Sources_CodeView",
    ],
    defines = None,
    visibility = [
        "//visibility:public",
    ],
)
