load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_group")

apple_resource_group(
    name = "StructuredResource",
    structured_resources = glob([
        "Resource.bundle/**",
    ]),
    visibility = [
        "//visibility:private",
    ],
)

swift_library(
    name = "Util_library",
    srcs = glob(["*.swift"]),
    testonly = False,
    deps = [
        "@swiftpkg_codeview//:Sources_CodeView",
    ],
    data = [
        ":StructuredResource",
    ],
    defines = None,
    visibility = [
        "//visibility:public",
    ],
)
