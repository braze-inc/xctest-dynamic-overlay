@_transparent
@inline(__always)
@usableFromInline
@available(macOS 10.14, iOS 12.0, watchOS 5.0, tvOS 12.0, *)
func runtimeWarn(
  _ message: @autoclosure () -> String,
  file: StaticString? = nil,
  line: UInt? = nil
) {
  #if DEBUG && canImport(os)
    os_log(
      .fault,
      dso: dso,
      log: OSLog(subsystem: "com.apple.runtime-issues", category: "XCTestDynamicOverlay"),
      "%@",
      message()
    )
  #endif
}

#if DEBUG && canImport(os)
  import os

  // NB: Xcode runtime warnings offer a much better experience than traditional assertions and
  //     breakpoints, but Apple provides no means of creating custom runtime warnings ourselves.
  //     To work around this, we hook into SwiftUI's runtime issue delivery mechanism, instead.
  //
  // Feedback filed: https://gist.github.com/stephencelis/a8d06383ed6ccde3e5ef5d1b3ad52bbc
  @usableFromInline
  let dso = { () -> UnsafeMutableRawPointer in
    let count = _dyld_image_count()
    for i in 0..<count {
      if let name = _dyld_get_image_name(i) {
        let swiftString = String(cString: name)
        if swiftString.hasSuffix("/SwiftUI") {
          if let header = _dyld_get_image_header(i) {
            return UnsafeMutableRawPointer(mutating: UnsafeRawPointer(header))
          }
        }
      }
    }
    return UnsafeMutableRawPointer(mutating: #dsohandle)
  }()
#endif
