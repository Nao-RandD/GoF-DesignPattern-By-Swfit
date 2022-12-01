//
//  TemplateMethodRealWorldTests.swift
//  TemplateMethodTests
//
//  Created by Naoyuki Kan on 2022/11/30.
//

import XCTest
import AVFoundation
import CoreLocation
import Photos

class TemplateMethodRealWorld: XCTestCase {
    func testTemplateMethodReal() {
        let exp: XCTestExpectation = expectation(description: "戻ってくるまで待つ！")
        let accessors = [CameraAccessor(), MicroPhoneAccessor(), PhotoLibraryAccessor()]

        for accessor in accessors {
            accessor.requestAccessIfNeeded { status in
                print("\(accessor.description)のステータスは\(status)")
                if let _ = accessor as? PhotoLibraryAccessor {
                    exp.fulfill()
                }
            }
        }
        wait(for: [exp], timeout: 30)
    }
}

class PermissionAccessor: CustomStringConvertible {
    typealias Completion = (Bool) -> ()

    func requestAccessIfNeeded(_ completion: @escaping Completion) {
        guard !hasAccess() else { completion(true); return }

        willReceiveAccess()

        requestAccess { status in
            status ? self.didReceiveAccess() : self.didReceiveAccess()

            completion(status)
        }
    }

    func requestAccess(_ completion: @escaping Completion) {
        fatalError("Should be overridden")
    }

    func hasAccess() -> Bool {
        fatalError("Should be overridden")
    }

    var description: String { return "PermissionAccessor" }

    /// Hooks
    func willReceiveAccess() {}
    func didReceiveAccess() {}
    func didRejectAccess() {}
}

class CameraAccessor: PermissionAccessor {
    override func requestAccess(_ completion: @escaping Completion) {
        AVCaptureDevice.requestAccess(for: .video) { status in
            return completion(status)
        }
    }

    override func hasAccess() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }

    override var description: String { return "Camera" }
}

class MicroPhoneAccessor: PermissionAccessor {
    override func requestAccess(_ completion: @escaping Completion) {
        AVAudioSession.sharedInstance().requestRecordPermission { status in
            completion(status)
        }
    }

    override func hasAccess() -> Bool {
        return AVAudioSession.sharedInstance().recordPermission == .granted
    }

    override var description: String { return "Audio" }
}

class PhotoLibraryAccessor: PermissionAccessor {
    override func requestAccess(_ completion: @escaping Completion) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            completion(status == .authorized)
        }
    }

    override func hasAccess() -> Bool {
        return PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized

    }

    override var description: String { return "Phonto" }

    override func didReceiveAccess() {
        /// ここでPhotoLibraryの許可状態としている利用者を図る処理を入れる
        print("PhotoLibrary Accessor: アクセス許可を得た。Analyticsに送信...")
    }

    override func didRejectAccess() {
        /// ここでPhotoLibraryの拒絶状態としている利用者を測る処理を入れる
        print("PhotoLibrary Accessor: アクセス許可が得られなかった。Analyticsに送信...")
    }
}
