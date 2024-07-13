import Foundation

@MainActor
final class UserViewModel: ObservableObject {
        
    private let service = APIService()
    @Published var users: [User] = []
    @Published var fetchTime: String?
    
    // Serial API calls using async/await
    func fetchUsersSerially() async {
        do {
            let startTime = Date()
            let user1 = try await service.fetchUser(id: 1)
            let user2 = try await service.fetchUser(id: 2)
            let user3 = try await service.fetchUser(id: 3)
            let endTime = Date()
            users = [user1, user2, user3]
            fetchTime = String(format: "%.2f", endTime.timeIntervalSince(startTime))
        }catch {
            print(error)
        }
    }
    
    // Parallel API calls using async/await
    func fetchUsersInParallel() async {
        do {
            let startTime = Date()
            async let user1 = service.fetchUser(id: 1)
            async let user2 = service.fetchUser(id: 2)
            async let user3 = service.fetchUser(id: 3)
            let finalUsers = try await [user1, user2, user3]
            
            let endTime = Date()
            self.users = finalUsers
            fetchTime = String(format: "%.2f", endTime.timeIntervalSince(startTime))
        }catch {
            print(error)
        }
    }
    
}
