//
//  MyMagicalHand - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import Vision
import ImageIO

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
        updateClassifications(for: drawImage)
    }

    // MARK: - Image Classification
    lazy private var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: KerasShapeClassifier(configuration: MLModelConfiguration()).model)

            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()

    private func updateClassifications(for image: UIImage) {
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }

        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }

    private func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.resultShapeLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
                return
            }

            guard let classifications = results as? [VNClassificationObservation] else { return }

            if classifications.isEmpty {
                self.resultShapeLabel.text = "Nothing recognized."
            } else {
                let classfication = classifications[0]
                self.resultShapeLabel.text = "\(classfication.identifier)처럼 보이네요"
            }
        }
    }

}

extension CGImagePropertyOrientation {
    init(_ orientation: UIImage.Orientation) {
        switch orientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        @unknown default:
            fatalError()
        }
    }
}
