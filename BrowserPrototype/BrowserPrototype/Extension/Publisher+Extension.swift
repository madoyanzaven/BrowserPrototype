//
//  Publisher+Extension.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Combine
import Foundation

extension Publisher {
    func sinkOnMain(receiveCompletion: @escaping (Subscribers.Completion<Self.Failure>) -> Void, receiveValue: @escaping (Self.Output) -> Void) -> AnyCancellable {
        receiveOnMain().sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
    }
    
    func receiveOnMain(options: RunLoop.SchedulerOptions? = nil) -> Combine.Publishers.ReceiveOn<Self, RunLoop> {
        receive(on: RunLoop.main, options: options)
    }
}

extension Publisher where Self.Failure == Never {
    func sinkOnMain(receiveValue: @escaping (Self.Output) -> Void) -> Combine.AnyCancellable {
        receiveOnMain().sink(receiveValue: receiveValue)
    }
}
