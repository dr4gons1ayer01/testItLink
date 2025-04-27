//
//  DownloadManager.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import Foundation

enum DownloadError: Error {
    case invalidURL
    case networkError(Error)
    case invalidData
}

final class DownloadManager {
    
    static let shared = DownloadManager()
    
    private init() {}
    
    func loadFile(completion: @escaping (Result<[URL], Error>) -> Void) {
        guard let url = URL(string: "https://it-link.ru/test/images.txt") else {
            completion(.failure(DownloadError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(DownloadError.networkError(error)))
                return
            }
            guard let data = data, let text = String(data: data, encoding: .utf8) else {
                completion(.failure(DownloadError.invalidData))
                return
            }
            
            let urls = text.split(separator: "\n")
                .compactMap { URL(string: String($0)) }
                //.filter { $0.pathExtension.lowercased().matchesImage }
            
            completion(.success(urls))
            
        }.resume()
    }
}
