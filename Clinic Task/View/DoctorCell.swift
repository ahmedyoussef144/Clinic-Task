//
//  DoctorCell.swift
//  Clinic Task
//
//  Created by Ahmed Zaki on 3/18/19.
//  Copyright © 2019 Ahmed Zaki. All rights reserved.
//

import UIKit
import SDWebImage

class DoctorCell: UITableViewCell {
    
    @IBOutlet weak var premiumDoctorImage: UIImageView!
    @IBOutlet weak var doctorFeeLabel: UILabel!
    @IBOutlet weak var doctorNumofFollowersLabel: UILabel!
    @IBOutlet weak var doctorSpcialistLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var bookedButton: UIButton!
    static let identifier = "DoctorCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        doctorImage.layer.cornerRadius = 8
        doctorImage.clipsToBounds = true
//        bookedButton.layer.cornerRadius = 10
//        bookedButton.clipsToBounds = true
    }
    func configure(doctor : Doctor) {
        doctorNameLabel.text = doctor.name
        doctorSpcialistLabel.text = doctor.speciality
        doctorNumofFollowersLabel.text = "\(doctor.followers ?? 0)"
        doctorFeeLabel.text = "\(doctor.minFees ?? 0) EGP"
        if let url = doctor.image {
            let imageUrl = URL.init(string: url)
            doctorImage.sd_setImage(with: imageUrl, placeholderImage:UIImage.init(named: "PlaceHolder"))
            if doctor.isPremium == 0 {
                premiumDoctorImage.isHidden = true
            }
        }
    }
}
