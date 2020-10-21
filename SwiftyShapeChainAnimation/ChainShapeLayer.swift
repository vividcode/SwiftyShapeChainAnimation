//
//  ChainShapeLayer.swift
//  SwiftyShapeChainAnimation
//
//  Created by Admin on 10/21/20.
//

import Foundation
import UIKit

class ChainShapeLayer: CAShapeLayer, CAAnimationDelegate
{
    static let stopIndex = 1001
    var chain: [Shape] = []
    var shouldReturnToFirstShape: Bool = false
    var isInfinite: Bool = false
    
    func chainAnimations(shapes: [Shape], bShouldReturnToFirstState: Bool = false, bIsInfinite: Bool = false)
    {
        if (shapes.count < 2)
        {
            fatalError("Chain must have at least 2 animations.")
        }
        
        self.chain = shapes
        let fromValue = self.path

        let idx = 0
        let toValue = self.chain[idx + 1].createPath(inRect: self.bounds)
        
        self.shouldReturnToFirstShape = bShouldReturnToFirstState
        self.isInfinite = bIsInfinite
        self.animatePath(idx: idx, fromValue: fromValue as Any, toValue: toValue)
    }
    
    func animatePath(idx: Int, fromValue: Any, toValue: Any)
    {
        let pathAnim = CABasicAnimation(keyPath: "path")
        
        pathAnim.fromValue = fromValue
        pathAnim.toValue = toValue
        pathAnim.duration = 0.6
        pathAnim.fillMode = .forwards
        pathAnim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        pathAnim.isRemovedOnCompletion = false
        pathAnim.delegate = self
        pathAnim.setValue(idx, forKey: "index")
        
        self.add(pathAnim, forKey: "pathAnim")
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        guard let idx = anim.value(forKey: "index") as? Int
        else
        {
            fatalError("Invalid animation shape")
        }
        
        if (idx < self.chain.count - 1)
        {
            let fromValue = self.presentation()?.path!
            let toValue = self.chain[idx + 1].createPath(inRect: self.bounds)
            
            self.animatePath(idx: idx + 1, fromValue: fromValue as Any, toValue: toValue)
        }
        else
        {
            if (idx == ChainShapeLayer.stopIndex)
            {
                return
            }
            else if (self.shouldReturnToFirstShape)
            {
                let fromValue = self.presentation()?.path!
                let toValue = self.chain[0].createPath(inRect: self.bounds)
                
                self.animatePath(idx: ChainShapeLayer.stopIndex, fromValue: fromValue as Any, toValue: toValue)
                self.chain.removeAll()
            }
            else if (self.isInfinite)
            {
                let fromValue = self.presentation()?.path!
                let toValue = self.chain[0].createPath(inRect: self.bounds)
                
                self.animatePath(idx: 0, fromValue: fromValue as Any, toValue: toValue)
            }
        }
    }
}

