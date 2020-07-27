//
//  ViewController.swift
//  handwriting-drawing
//
//  Created by Leonardo Viana on 26/07/20.
//  Copyright © 2020 Leonardo Viana. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!

    var result: String? = "0"
    var requests = [VNRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVision()
    }
    
    func setupVision(){
//        guard let visionModel = try? VNCoreMLModel(for: MNISTClassifier().model) else {
//            fatalError("Could not load Vision ML Model")
//        }
        
        guard let visionModel = try? VNCoreMLModel(for: mnistCNN().model) else {
            fatalError("Could not load Vision ML Model")
        }
        
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: self.handleClassification)
        
        self.requests = [classificationRequest]
    }
    
    func handleClassification(request: VNRequest, error: Error?){
        guard let observations = request.results else { print("No results"); return }
                
        let classifications = observations
            .compactMap({ $0 as? VNClassificationObservation })
            //.filter({ $0.confidence > 0.8 })
            .map({ $0.identifier })
        
        print(classifications.first!)
        
        DispatchQueue.main.async {
            //self.txtLabel.text = classifications.first
            self.result = classifications.first
            
            let alert = UIAlertController(title: "Result", message: "You probably drew number \(self.result!)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Close\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
    @IBAction func recognizeDraw(_ sender: Any) {
        let image = UIImage(view: canvasView)
        let scaledImage = scaleImage(image: image, toSize: CGSize(width: 28, height: 28))
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: scaledImage.cgImage!, options: [:])
        
        do {
            try imageRequestHandler.perform(self.requests)
        }catch{
            print(error)
        }
        
    }
    
    func scaleImage(image: UIImage, toSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

