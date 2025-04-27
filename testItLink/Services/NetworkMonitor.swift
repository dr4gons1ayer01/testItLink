//
//  NetworkMonitor.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import Foundation
import Network

protocol NetworkMonitoringProtocol {
    var isConnected: Bool { get }
    var onChange: ((Bool) -> Void)? { get set }
}

final class NetworkMonitor: NetworkMonitoringProtocol {
    
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    private (set) var isConnected: Bool = false
    
    var onChange: ((Bool) -> Void)?
    
    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            let status = path.status == .satisfied
            DispatchQueue.main.async {
                self.isConnected = status
                self.onChange?(status)
            }
        }
        monitor.start(queue: queue)
    }
}
