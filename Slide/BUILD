# Generated using Bazelize 0.0.4 - https://github.com/XCodeBazelize/Bazelize

load("@build_bazel_rules_apple//apple:macos.bzl", "macos_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@plist//build-system/ios-utils:plist_fragment.bzl", "plist_fragment")
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

filegroup(
    name = "Assets",
    srcs = glob([
        "Assets.xcassets/**",
        "Preview Content/Preview Assets.xcassets/**",
    ]),
    visibility = [
        "//visibility:private",
    ],
)

swift_library(
    name = "Slide_swift",
    srcs = glob(["*.swift"]),
    testonly = False,
    deps = [
        "@swiftpkg_codeview//:Sources_CodeView",
        "//Util:Util_library",
        "//Part1_Build:Part1",
        "//Part2_Bazel:Part2",
        "//Part3_Bazel_iOS:Part3",
        "//DL:DL",
    ],
    data = [
        ":Assets",
        ":StructuredResource",
    ],
    defines = None,
    visibility = [
        "//visibility:private",
    ],
)

alias(
    name = "Slide_library",
    actual = "Slide_swift",
    visibility = [
        "//visibility:public",
    ],
)

plist_fragment(
    name = "plist_auto",
    extension = "plist",
    template = '''
    <!--<key><key>NSHumanReadableCopyright</key></key>-->
    <!--<key></key>-->
    ''',
    visibility = [
        "//visibility:private",
    ],
)

plist_fragment(
    name = "plist_default",
    extension = "plist",
    template = '''
    <key>CFBundleDevelopmentRegion</key>
    <string>$(DEVELOPMENT_LANGUAGE)</string>
    <key>CFBundleExecutable</key>
    <string>$(EXECUTABLE_NAME)</string>
    <key>CFBundleIdentifier</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleName</key>
    <string>$(PRODUCT_NAME)</string>
    <key>CFBundlePackageType</key>
    <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    ''',
    visibility = [
        "//visibility:private",
    ],
)

macos_application(
    name = "Slide",
    bundle_id = "com.yume190.CodeView",
    minimum_os_version = "11.0",
    infoplists = [
        ":plist_auto",
        ":plist_default",
    ],
    deps = [
        ":Slide_library",
    ],
    visibility = [
        "//visibility:public",
    ],
)