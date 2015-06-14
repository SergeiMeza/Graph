/**
* Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
*
* You should have received a copy of the GNU Affero General Public License
* along with this program located at the root of the software package
* in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
*/

import XCTest
import GraphKit

class ListTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testListInt() {
		let l: List<Int> = List<Int>()
		
		l.insertAtFront(1)
		l.insertAtFront(2)
		l.insertAtFront(3)
		
		XCTAssert(3 == l.count, "Count incorrect, got \(l.count).")
		
		XCTAssert(3 == l.front, "Front incorrect, got \(l.front)")
		XCTAssert(1 == l.back, "Back incorrect, got \(l.back)")
		
		l.insertAtBack(5)
		l.insertAtBack(6)
		l.insertAtBack(7)
		
		XCTAssert(6 == l.count, "Count incorrect, got \(l.count).")
		
		XCTAssert(3 == l.front, "Front incorrect, got \(l.front)")
		XCTAssert(7 == l.back, "Back incorrect, got \(l.back)")
		
		l.resetToFront()
		XCTAssert(l.front == l.cursor, "Current incorrect, got \(l.cursor)")
		
		println(l)
		
//		XCTAssert(2 == l.next!, "Next incorrect, got \(l.next!)")
//		XCTAssert(1 == l.next?, "Next incorrect, got \(l.next)")
//		XCTAssert(5 == l.next?, "Next incorrect, got \(l.next)")
//		XCTAssert(6 == l.next?, "Next incorrect, got \(l.next)")
//		XCTAssert(7 == l.next?, "Next incorrect, got \(l.next)")
	}
	
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measureBlock() {
			// Put the code you want to measure the time of here.
		}
	}
	
}
