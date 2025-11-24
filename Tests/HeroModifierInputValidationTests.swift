// The MIT License (MIT)
//
// Copyright (c) 2016 Luke Zhao <me@lkzhao.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#if canImport(UIKit)
import XCTest
import Hero

class HeroModifierInputValidationTests: XCTestCase {

  // MARK: - Position Modifier Tests

  func testPositionWithValidValues() {
    let modifier = HeroModifier.position(CGPoint(x: 100, y: 200))
    let state: HeroTargetState = [modifier]
    XCTAssertEqual(state.position, CGPoint(x: 100, y: 200))
  }

  func testPositionWithInvalidValues() {
    let nanModifier = HeroModifier.position(CGPoint(x: CGFloat.nan, y: 200))
    let nanState: HeroTargetState = [nanModifier]
    XCTAssertNil(nanState.position, "Position should not be set when value is NaN")

    let infModifier = HeroModifier.position(CGPoint(x: CGFloat.infinity, y: 200))
    let infState: HeroTargetState = [infModifier]
    XCTAssertNil(infState.position, "Position should not be set when value is Infinity")
  }

  // MARK: - Size Modifier Tests

  func testSizeWithValidValues() {
    let modifier = HeroModifier.size(CGSize(width: 100, height: 200))
    let state: HeroTargetState = [modifier]
    XCTAssertEqual(state.size, CGSize(width: 100, height: 200))
  }

  func testSizeWithInvalidValues() {
    let nanModifier = HeroModifier.size(CGSize(width: CGFloat.nan, height: 200))
    let nanState: HeroTargetState = [nanModifier]
    XCTAssertNil(nanState.size, "Size should not be set when value is NaN")

    let infModifier = HeroModifier.size(CGSize(width: 100, height: CGFloat.infinity))
    let infState: HeroTargetState = [infModifier]
    XCTAssertNil(infState.size, "Size should not be set when value is Infinity")
  }

  // MARK: - Perspective Modifier Tests

  func testPerspectiveWithValidValue() {
    let modifier = HeroModifier.perspective(500)
    let state: HeroTargetState = [modifier]
    XCTAssertNotNil(state.transform, "Transform should be set with valid perspective")
    if let m34 = state.transform?.m34 {
      XCTAssertEqual(Double(m34), 1.0 / -500.0, accuracy: 0.0001)
    }
  }

  func testPerspectiveWithInvalidValues() {
    let zeroModifier = HeroModifier.perspective(0)
    let zeroState: HeroTargetState = [zeroModifier]
    XCTAssertNil(zeroState.transform, "Transform should not be set when perspective is zero")

    let nanModifier = HeroModifier.perspective(CGFloat.nan)
    let nanState: HeroTargetState = [nanModifier]
    XCTAssertNil(nanState.transform, "Transform should not be set when perspective is NaN")

    let infModifier = HeroModifier.perspective(CGFloat.infinity)
    let infState: HeroTargetState = [infModifier]
    XCTAssertNil(infState.transform, "Transform should not be set when perspective is Infinity")
  }

  // MARK: - Scale Modifier Tests

  func testScaleWithValidValues() {
    let modifier = HeroModifier.scale(x: 2, y: 3, z: 1)
    let state: HeroTargetState = [modifier]
    XCTAssertNotNil(state.transform, "Transform should be set with valid scale values")
  }

  func testScaleWithInvalidValues() {
    let nanModifier = HeroModifier.scale(x: CGFloat.nan, y: 1, z: 1)
    let nanState: HeroTargetState = [nanModifier]
    XCTAssertNil(nanState.transform, "Transform should not be set when value is NaN")

    let infModifier = HeroModifier.scale(x: 1, y: CGFloat.infinity, z: 1)
    let infState: HeroTargetState = [infModifier]
    XCTAssertNil(infState.transform, "Transform should not be set when value is Infinity")
  }

  // MARK: - Translate Modifier Tests

  func testTranslateWithValidValues() {
    let modifier = HeroModifier.translate(x: 50, y: 100, z: 0)
    let state: HeroTargetState = [modifier]
    XCTAssertNotNil(state.transform, "Transform should be set with valid translate values")
  }

