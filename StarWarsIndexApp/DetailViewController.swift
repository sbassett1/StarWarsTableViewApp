//
//  DetailViewController.swift
//  StarWarsIndexApp
//
//  Created by Mac on 9/2/17.
//  Copyright © 2017 Mac. All rights reserved.
//
import Foundation
import UIKit

class DetailViewController:UIViewController{
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
            guard var unwrappedName = self.details?.name else {return}
            unwrappedName = unwrappedName.components(separatedBy: .whitespaces).joined().replacingOccurrences(of: "é", with: "e")
            print("afterGuard")
            Networking.callNetworkImage(type: .imageUrl,objectName: unwrappedName){
                [weak self](image,error) in
                guard error == nil else {return print("error image call")}
                    print("return image from detail")
                guard let image = image as? UIImage else {return print("got image")}
                Cache.shared.imageCache.setObject(image, forKey: unwrappedName as NSString)
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
        detailName.text = details?.name
        detailBirthYear.text = details?.birthYear
        detailHeight.text = details?.height
        detailMass.text = details?.mass
        detailHairColor.text = details?.hairColor
        detailSkinColor.text = details?.skinColor
        detailEyeColor.text = details?.eyeColor
        detailGender.text = details?.gender
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func getHomeWorld(_ sender: UIButton) {
//        let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let home:Homeworld = mainstoryboard.instantiateViewController(withIdentifier: "homeworld") as? Homeworld else {return}
//        home.delegate = self as? goToHomeworld
//        present(home, animated:  true, completion: nil)
    }
}

