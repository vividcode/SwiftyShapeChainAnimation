//
//  ViewController.swift
//  SwiftyShapeChainAnimation
//
//  Created by Admin on 10/21/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var experimentalView: UIView!
    var shapes: [Shape] = [.triangle, .rectangle, .pentagon, .hexagon, .heptagon, .octagon, .nanogon, .decagon, .circle]
    var chainShapeLayer: ChainShapeLayer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews()
    {
        guard self.chainShapeLayer != nil
        else
        {
            self.chainShapeLayer = self.commonInit()
            return
        }
    }
    
    func commonInit()->ChainShapeLayer
    {
        let chainShapeLayer = ChainShapeLayer()
        let insetRect = self.experimentalView.bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        chainShapeLayer.frame = insetRect

        chainShapeLayer.fillColor = UIColor.blue.cgColor
        self.experimentalView.layer.addSublayer(chainShapeLayer)
        
        chainShapeLayer.path = Shape.triangle.createPath(inRect: insetRect)
        return chainShapeLayer
    }

    @IBAction func roundRobinAnimation(_ sender: Any)
    {
        guard let c = self.chainShapeLayer
        else
        {
            return
        }
        
        c.chainAnimations(shapes: shapes, bShouldReturnToFirstState: true, bIsInfinite: false)
    }
    
    @IBAction func infiniteAnimation(_ sender: Any)
    {
        guard let c = self.chainShapeLayer
        else
        {
            return
        }
        
        c.chainAnimations(shapes: shapes, bShouldReturnToFirstState: false, bIsInfinite: true)
    }
}

