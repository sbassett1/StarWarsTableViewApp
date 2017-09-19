//
//  TableViewCell.swift
//  StarWarsIndexApp
//
//  Created by Mac on 9/3/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellBirthYear: UILabel!
    
    
//    var loadImage: imageData?{
//        
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    func loadCell(URLimage:String, name:String, birthYear:String){

        cellName.text = name
        cellBirthYear.text = birthYear
        
        let networking = Networking()
        networking.imageDelegate = self
        networking.callImage(imageName: URLimage)
            
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
}


extension MyTableViewCell:NetworkingImages{
    func apiDidReturnWithImage(image: UIImage) {
        DispatchQueue.main.async {
            self.cellImage.image = image
        }
    }
    func imageError(error: String) {
        print("Image fucked up")
    }
    func apiImageResponseFailure(statusCode: Int) {
        print("Image Response fucked up \(statusCode)")
    }
}
