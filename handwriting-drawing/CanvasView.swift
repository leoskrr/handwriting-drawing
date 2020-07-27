//
//  CanvasView.swift
//  handwriting-drawing
//
//  Created by Leonardo Viana on 26/07/20.
//  Copyright © 2020 Leonardo Viana. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var lineColor: UIColor!
    var lineWidth: CGFloat!
    var path:UIBezierPath!
    var touchPoint: CGPoint!
    var startingPoint:CGPoint!
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        
        lineColor = UIColor(named: "viewColor")
        lineWidth = 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: touchPoint)
        
        startingPoint = touchPoint
        
        drawShapeLayer()
    }
    
    func drawShapeLayer(){
        let shapelayer = CAShapeLayer()
        shapelayer.path = path.cgPath
        shapelayer.strokeColor = lineColor.cgColor
        shapelayer.lineWidth = lineWidth
        shapelayer.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(shapelayer)
        self.setNeedsDisplay()
    }
    
    func clearCanvas(){
        path.removeAllPoints()
        
        self.layer.sublayers = nil
        self.setNeedsDisplay()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
