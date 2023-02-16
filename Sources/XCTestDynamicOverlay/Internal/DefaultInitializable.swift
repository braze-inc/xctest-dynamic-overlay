protocol _DefaultInitializable {
  init()
}

extension Array: _DefaultInitializable {}
extension Bool: _DefaultInitializable {}
extension Character: _DefaultInitializable { init() { self.init(" ") } }
extension Dictionary: _DefaultInitializable {}
extension Double: _DefaultInitializable {}
extension Float: _DefaultInitializable {}
extension Int: _DefaultInitializable {}
extension Int8: _DefaultInitializable {}
extension Int16: _DefaultInitializable {}
extension Int32: _DefaultInitializable {}
extension Int64: _DefaultInitializable {}
extension Set: _DefaultInitializable {}
extension String: _DefaultInitializable {}
extension Substring: _DefaultInitializable {}
extension UInt: _DefaultInitializable {}
extension UInt8: _DefaultInitializable {}
extension UInt16: _DefaultInitializable {}
extension UInt32: _DefaultInitializable {}
extension UInt64: _DefaultInitializable {}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension AsyncStream: _DefaultInitializable {
  init() { self.init { $0.finish() } }
}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension AsyncThrowingStream: _DefaultInitializable where Failure == Error {
  init() { self.init { $0.finish(throwing: CancellationError()) } }
}

#if canImport(Foundation)
  import Foundation
  #if canImport(FoundationNetworking)
    import FoundationNetworking
  #endif

  extension Data: _DefaultInitializable {}
  extension Date: _DefaultInitializable {}
  extension Decimal: _DefaultInitializable {}
  extension UUID: _DefaultInitializable {}
  extension URL: _DefaultInitializable { init() { self.init(string: "/")! } }
#endif
