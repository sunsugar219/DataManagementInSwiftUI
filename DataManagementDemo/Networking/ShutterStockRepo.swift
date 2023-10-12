//
//  ShutterStockRepo.swift
//  DataManagementDemo
//
//  Created by Zsuzsa Hodi on 2023. 01. 17..
//

import Foundation
import Combine

protocol ShutterStockRepoProtocol {
    func loadImages(searchExpression: String, completionHandler: @escaping (Result<[STImage], Error>) -> Void)
}

struct ShutterStockRepo: ShutterStockRepoProtocol {
    let session: URLSession!
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init() {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        self.session = session
    }

    func loadImages(searchExpression: String, completionHandler: @escaping (Result<[STImage], Error>) -> Void) {
        let endpoint = ShutterStockSearchCall(with: searchExpression)
        do {
            let getTask = try URLSession.shared.dataTask(with: endpoint.urlRequest()) { (data, response, error) in
                if let error {
                    print("Error: \(error)")
                    completionHandler(.failure(error))
                } else if let data {
                    do {
                        print(String(data: data, encoding: .utf8) ?? "")

                        let responseData = try JSONDecoder().decode(STResponse.self, from: data)
                        completionHandler(.success(responseData.data))
                    } catch {
                        completionHandler(.failure(DataConversionError()))
                    }
                }
            }
            getTask.resume()
        } catch {
            completionHandler(.failure(ValueIsMissingError()))
        }
    }
}
//
//// MARK: - Endpoint
//
struct ShutterStockSearchCall: APICall {
    var path: String

    var method: String {
        "GET"
    }

    var headers: [String : String]? {
        [
            "Accept": "application/json",
            "Authorization": Constants.stAuth,
            "Accept-Encoding": "gzip, deflate, br",
            "Connection": "keep-alive",
            "User-Agent": "ShutterstockWorkspace/1.1.18"
        ]
    }

    func body() throws -> Data? {
        nil
    }

    init(with query: String) {
        var components = URLComponents()
        components.scheme = Constants.baseUrlScheme
        components.host = Constants.baseUrlHost
        components.path = "/v2/images/search"
        components.queryItems = [URLQueryItem(name: "query", value: query)]
        if let url = components.url?.absoluteString  {
            self.path = url
        } else {
            self.path = ""
        }
    }
}
