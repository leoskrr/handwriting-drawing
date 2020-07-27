//
//  ViewController.swift
//  handwriting-drawing
//
//  Created by Leonardo Viana on 26/07/20.
//  Copyright © 2020 Leonardo Viana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
}

