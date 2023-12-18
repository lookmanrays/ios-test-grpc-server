// GrpcServerManager.swift

import Foundation
import GRPC
import NIO

class GrpcServerManager {
    private var server: GRPC.Server?
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    private let lock = NSLock()

    func startServer() {
        DispatchQueue.global(qos: .background).async {
            let provider = MyServiceImpl()

            do {
                let newServer = try Server.insecure(group: self.group)
                    .withServiceProviders([provider])
                    .bind(host: "localhost", port: 7777)
                    .wait()

                self.lock.lock()
                self.server = newServer
                self.lock.unlock()

                if let port = newServer.channel.localAddress?.port {
                    print("Server started on port \(port)")
                } else {
                    print("Server not started")
                }
            } catch {
                print("Failed to start server: \(error)")
            }
        }
    }

    func stopServer() {
        lock.lock()
        defer { lock.unlock() }

        guard let server = server else { return }

        DispatchQueue.global(qos: .background).async {
            do {
                try server.close().wait()
                try self.group.syncShutdownGracefully()
                print("Server stopped successfully")
            } catch {
                print("Failed to stop server: \(error)")
            }
        }
    }
}

