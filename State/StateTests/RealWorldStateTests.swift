//
//  RealWorldStateTests.swift
//  StateTests
//
//  Created by Naoyuki Kan on 2022/11/28.
//

import XCTest

class StateRealWorld: XCTestCase {
    func test() {
        print("Client: ロケーショントラッカーをスタートさせる")

        let tracker = LocationTracker()

        print()
        tracker.startTracking()

        print()
        tracker.pauseTracking(for: 2)

        print()
        tracker.makeCheckIn()

        print()
        tracker.findMyChildlen()

        print()
        tracker.stopTracking()
    }
}

class LocationTracker {
    // Stateをもつ
    private lazy var tracingState: TrackingState = EnabledTrackingState(tracker: self)

    func startTracking() {
        tracingState.startTracking()
    }

    func stopTracking() {
        tracingState.stopTracking()
    }

    func pauseTracking(for time: TimeInterval) {
        tracingState.pauseTracking(for: time)
    }

    func makeCheckIn() {
        tracingState.makeCheckIn()
    }

    func findMyChildlen() {
        tracingState.findMyChildlen()
    }

    func update(state: TrackingState) {
        self.tracingState = state
    }
}

protocol TrackingState {
    func startTracking()
    func stopTracking()
    func pauseTracking(for time: TimeInterval)

    func makeCheckIn()
    func findMyChildlen()
}

class EnabledTrackingState: TrackingState {
    private weak var tracker: LocationTracker?

    init(tracker: LocationTracker?) {
        self.tracker = tracker
    }

    func startTracking() {
        print("EnabledTrackinState: startTracingを受信")
        print("EnabledTrackinState: Locationをトラッキング...1")
        print("EnabledTrackinState: Locationをトラッキング...2")
        print("EnabledTrackinState: Locationをトラッキング...3")
    }

    func stopTracking() {
        print("EnabledTrackinState: stopTrackingを受信")
        print("EnabledTrackinState: disableに状態を変更")
        tracker?.update(state: DisabledTrackingState(tracker: tracker))
        tracker?.stopTracking()
    }

    func pauseTracking(for time: TimeInterval) {
        print("EnabledTrackinState: pauseTrackingを受信...\(time)秒ポーズ")
        print("EnabledTrackinState: disableに状態を変更")
        tracker?.update(state: DisabledTrackingState(tracker: tracker))
        tracker?.stopTracking()
    }

    func makeCheckIn() {
        print("EnabledTrackinState: 現在位置でcheck-in")
    }

    func findMyChildlen() {
        print("EnabledTrackinState: 子供を探す...")
    }
}

class DisabledTrackingState: TrackingState {
    private weak var tracker: LocationTracker?

    init(tracker: LocationTracker?) {
        self.tracker = tracker
    }

    func startTracking() {
        print("DisabledTrackingState: startTrackingを受信")
        print("DisabledTrackingState: enabledに状態を変更")
        tracker?.update(state: EnabledTrackingState(tracker: tracker))
    }

    func stopTracking() {
        print("DisabledTrackingState: stopTrackingを受信")
        print("DisabledTrackingState: 何もしない...")
    }

    func pauseTracking(for time: TimeInterval) {
        print("DisabledTrackingState: pauseTrackingを受信...\(time)秒ポーズ")

        for i in 0...Int(time) {
            print("DisabledTrackingState: \(i) ポーズ")
        }

        print("DisabledTrackingState: 時間経過完了")
        print("DisabledTrackingState: enabledに状態を変更")
        tracker?.update(state: EnabledTrackingState(tracker: tracker))
        tracker?.startTracking()
    }

    func makeCheckIn() {
        print("DisabledTrackingState: check-inを受信")
        print("DisabledTrackingState: enabledに状態を変更")
        tracker?.update(state: EnabledTrackingState(tracker: tracker))
        tracker?.makeCheckIn()
    }

    func findMyChildlen() {
        print("DisabledTrackingState: findMyChildlenを受信")
        print("DisabledTrackingState: enabledに状態を変更")
        tracker?.update(state: EnabledTrackingState(tracker: tracker))
        tracker?.findMyChildlen()
    }
}
