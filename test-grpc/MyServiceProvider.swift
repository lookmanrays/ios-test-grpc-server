//
//  MyServiceProvider.swift
//  test-grpc
//
//  Created by Lukman Nuriakhmetov on 18.12.2023.
//

import Foundation
import GRPC
import NIO
import NIOCore

// Assuming MyServiceMyMethodProvider is the protocol name generated from the .proto file.
// The actual name may differ based on the service definition in your .proto file.

class MyServiceImpl: MyServiceProvider {
    // Required property from the MyServiceProvider protocol
    var interceptors: MyServiceServerInterceptorFactoryProtocol? {
        return nil
    }

    // Implement the methods defined in the MyServiceProvider protocol
    func myMethod(request: MyRequest, context: StatusOnlyCallContext) -> EventLoopFuture<MyResponse> {
        let response = MyResponse.with {
            $0.reply = "Hello, \(request.message) 12345 Blah-blah-blah"
        }
        return context.eventLoop.makeSucceededFuture(response)
    }
}
