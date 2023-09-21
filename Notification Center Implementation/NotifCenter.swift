//
//  NotifCenter.swift
//  Notification Center Implementation
//
//  Created by Ryan Forsyth on 2023-09-21.
//

import Combine
import Foundation

class NotifCenter {
    private init() {}
    static let `default` = NotifCenter()
    
    private var publishers = [NotifName : PassthroughSubject<Any?, Never>]()
    private var subscriptions = Set<AnyCancellable>()
    
    func publisher(for name: NotifName) -> AnyPublisher<Any?, Never> {
        if publishers[name] == nil {
            publishers[name] = PassthroughSubject<Any?, Never>()
        }
        return publishers[name]!.eraseToAnyPublisher()
    }
    
    func postNotification(_ name: NotifName, _ object: Any? = nil) {
        guard let publisher = publishers[name] else {
            return
        }
        publisher.send(object)
    }
    
    func addObserver(_ observer: AnyObject, selector: Selector, name: NotifName, object: Any?) {
        if publishers[name] == nil {
            publishers[name] = PassthroughSubject<Any?, Never>()
        }
        let publisher = publishers[name]!
        publisher.sink { optionalValue in
            _ = observer.perform(selector, with: object)
        }.store(in: &subscriptions)
    }
}

extension NotifCenter {
    struct NotifName: Hashable, RawRepresentable {
        var rawValue: String
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}
