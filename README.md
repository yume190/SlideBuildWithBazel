# Let's Build with Bazel

---

## 參照 [Slide](https://github.com/yume190/SlideBuildWithBazel/releases/download/slide/LetsBuild.zip)

 * 需求 macos 11

## 練習

 1. 導入 [Swift bazel](https://github.com/cgrindel/swift_bazel).
 2. 修正此 repo 的 Swift `Module Name`.
 3. 執行 [App](Slide/BUILD#L96)
 4. Done


## A

### Create `swift_deps.bzl`

```python
# Contents of swift_deps.bzl
def swift_dependencies():
    pass
```

> bazel run //:swift_update_pkgs

### Fix module name

 1. [Part 1](Part1_Build/BUILD)
 2. Part2
 3. Part3
 4. DL
 5. Util

```diff
swift_library(
    name = "Part1",
+    module_name = "Part1",
```

### Run mac App

> bazel run Slide