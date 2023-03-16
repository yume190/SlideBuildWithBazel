
run:
	bazel run Slide

.PHONY: build
build:
	bazel build \
		//Part1_Build:Part1 \
		//Part2_Bazel:Part2 \
		//Part3_Bazel_iOS:Part3 \
		//Util:Util_library \
		//DL:DL 
