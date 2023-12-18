//
//  test_grpcApp.swift
//  test-grpc
//
//  Created by Lukman Nuriakhmetov on 18.12.2023.
//

// test_grpcApp.swift

import SwiftUI

@main
struct test_grpcApp: App {
    let grpcServerManager = GrpcServerManager()

    init() {
        grpcServerManager.startServer()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
