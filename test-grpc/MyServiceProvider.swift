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
    
    func myMethod(request: MyRequest, context: StatusOnlyCallContext) -> EventLoopFuture<MyResponse> {
        // Create a promise that you'll return
        let promise = context.eventLoop.makePromise(of: MyResponse.self)
        
        // Example GET Request
        performGetRequest { data, error in
            guard let data = data, error == nil else {
                promise.fail(error ?? GRPCStatus(code: .internalError, message: "Failed to perform GET request"))
                return
            }
            
            // Process data and create a response
            let responseString = self.parseResponseData(data) ?? ""
            let response = MyResponse.with {
                $0.reply = "\(request.message)'s Response: \n \(responseString)"
            }
            
            promise.succeed(response)
        }
        
        // Return the future result of the promise
        return promise.futureResult
    }
    
    private func performGetRequest(completion: @escaping (Data?, Error?) -> Void) {
        // Define the URL for the GET request
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            completion(nil, GRPCStatus(code: .internalError, message: "Invalid URL"))
            return
        }
        
        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, error)
        }
        
        // Start the task
        task.resume()
    }
    
    private func parseResponseData(_ data: Data) -> String? {
        let decoder = JSONDecoder()
        do {
            let apiResponse = try decoder.decode(ApiResponse.self, from: data)
            return apiResponse.value // This is the "value" field from the JSON
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

struct ApiResponse: Decodable {
    let iconUrl: String
    let id: String
    let url: String
    let value: String

    // CodingKeys enum maps the JSON field names to your struct's properties
    enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case id
        case url
        case value
    }
}

