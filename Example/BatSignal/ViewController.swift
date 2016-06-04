//
//  ViewController.swift
//  BatSignal
//
//  Created by Matteo Crippa on 06/04/2016.
//  Copyright (c) 2016 Matteo Crippa. All rights reserved.
//

import BatSignal
import UIKit

class ViewController: UIViewController {

    var bat: BatSignal?

    @IBAction func sendMsg() {
        self.bat!.send("Abracadabra")
    }

    @IBAction func receiveMsg() {
        bat!.listen() {_ in }
    }

    override func viewDidLoad() {
        bat = BatSignal()

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
