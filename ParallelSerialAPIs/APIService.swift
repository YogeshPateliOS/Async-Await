import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case error(_ error: Error)
}

final class APIService {

    func fetchUser(id: Int) async throws -> User {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)") else { throw NetworkError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        // Artificial delay to simulate network latency
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
        return try JSONDecoder().decode(User.self, from: data)
    }
    
}