  func testTranslateWithInvalidValues() {
    let nanModifier = HeroModifier.translate(x: 50, y: 100, z: CGFloat.nan)
    let nanState: HeroTargetState = [nanModifier]
    XCTAssertNil(nanState.transform, "Transform should not be set when value is NaN")

    let infModifier = HeroModifier.translate(x: CGFloat.infinity, y: 100, z: 0)
    let infState: HeroTargetState = [infModifier]
    XCTAssertNil(infState.transform, "Transform should not be set when value is Infinity")
  }

  // MARK: - Rotate Modifier Tests

  func testRotateWithValidValues() {
    let modifier = HeroModifier.rotate(x: 0, y: 0, z: .pi)
    let state: HeroTargetState = [modifier]
    XCTAssertNotNil(state.transform, "Transform should be set with valid rotate values")
  }

  func testRotateWithInvalidValues() {
    let nanModifier = HeroModifier.rotate(x: CGFloat.nan, y: 0, z: 0)
    let nanState: HeroTargetState = [nanModifier]
    XCTAssertNil(nanState.transform, "Transform should not be set when value is NaN")

    let infModifier = HeroModifier.rotate(x: 0, y: 0, z: CGFloat.infinity)
    let infState: HeroTargetState = [infModifier]
    XCTAssertNil(infState.transform, "Transform should not be set when value is Infinity")
  }

  // MARK: - Duration Modifier Tests

  func testDurationWithValidValues() {
    let validModifier = HeroModifier.duration(0.5)
    let validState: HeroTargetState = [validModifier]
    XCTAssertEqual(validState.duration, 0.5)

    let infModifier = HeroModifier.duration(.infinity)
    let infState: HeroTargetState = [infModifier]
    XCTAssertEqual(infState.duration, .infinity, "Infinity should be allowed for duration")
  }

  func testDurationWithInvalidValues() {
    let nanModifier = HeroModifier.duration(TimeInterval.nan)
    let nanState: HeroTargetState = [nanModifier]
    XCTAssertNil(nanState.duration, "Duration should not be set when value is NaN")

    let negativeModifier = HeroModifier.duration(-1.0)
    let negativeState: HeroTargetState = [negativeModifier]
    XCTAssertNil(negativeState.duration, "Duration should not be set when value is negative")
  }

  // MARK: - Delay Modifier Tests

  func testDelayWithValidValue() {
    let modifier = HeroModifier.delay(0.3)
    let state: HeroTargetState = [modifier]
    XCTAssertEqual(state.delay, 0.3)
  }

  func testDelayWithInvalidValues() {
    let nanModifier = HeroModifier.delay(TimeInterval.nan)
    let nanState: HeroTargetState = [nanModifier]
    XCTAssertNil(nanState.delay, "Delay should not be set when value is NaN")

    let infModifier = HeroModifier.delay(TimeInterval.infinity)
    let infState: HeroTargetState = [infModifier]
    XCTAssertNil(infState.delay, "Delay should not be set when value is Infinity")

    let negativeModifier = HeroModifier.delay(-0.5)
    let negativeState: HeroTargetState = [negativeModifier]
    XCTAssertNil(negativeState.delay, "Delay should not be set when value is negative")
  }

  // MARK: - Arc Modifier Tests

  func testArcWithValidIntensity() {
    let modifier = HeroModifier.arc(intensity: 1)
    let state: HeroTargetState = [modifier]
    XCTAssertEqual(state.arc, 1)
  }

  func testArcWithInvalidValues() {
    let nanModifier = HeroModifier.arc(intensity: CGFloat.nan)
    let nanState: HeroTargetState = [nanModifier]
    XCTAssertNil(nanState.arc, "Arc should not be set when intensity is NaN")

    let infModifier = HeroModifier.arc(intensity: CGFloat.infinity)
    let infState: HeroTargetState = [infModifier]
    XCTAssertNil(infState.arc, "Arc should not be set when intensity is Infinity")
  }
}
#endif
