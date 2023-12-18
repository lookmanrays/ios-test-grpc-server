//
//  GrpcClientManager.swift
//  test-grpc
//
//  Created by Lukman Nuriakhmetov on 18.12.2023.
//

// GrpcClientManager.swift

import Foundation
import GRPC
import NIO

class GrpcClientManager {
    private let client: MyServiceNIOClient

    init() {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let channel = ClientConnection.insecure(group: group)
            .connect(host: "localhost", port: 7777) // Replace PORT with the actual server port

        client = MyServiceNIOClient(channel: channel)
    }

    func performRequest(message: String, completion: @escaping (String?) -> Void) {
        let request = MyRequest.with {
            $0.message = message
        }

        client.myMethod(request).response.whenComplete { result in
            switch result {
            case .success(let response):
                completion(response.reply)
            case .failure(let error):
                print("Error calling gRPC method: \(error)")
                completion(nil)
            }
        }
    }
}
