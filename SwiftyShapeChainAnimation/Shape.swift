//
//  Shape.swift
//  SwiftyShapeChainAnimation
//
//  Created by Admin on 10/21/20.
//

import Foundation
import UIKit

enum Shape: Int
{
    case triangle
    case rectangle
    case pentagon
    case hexagon
    case heptagon
    case octagon
    case nanogon
    case decagon
    case circle
    
    func createPolygon(edges: Int, rect: CGRect)->CGPath
    {
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        let path = UIBezierPath()
        path.fill()
        let extra: Int = Double(edges) != Double(Int(edges)) ? 1 : 0

        for i in 0..<Int(edges) + extra {
            let angle = (Double(i) * (360.0 / Double(edges))) * Double.pi / 180
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            if i == 0
            {
                path.move(to: pt)
            }
            else
            {
                path.addLine(to: pt)
            }
        }
        
        path.close()
        return path.cgPath
    }

    
    func createPath(inRect: CGRect)->CGPath
    {
        switch self
        {
            case .circle:
                return UIBezierPath(ovalIn: inRect).cgPath
            case .rectangle:
                return UIBezierPath(rect: inRect).cgPath
            case .triangle:
                return self.createPolygon(edges: 3, rect: inRect)
            case .pentagon:
                return self.createPolygon(edges: 5, rect: inRect)
            case .hexagon:
                return self.createPolygon(edges: 6, rect: inRect)
            case .heptagon:
                return self.createPolygon(edges: 7, rect: inRect)
            case .octagon:
                return self.createPolygon(edges: 8, rect: inRect)
            case .nanogon:
                return self.createPolygon(edges: 9, rect: inRect)
            case .decagon:
                return self.createPolygon(edges: 10, rect: inRect)
        }
    }
}
