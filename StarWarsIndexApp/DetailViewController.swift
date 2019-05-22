//
//  DetailViewController.swift
//  StarWarsIndexApp
//
//  Created by Mac on 9/2/17.
//  Copyright © 2017 Mac. All rights reserved.
//
import Foundation
import UIKit

class DetailViewController:UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailBirthYear: UILabel!
    @IBOutlet weak var detailHeight: UILabel!
    @IBOutlet weak var detailMass: UILabel!
    @IBOutlet weak var detailHairColor: UILabel!
    @IBOutlet weak var detailSkinColor: UILabel!
    @IBOutlet weak var detailEyeColor: UILabel!
    @IBOutlet weak var detailGender: UILabel!
    
    weak var details:SWCharacter? {
        didSet {
            guard var name = self.details?.name else { return }
            name = name.components(separatedBy: .whitespaces).joined().replacingOccurrences(of: "é", with: "e")
            Networking.callNetworkImage(type: .imageUrl,objectName: name) { [weak self] image,error in
                guard error == nil,
                    let image = image as? UIImage else { return }
                
                Cache.shared.imageCache.setObject(image, forKey: name as NSString)
                
                DispatchQueue.main.async {
                    self?.detailImageView.image = image
                    self?.view.reloadInputViews()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = details?.name
        detailName.text = " \(details?.name ?? "")"
        detailBirthYear.text = " \(details?.birthYear ?? "")"
        detailHeight.text = " \(details?.height ?? "")"
        detailMass.text = " \(details?.mass ?? "")"
        detailHairColor.text = " \(details?.hairColor ?? "")"
        detailSkinColor.text = " \(details?.skinColor ?? "")"
        detailEyeColor.text = " \(details?.eyeColor ?? "")"
        detailGender.text = " \(details?.gender ?? "")"
    }
    
    @IBAction func getHomeWorld(_ sender: UIButton) {
        // will finish this later
//        let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let home:Homeworld = mainstoryboard.instantiateViewController(withIdentifier: "homeworld") as? Homeworld else {return}
//        home.delegate = self as? goToHomeworld
//        present(home, animated:  true, completion: nil)
    }
}

