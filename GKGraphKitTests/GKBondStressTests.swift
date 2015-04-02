//
//  GKBondStressTests.swift
//  GKGraphKit
//
//  Created by Daniel Dahan on 2015-03-31.
//  Copyright (c) 2015 GraphKit, Inc. All rights reserved.
//

import XCTest
import GKGraphKit

class GKBondStressTests : XCTestCase, GKGraphDelegate {
	
	lazy var graph: GKGraph = GKGraph()
	
	var expectation: XCTestExpectation?
	
	// queue for drawing images
	private var queub1: dispatch_queue_t = {
		return dispatch_queue_create(("io.graphkit.BondStressTests.1" as NSString).UTF8String, nil)
	}()
	
	private var queue2: dispatch_queue_t = {
		return dispatch_queue_create(("io.graphkit.BondStressTests.2" as NSString).UTF8String, nil)
	}()
	
	private var queue3: dispatch_queue_t = {
		return dispatch_queue_create(("io.graphkit.BondStressTests.3" as NSString).UTF8String, nil)
	}()
	
	private var queue4: dispatch_queue_t = {
		return dispatch_queue_create(("io.graphkit.BondStressTests.4" as NSString).UTF8String, nil)
	}()
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testAll() {
		
		// Set the XCTest Class as the delegate.
		graph.delegate = self
		
		// Let's watch the changes in the Graph for the following Bond values.
		graph.watch(Bond: "B")
		
		var b1: GKBond?
		
		dispatch_async(queub1) {
			b1 = GKBond(type: "B")
			for i in 1...100 {
				let prop: String = String(i)
				b1!.addGroup(prop)
				b1!.addGroup("test")
				b1!.removeGroup("test")
				b1![prop] = i
			}
			
			dispatch_async(self.queue2) {
				for i in 1...50 {
					let prop: String = String(i)
					b1!.removeGroup(prop)
					b1!.addGroup("test")
					b1!.removeGroup("test")
					b1![prop] = nil
				}
				dispatch_async(self.queue3) {
					for i in 1...100 {
						let prop: String = String(i)
						b1!.addGroup(prop)
						b1!.addGroup("test")
						b1!.removeGroup("test")
						b1![prop] = i
					}
					
					dispatch_async(self.queue4) {
						for i in 1...50 {
							let prop: String = String(i)
							b1!.removeGroup(prop)
							b1!.addGroup("test")
							b1!.removeGroup("test")
							b1![prop] = nil
						}
						self.graph.save { (_, _) in }
					}
				}
			}
		}
		
		
		expectation = expectationWithDescription("Bond: Insert did not pass.")
		
		// Wait for the delegates to be executed.
		waitForExpectationsWithTimeout(30, handler: nil)
		
		b1!.delete()
		
		expectation = expectationWithDescription("Bond: Delete did not pass.")
		
		graph.save { (_, _) in }
		
		// Wait for the delegates to be executed.
		waitForExpectationsWithTimeout(30, handler: nil)
	}
	
	func testPerformanceExample() {
		self.measureBlock() {}
	}
	
	func graph(graph: GKGraph!, didInsertBond bond: GKBond!) {
		if 50 == bond.groups.count && 50 == bond.properties.count {
			expectation?.fulfill()
		}
	}
	
	func graph(graph: GKGraph!, didDeleteBond bond: GKBond!) {
		if 0 == bond.groups.count && 0 == bond.properties.count {
			expectation?.fulfill()
		}
	}
}
