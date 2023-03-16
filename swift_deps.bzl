load("@cgrindel_swift_bazel//swiftpkg:defs.bzl", "swift_package")

# Contents of swift_deps.bzl
def swift_dependencies():
    # version: 0.0.1
    swift_package(
        name = "swiftpkg_codeview",
        commit = "b830b33ca711dd0d19382ecf5a5e86febdf0ba7a",
        dependencies_index = "@//:swift_deps_index.json",
        remote = "https://github.com/yume190/CodeView",
    )

    # version: 1.0.1
    swift_package(
        name = "swiftpkg_pathkit",
        commit = "3bfd2737b700b9a36565a8c94f4ad2b050a5e574",
        dependencies_index = "@//:swift_deps_index.json",
        remote = "https://github.com/kylef/PathKit",
    )

    # version: 0.10.1
    swift_package(
        name = "swiftpkg_spectre",
        commit = "26cc5e9ae0947092c7139ef7ba612e34646086c7",
        dependencies_index = "@//:swift_deps_index.json",
        remote = "https://github.com/kylef/Spectre.git",
    )

    # version: 1.2.0
    swift_package(
        name = "swiftpkg_swiftterm",
        commit = "55e7cdbeb3f41c80cce7b8a29ce9d17e214b2e77",
        dependencies_index = "@//:swift_deps_index.json",
        remote = "https://github.com/migueldeicaza/SwiftTerm",
    )
