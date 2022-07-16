//
//  File.swift
//  
//
//  Created by Frank Pham on 15.07.22.
//

import Foundation
import Core
import Combine

public class RewardService: GamifyKitService {
    public typealias gamifyKitType = Reward
    public static let serviceIdentifier = RewardService.self
    
    @Published var publisher: [String] = []
    let dao: RewardDAO
    let service: ProgressService
    var cancellables = Set<AnyCancellable>()
    
    init(dao: RewardDAO = RewardDAO(), service: ProgressService) {
        self.dao = dao
        self.service = service
        publishDummyData()
    }
    
    public func load(completion: @escaping([gamifyKitType]) -> Void) {
        dao.load(request: dao.request) { result in
            switch result {
            case .success(var data):
                print("Progress load() \(data)")
                
                if data.isEmpty {
                    let newEntry = Reward(context: self.dao.manager.viewContext)
                    newEntry.name = "Beginner Badge"
                    newEntry.isUnlocked = false
                    data.append(newEntry)
                }
                
                completion(data)
            case .failure(let error):
                print("Service Error load() \(error)")
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func listenToPublisher(completion: @escaping (Float) -> Void) {
        service.publisher.sink { result in
            switch result {
            case .finished:
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                break
            }
        } receiveValue: { [weak self] receivedValue in
            print("New publish: \(receivedValue)")
            completion(receivedValue)

        } .store(in: &cancellables)
    }
    
    func unlockReward(reward: gamifyKitType, completion: (Bool) -> Void) {
        reward.isUnlocked = true
        dao.update {
            completion(reward.isUnlocked)
        }
    }
    private func publishDummyData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.publisher = ["badge1", "badge2", "badge3"]
        }
    }
}
