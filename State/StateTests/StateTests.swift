//
//  StateTests.swift
//  StateTests
//
//  Created by naoyuki.kan on 2022/11/27.
//

import XCTest
@testable import State

class Context {
    private var state: State
    
    init(_ state: State){
        self.state = state
        
    }
    
    func transitionTo(state: State) {
        print("Stateの状態が\(state)に変更されました")
        self.state = state
        self.state.update(context: self)
    }
    
    func request1() {
        state.handle1()
    }
    
    func request2() {
        state.handle2()
    }
}

protocol State: AnyObject {
    func update(context: Context)
    
    func handle1()
    func handle2()
}

class  BaseState: State {
    private(set) weak var context: Context?
    
    func update(context: Context) {
        self.context = context
    }
    
    func handle1() {}
    
    func handle2() {}
}

class ConcreteStateA: BaseState {
    override func handle1() {
        print("ConcreteStateAはrequest1を呼び出します")
        print("ConcreteStateAはContextのStateの状態を変更します")
        context?.transitionTo(state: ConcreteStateB())
    }
    
    override func handle2() {
        print("ConcreteStateBはrequest2を呼び出します")
    }
}

class ConcreteStateB: BaseState {
    override func handle1() {
        print("ConcreteStateBはrequest1を呼び出します")
    }
    
    override func handle2() {
        print("ConcreteStateBはrequest2を呼び出します")
        print("ConcreteStateBはContextのStateの状態を変更します")
        context?.transitionTo(state: ConcreteStateA())
    }
}

class StateConceptual: XCTestCase {
    func test() {
        let context = Context(ConcreteStateA())
        context.request1()
        context.request2()
        context.request1()
        context.request2()
    }
}
