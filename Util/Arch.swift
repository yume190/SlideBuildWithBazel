#if arch(x86_64)
public let arch = "x86_64"
#elseif arch(arm64)
public let arch = "arm64"
#else
public let arch = "x86_64"
#endif
