//
//  File.swift
//  
//
//  Created by Frank Pham on 15.07.22.
//

import Foundation
import Core
import Combine

class RewardViewModel: GamifyKitBaseVM {
    let service: RewardService
    let progressVM: ProgressViewModel
    @Published var rewards: [String] = []
    @Published var rewardProgression: Float = 0
    @Published var reward: Reward?
    
    var cancellables = Set<AnyCancellable>()
    var cancellable: AnyCancellable?
    
    init(progressVM: ProgressViewModel = ProgressViewModel()) {
        self.service = RewardService(service: progressVM.service)
        self.progressVM = progressVM
        load()
        //        registerSubscriber()
        registerProgressSubscriber()
        //        registerProgress()
    }
    
    func load() {
        service.load {
            self.reward = $0.first
        }
    }
    
    private func registerProgress() {
        service.listenToPublisher { result in
            self.objectWillChange.send()
            self.rewardProgression = result
        }
    }
    private func registerProgressSubscriber() {
//        cancellable = Publishers.Zip(
//            progressVM.service.unlockPublisher,
//            progressVM.service.publisher
//        ).sink(
//            receiveCompletion: { print($0) },
//            receiveValue: { [weak self] isUnlocked, progression in
//                guard let self = self,
//                      let reward = self.reward else {
//                    return
//                }
//
//                if isUnlocked {
//                    self.service.unlockReward(reward: reward) { isUnlock in
//                        print("isUnlock: \(isUnlock) : \(reward)")
//                    }
//                }
//
//                self.rewardProgression = progression
//                self.objectWillChange.send()
//            })
        
        progressVM.service.unlockPublisher.sink { result in
            switch result {
            case .finished:
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                break
            }
        } receiveValue: { isUnlocked in
            guard isUnlocked,
                  let reward = self.reward else {
                return
            }
            self.service.unlockReward(reward: reward) { isUnlock in
                print("isUnlock: \(isUnlock) : \(reward)")
                self.objectWillChange.send()
            }
        }.store(in: &cancellables)
        
        guard let pub = GKServiceManager.shared.requestPublisher(type: ProgressService.serviceIdentifier) else {
            print("Publisher Empty")

            return
        }
        
        pub.sink { print($0) } receiveValue: { result in
            self.rewardProgression = result
            self.objectWillChange.send()
            
            print("New publish Manager: \(result)")
        }.store(in: &cancellables)

//        progressVM.service.publisher.sink { result in
//            switch result {
//            case .finished:
//                break
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//                break
//            }
//        } receiveValue: { [weak self] receivedValue in
//            self?.rewardProgression = receivedValue
//            self?.objectWillChange.send()
//
//            print("New publish: \(receivedValue)")
//        } .store(in: &cancellables)
        
        
        
        
        
        //        progressVM.$progress.sink { result in
        //            switch result {
        //            case .finished:
        //                break
        //            case .failure(let error):
        //                print("Error: \(error.localizedDescription)")
        //                break
        //            }
        //        } receiveValue: { [weak self] receivedValue in
        //            guard let rewardProgression = receivedValue else {
        //                print("Guard \(receivedValue)")
        //                return
        //            }
        //            self?.rewardProgression = rewardProgression.percent
        //            self?.objectWillChange.send()
        //            print("New publish: \(rewardProgression)")
        //        } .store(in: &cancellables)
    }
    
    private func registerSubscriber() {
        service.$publisher.sink { result in
            switch result {
            case .finished:
                break
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                break
            }
        } receiveValue: { [weak self] receivedValue in
            self?.rewards = receivedValue
            self?.objectWillChange.send()
        } .store(in: &cancellables)
    }
}
