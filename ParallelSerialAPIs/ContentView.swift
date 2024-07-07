import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        VStack {
            if viewModel.users.isEmpty {
                ProgressView("Fetching users...")
            }else {
                if let fetchTime = viewModel.fetchTime {
                    Text(fetchTime)
                        .font(.title2)
                }
                List(viewModel.users, id: \.id) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .listStyle(.plain)
            }
        }
        .padding()
        .task {
            viewModel.fetchTime = nil
//            await viewModel.fetchUsersSerially()
            await viewModel.fetchUsersInParallel()
        }
    }
}

#Preview {
    ContentView()
}
