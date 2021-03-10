import Foundation

public final class NetworkService {

    private let resource: Resource
    private var successStatusCodes: Range<Int>

    private lazy var request: URLRequest = {
        var request = URLRequest(url: resource.baseURL)
        request.httpMethod = resource.httpMethod.rawValue
        request.allHTTPHeaderFields = resource.headers
        request.httpBody = resource.httpBody

        return request
    }()

    init(resource: Resource,
        successStatusCodes: Range<Int> = StatusCodes.success.value) {

        self.resource = resource
        self.successStatusCodes = successStatusCodes
    }

    private func createDataTask(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if error != nil {
                completion(.failure(.dataTaskError))

                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))

                return
            }

            guard let responseStatusCode = (response as? HTTPURLResponse)?.statusCode else {
                completion(.failure(.invalidResponseStatusCode))

                return
            }

            guard let successStatusCodes = self?.successStatusCodes,
                successStatusCodes.contains(responseStatusCode) else {
                completion(.failure(.failureStatusCode))

                return
            }

            completion(.success(data))
        }.resume()
    }

    public func makeRequest<Data: Decodable>(modelType: Data.Type,
                                             completion: @escaping (Result<Data, NetworkError>) -> ()) {

        createDataTask(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(modelType.self, from: data)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(.invalidJSONData))
                }
            case .failure(_):
                completion(.failure(.invalidJSONData))
            }
        }
    }

}

