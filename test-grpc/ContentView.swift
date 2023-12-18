//
//  ContentView.swift
//  test-grpc
//
//  Created by Lukman Nuriakhmetov on 18.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var responseTest: String = "Waiting for response..."
    let grpcClientManager = GrpcClientManager()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text(responseTest)
        }
        .padding()
        .onAppear {
            performGrpcRequest()
        }
    }

    private func performGrpcRequest() {
        grpcClientManager.performRequest(message: "Hello Server") { response in
            DispatchQueue.main.async {
                if let reply = response {
                    self.responseTest = "Received reply: \(reply)"
                } else {
                    self.responseTest = "Failed to receive reply"
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

