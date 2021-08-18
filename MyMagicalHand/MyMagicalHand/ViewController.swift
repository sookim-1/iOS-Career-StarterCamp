//
//  MyMagicalHand - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet var canvasView: CanvasView!
    @IBOutlet var resultShapeLabel: UILabel!
    @IBOutlet var percentageShapeLabel: UILabel!

    @IBAction func clearCanvas(_ sender: UIButton) {
        canvasView.clear()
        resultShapeLabel.text = ""
        percentageShapeLabel.text = ""
    }

    @IBAction func finishDraw(_ sender: UIButton) {
        let imageRenderer = UIGraphicsImageRenderer(size: canvasView.bounds.size)
        let drawImage = imageRenderer.image { _ in
            canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        }
    }

}
