//
//  UserViewModel.swift
//  APIGeneric
//
//  Created by Yogesh Patel on 21/04/23.
//

import Foundation

protocol UserServices: AnyObject {
    func reloadData() // Data Binding - PROTOCOL (View and ViewModel Communication)
}

class UserViewModel {

    var users: [UserModel] = [] {
        didSet {
            self.userDelegate?.reloadData()
        }
    }
    private let manager = APIManager()
    weak var userDelegate: UserServices?

    // @MainActor -> DispatchQueue.Main.async
    @MainActor func fetchUsers() {
        Task { // @MainActor in 
            do {
                let userResponseArray: [UserModel] = try await manager.request(url: userURL)
                    self.users = userResponseArray
            }catch {
                print(error)
            }
        }

    }


//    func fetchUsers() {
//        manager.fetchUsers(
//            modelType: [UserModel].self) { result in
//                switch result {
//                case .success(let userResponseArray):
//                    self.users = userResponseArray
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }

}
