## Notification Center Implementation 📣

Reimplementing NotificationCenter using Combine 🚜 
- Underlying publishers are **PassthroughSubjects**, only exposed as AnyPublishers
- `publisher(for:)` method performs **type erasure**, converts PassthroughSubject to **AnyPublisher**
- Accessed through singleton `default` static instance, `init()` is **private**

### Public Interface
```swift
class NotifCenter {
    static let `default`: NotifCenter.NotifCenter
    func publisher(for name: NotifName) -> AnyPublisher<Any?, Never>
    func postNotification(_ name: NotifName, _ object: Any? = nil)
    func addObserver(_ observer: AnyObject, selector: Selector, name: NotifName, object: Any?)
}
```

### Implementation
  
https://github.com/superturboryan/Notification-Center-Implementation/blob/2d686f0fefe52b5387bab2bf7387059e5fc825c1/Notification%20Center%20Implementation/NotifCenter.swift#L11-L42  

### Usage

- [SwiftUI example](Notification-Center-Implementation/blob/main/Notification%20Center%20Implementation/ContentView.swift)
