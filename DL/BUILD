load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "DL",
    module_name = "DL",
    srcs = glob(["*.swift"]),
    testonly = False,
    deps = [
        "@swiftpkg_codeview//:Sources_CodeView",
        "//Util:Util_library"
    ],
    defines = None,
    visibility = [
        "//visibility:public",
    ],
)
