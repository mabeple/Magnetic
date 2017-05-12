//
//  SKMultilineLabelNode.swift
//  Magnetic
//
//  Created by Lasha Efremidze on 5/11/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import SpriteKit

open class SKMultilineLabelNode: SKNode {
    
    open var text: String? { didSet { update() } }
    
    open var fontName: String? { didSet { update() } }
    open var fontSize: CGFloat = 32 { didSet { update() } }
    open var fontColor: UIColor? { didSet { update() } }
    
    open var separator: String? { didSet { update() } }
    
    open var verticalAlignmentMode: SKLabelVerticalAlignmentMode = .baseline { didSet { update() } }
    open var horizontalAlignmentMode: SKLabelHorizontalAlignmentMode = .center { didSet { update() } }
    
    open var lineHeight: CGFloat? { didSet { update() } }
    
    open var width: CGFloat! { didSet { update() } }
    
    func update() {
        self.removeAllChildren()
        
        guard let text = text else { return }
        
        print(width)
        
        var sizingLabel = SKLabelNode()
        var stack = Stack<String>()
        
        let words = separator.map { text.components(separatedBy: $0) } ?? text.characters.map { String($0) }
        print(words)
//        for word in words {
//            sizingLabel.append(word)
//            print(sizingLabel.frame.width)
//            if sizingLabel.frame.width > width {
//                stack.add(toStack: word)
//                sizingLabel = SKLabelNode()
//            } else {
//                stack.add(toCurrent: word)
//            }
//        }
        
        print("---> 1")
        print(stack.values)
//        let lines = stack.values.map { $0.joined(separator: "") }
        let lines = words
        print(lines)
        for (index, line) in lines.enumerated() {
            let label = SKLabelNode(fontNamed: fontName)
            label.text = line
            label.fontSize = fontSize
            label.fontColor = fontColor
            label.verticalAlignmentMode = verticalAlignmentMode
            label.horizontalAlignmentMode = horizontalAlignmentMode
            let y = (CGFloat(index) - (CGFloat(lines.count) / 2) + 0.5) * -(lineHeight ?? fontSize)
            label.position = CGPoint(x: 0, y: y)
            self.addChild(label)
        }
    }
    
}

private struct Stack<U> {
    typealias T = (stack: [[U]], current: [U])
    private var value: T
    var values: [[U]] {
        return value.stack + [value.current]
    }
    init() {
        self.value = (stack: [], current: [])
    }
    mutating func add(toStack element: U) {
        self.value = (stack: value.stack + [value.current], current: [element])
    }
    mutating func add(toCurrent element: U) {
        self.value = (stack: value.stack, current: value.current + [element])
    }
}

private extension SKLabelNode {
    func append(_ text: String) {
        self.text = (self.text ?? "") + text
    }
}
