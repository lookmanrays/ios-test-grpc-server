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
        ZStack {
            // Background color
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)

            // Content
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.blue)
                    .padding(.top, 20)

                Text("Hello, Norris!")
                    .font(.headline)
                    .padding(.top, 10)
                    .padding(.bottom, 20)

                Text(responseTest)
                    .font(.body)
                    .padding(.vertical, 10)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)

                Spacer() // Pushes everything above to the top

                // Button at the bottom
                Button(action: {
                    performGrpcRequest()
                }) {
                    Text("Request Chuck Norris Fact")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                }
                .padding(.bottom)
            }
        }
        .onAppear {
            performGrpcRequest()
        }
    }

    private func performGrpcRequest() {
        grpcClientManager.performRequest(message: "Norris") { response in
            DispatchQueue.main.async {
                if let reply = response {
                    self.responseTest = "Received \(reply)"
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

