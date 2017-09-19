//
//  Homeworld.swift
//  StarWarsIndexApp
//
//  Created by Mac on 9/18/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import UIKit

//protocol goToHomeworld {
//    func getInfo(name: String)
//}

class Homeworld:UIViewController{
//    var delegate: goToHomeworld? = nil
    @IBOutlet weak var homeLabel: UILabel!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
