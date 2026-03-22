//
//  ContentViewTests.swift
//  ReceiptTextsTests
//

import XCTest
import SwiftUI
@testable import ReceiptTexts

final class ContentViewTests: XCTestCase {

    // MARK: - Color(hex:) extension

    func testHexColor_sixDigit() {
        // #52B788 → r=82, g=183, b=136
        let color = Color(hex: "52B788")
        let resolved = NSColor(color)
        guard let srgb = resolved.usingColorSpace(.sRGB) else {
            XCTFail("Could not convert to sRGB")
            return
        }
        XCTAssertEqual(srgb.redComponent, 82 / 255, accuracy: 0.01)
        XCTAssertEqual(srgb.greenComponent, 183 / 255, accuracy: 0.01)
        XCTAssertEqual(srgb.blueComponent, 136 / 255, accuracy: 0.01)
        XCTAssertEqual(srgb.alphaComponent, 1.0, accuracy: 0.01)
    }

    func testHexColor_threeDigit() {
        // #FFF → white
        let color = Color(hex: "FFF")
        let resolved = NSColor(color)
        guard let srgb = resolved.usingColorSpace(.sRGB) else {
            XCTFail("Could not convert to sRGB")
            return
        }
        XCTAssertEqual(srgb.redComponent, 1.0, accuracy: 0.01)
        XCTAssertEqual(srgb.greenComponent, 1.0, accuracy: 0.01)
        XCTAssertEqual(srgb.blueComponent, 1.0, accuracy: 0.01)
    }

    func testHexColor_eightDigit_withAlpha() {
        // #80FFFFFF → ~50% opacity white
        let color = Color(hex: "80FFFFFF")
        let resolved = NSColor(color)
        guard let srgb = resolved.usingColorSpace(.sRGB) else {
            XCTFail("Could not convert to sRGB")
            return
        }
        XCTAssertEqual(srgb.alphaComponent, 128 / 255, accuracy: 0.01)
        XCTAssertEqual(srgb.redComponent, 1.0, accuracy: 0.01)
    }

    func testHexColor_withHashPrefix() {
        // Leading # should be stripped — both should produce equal colors
        let withHash = NSColor(Color(hex: "#52B788")).usingColorSpace(.sRGB)
        let withoutHash = NSColor(Color(hex: "52B788")).usingColorSpace(.sRGB)
        XCTAssertNotNil(withHash)
        XCTAssertNotNil(withoutHash)
        XCTAssertEqual(withHash!.redComponent, withoutHash!.redComponent, accuracy: 0.01)
        XCTAssertEqual(withHash!.greenComponent, withoutHash!.greenComponent, accuracy: 0.01)
        XCTAssertEqual(withHash!.blueComponent, withoutHash!.blueComponent, accuracy: 0.01)
    }

    func testHexColor_black() {
        let color = Color(hex: "0A0A0A")
        let resolved = NSColor(color)
        guard let srgb = resolved.usingColorSpace(.sRGB) else {
            XCTFail("Could not convert to sRGB")
            return
        }
        XCTAssertEqual(srgb.redComponent, 10 / 255, accuracy: 0.01)
        XCTAssertEqual(srgb.greenComponent, 10 / 255, accuracy: 0.01)
        XCTAssertEqual(srgb.blueComponent, 10 / 255, accuracy: 0.01)
    }

    // MARK: - ContentView state

    func testContentView_rendersWithoutCrashing() {
        let view = ContentView()
        let host = NSHostingController(rootView: view)
        XCTAssertNotNil(host.view)
    }

    // MARK: - FeaturePill

    func testFeaturePill_rendersWithoutCrashing() {
        let pill = FeaturePill(icon: "lock.shield.fill", text: "100% Private — stays on your device")
        let host = NSHostingController(rootView: pill)
        XCTAssertNotNil(host.view)
    }

    func testFeaturePill_acceptsArbitraryIconAndText() {
        let pill = FeaturePill(icon: "star.fill", text: "Test feature text")
        let host = NSHostingController(rootView: pill)
        XCTAssertNotNil(host.view)
    }
}
