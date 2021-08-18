//
//  CanvasView.swift
//  MyMagicalHand
//
//  Created by sookim on 2021/08/13.
//

import UIKit

class CanvasView: UIView {

    private var lines = [[CGPoint]]()

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(15)
        context.setLineCap(.round)
        context.setLineJoin(.round)

        lines.forEach { (line) in
            for (i, point) in line.enumerated() {
                if i == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
        }

        context.strokePath()
    }

    // MARK: - 사용자 터치시작
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }

    // MARK: - 사용자 터치이동인식
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }

    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }

}
