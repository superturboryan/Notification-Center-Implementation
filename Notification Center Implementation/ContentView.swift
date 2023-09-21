//
//  ContentView.swift
//  Notification Center Implementation
//
//  Created by Ryan Forsyth on 2023-09-21.
//

import Combine
import SwiftUI

extension NotifCenter.NotifName {
    static let Increment1 = Self.init(rawValue: "increment1")
    static let Increment2 = Self.init(rawValue: "increment2")
    static let Decrement = Self.init(rawValue: "decrement")
}

struct ContentView: View {
    
    @State var counter1 = 0
    @State var counter2 = 0
    @State var decrement = 1
    
    var body: some View {
        VStack {
            Spacer()
            Text("Count: \(counter1)")
            Button("Increment by 1") {
                NotifCenter.default.postNotification(.Increment1)
            }
            Spacer()
            Text("Count: \(counter2)")
            Button("Increment by 2") {
                NotifCenter.default.postNotification(.Increment2)
            }
            Spacer()
            HStack {
                Text("Decrement amount:")
                Picker("\(decrement)", selection: $decrement) {
                    ForEach(1...5, id: \.self) { value in
                        Text("\(value)")
                    }
                }
            }
            Button("Decrement all by \(decrement)") {
                NotifCenter.default.postNotification(.Decrement, decrement)
            }
            Spacer()
        }
        .onReceive(NotifCenter.default.publisher(.Increment1), perform: { _ in
            counter1 += 1
        })
        .onReceive(NotifCenter.default.publisher(.Increment2), perform: { _ in
            counter2 += 2
        })
        .onReceive(NotifCenter.default.publisher(.Decrement), perform: { value in
            if let value = value as? Int {
                counter1 -= value
                counter2 -= value
            }
        })
    }
}

#Preview {
    ContentView()
}
