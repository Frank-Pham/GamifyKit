//
//  File.swift
//  
//
//  Created by Frank Pham on 11.07.22.
//

import Foundation
import Core
import CoreData
import Combine

public class ProgressViewModel: GamifyKitBaseVM {
    @Published var progress: Progress?
    @Published public var progressArr: [Progress] = []
    let progressPublisher = PassthroughSubject<Float, Error>()
    
    internal let service: ProgressService
    var cancellables = Set<AnyCancellable>()
    
    init(service: ProgressService = ProgressService()) {
        self.service = service
        load()
    }
    
    func load() {
        service.load {
            self.progressArr = $0
            self.progress = $0.first
        }
        
//        service.publisher.sink { result in
//            switch result {
//            case .finished:
//                break
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        } receiveValue: { result in
//            self.progress?.percent = result
//            self.objectWillChange.send()
//        }.store(in: &cancellables)

    }
    
    func addProgress() {
        guard let progress = progress else { return }
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            progress.percent += 20
        //            self.objectWillChange.send()
        //        }
        self.service.addProgress(progress: progress) {
            self.objectWillChange.send()
            self.progressPublisher.send(progress.percent)
        }
    }
    
    
    
    func reset() {
        guard let progress = progress else { return }
        
        service.reset(progress: progress) {
            objectWillChange.send()
            self.progressPublisher.send(progress.percent)
        }
    }
    
    func delete() {
        guard let progress = progress else { return }
        
        self.service.delete(progress: progress) {
            objectWillChange.send()
        }
    }
}
