# Generated using Bazelize 0.0.4 - https://github.com/XCodeBazelize/Bazelize

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "cgrindel_swift_bazel",
    sha256 = "434cf75cbd6c3f9bd4b750a7f9c9b5bc2cc662922d24862d559abf6ecaff8b72",
    urls = [
        "https://github.com/cgrindel/swift_bazel/releases/download/v0.3.2/swift_bazel.v0.3.2.tar.gz",
    ],
)

load("@cgrindel_swift_bazel//:deps.bzl", "swift_bazel_dependencies")

swift_bazel_dependencies()

load("@cgrindel_bazel_starlib//:deps.bzl", "bazel_starlib_dependencies")

bazel_starlib_dependencies()

# MARK: - Gazelle

# gazelle:repo bazel_gazelle

http_archive(
    name = "bazel_skylib_gazelle_plugin",
    sha256 = "04182233284fcb6545d36b94248fe28186b4d9d574c4131d6a511d5aeb278c46",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.4.0/bazel-skylib-gazelle-plugin-1.4.0.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.4.0/bazel-skylib-gazelle-plugin-1.4.0.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("@bazel_skylib_gazelle_plugin//:workspace.bzl", "bazel_skylib_gazelle_plugin_workspace")
load("@cgrindel_swift_bazel//:go_deps.bzl", "swift_bazel_go_dependencies")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

# Declare Go dependencies before calling go_rules_dependencies.
swift_bazel_go_dependencies()

bazel_skylib_gazelle_plugin_workspace()

go_rules_dependencies()

go_register_toolchains(version = "1.19.1")

gazelle_dependencies()

load("//:swift_deps.bzl", "swift_dependencies")

# gazelle:repository_macro swift_deps.bzl%swift_dependencies
swift_dependencies()

# rules_apple
http_archive(
    name = "build_bazel_rules_apple",
    sha256 = "3e2c7ae0ddd181c4053b6491dad1d01ae29011bc322ca87eea45957c76d3a0c3",
    url = "https://github.com/bazelbuild/rules_apple/releases/download/2.1.0/rules_apple.2.1.0.tar.gz",
)

load(
    "@build_bazel_rules_apple//apple:repositories.bzl",
    "apple_rules_dependencies",
)

apple_rules_dependencies()

load(
    "@build_bazel_apple_support//lib:repositories.bzl",
    "apple_support_dependencies",
)

apple_support_dependencies()

# rules_swift
http_archive(
    name = "build_bazel_rules_swift",
    sha256 = "d25a3f11829d321e0afb78b17a06902321c27b83376b31e3481f0869c28e1660",
    url = "https://github.com/bazelbuild/rules_swift/releases/download/1.6.0/rules_swift.1.6.0.tar.gz",
)

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:extras.bzl",
    "swift_rules_extra_dependencies",
)

swift_rules_extra_dependencies()

# rules_xcodeproj
http_archive(
    name = "com_github_buildbuddy_io_rules_xcodeproj",
    sha256 = "d02932255ba3ffaab1859e44528c69988e93fa353fa349243e1ef5054bd1ba80",
    url = "https://github.com/buildbuddy-io/rules_xcodeproj/releases/download/1.2.0/release.tar.gz",
)

load(
    "@com_github_buildbuddy_io_rules_xcodeproj//xcodeproj:repositories.bzl",
    "xcodeproj_rules_dependencies",
)

xcodeproj_rules_dependencies()

git_repository(
    name = "plist",
    commit = "259ca0a5d77833728c18fa6365285559ce8cc0bf",
    remote = "https://github.com/imWildCat/MinimalBazelFrameworkDemo",
)

http_archive(
    name = "rules_apple_linker",
    sha256 = "a8aecd86d9c63677a8f1a3849c52c05d4aed1d1d9c209db2904f53f8973731d4",
    strip_prefix = "rules_apple_linker-0.3.0",
    url = "https://github.com/keith/rules_apple_linker/archive/refs/tags/0.3.0.tar.gz",
)

load("@rules_apple_linker//:deps.bzl", "rules_apple_linker_deps")

rules_apple_linker_deps()