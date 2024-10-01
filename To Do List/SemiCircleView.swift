//
//  SemiCircleView.swift
//  To Do List
//
//  Created by Гидаят Джанаева on 02.09.2024.
//

import UIKit

class SemiCircleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSemiCircle()
    }

    private func addSemiCircle() {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: 0, y: bounds.height / 2))
        
        path.addQuadCurve(to: CGPoint(x: bounds.width, y: bounds.height / 2), controlPoint: CGPoint(x: bounds.width / 2, y: bounds.height))
        
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.semiCircle.cgColor
        
        layer.sublayers?.forEach { $0.removeFromSuperlayer() } 
        layer.addSublayer(shapeLayer)
        
    }

}

