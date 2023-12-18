//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: test.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `MyServiceClient`, then call methods of this protocol to make API calls.
internal protocol MyServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: MyServiceClientInterceptorFactoryProtocol? { get }

  func myMethod(
    _ request: MyRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<MyRequest, MyResponse>
}

extension MyServiceClientProtocol {
  internal var serviceName: String {
    return "MyService"
  }

  /// Unary call to MyMethod
  ///
  /// - Parameters:
  ///   - request: Request to send to MyMethod.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func myMethod(
    _ request: MyRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<MyRequest, MyResponse> {
    return self.makeUnaryCall(
      path: MyServiceClientMetadata.Methods.myMethod.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMyMethodInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension MyServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "MyServiceNIOClient")
internal final class MyServiceClient: MyServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: MyServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: MyServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the MyService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: MyServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct MyServiceNIOClient: MyServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: MyServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the MyService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: MyServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol MyServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: MyServiceClientInterceptorFactoryProtocol? { get }

  func makeMyMethodCall(
    _ request: MyRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<MyRequest, MyResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension MyServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return MyServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: MyServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeMyMethodCall(
    _ request: MyRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<MyRequest, MyResponse> {
    return self.makeAsyncUnaryCall(
      path: MyServiceClientMetadata.Methods.myMethod.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMyMethodInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension MyServiceAsyncClientProtocol {
  internal func myMethod(
    _ request: MyRequest,
    callOptions: CallOptions? = nil
  ) async throws -> MyResponse {
    return try await self.performAsyncUnaryCall(
      path: MyServiceClientMetadata.Methods.myMethod.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMyMethodInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct MyServiceAsyncClient: MyServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: MyServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: MyServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol MyServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'myMethod'.
  func makeMyMethodInterceptors() -> [ClientInterceptor<MyRequest, MyResponse>]
}

internal enum MyServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "MyService",
    fullName: "MyService",
    methods: [
      MyServiceClientMetadata.Methods.myMethod,
    ]
  )

  internal enum Methods {
    internal static let myMethod = GRPCMethodDescriptor(
      name: "MyMethod",
      path: "/MyService/MyMethod",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol MyServiceProvider: CallHandlerProvider {
  var interceptors: MyServiceServerInterceptorFactoryProtocol? { get }

  func myMethod(request: MyRequest, context: StatusOnlyCallContext) -> EventLoopFuture<MyResponse>
}

extension MyServiceProvider {
  internal var serviceName: Substring {
    return MyServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "MyMethod":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<MyRequest>(),
        responseSerializer: ProtobufSerializer<MyResponse>(),
        interceptors: self.interceptors?.makeMyMethodInterceptors() ?? [],
        userFunction: self.myMethod(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol MyServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: MyServiceServerInterceptorFactoryProtocol? { get }

  func myMethod(
    request: MyRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> MyResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension MyServiceAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return MyServiceServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return MyServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: MyServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "MyMethod":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<MyRequest>(),
        responseSerializer: ProtobufSerializer<MyResponse>(),
        interceptors: self.interceptors?.makeMyMethodInterceptors() ?? [],
        wrapping: { try await self.myMethod(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

internal protocol MyServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'myMethod'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMyMethodInterceptors() -> [ServerInterceptor<MyRequest, MyResponse>]
}

internal enum MyServiceServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "MyService",
    fullName: "MyService",
    methods: [
      MyServiceServerMetadata.Methods.myMethod,
    ]
  )

  internal enum Methods {
    internal static let myMethod = GRPCMethodDescriptor(
      name: "MyMethod",
      path: "/MyService/MyMethod",
      type: GRPCCallType.unary
    )
  }
}
