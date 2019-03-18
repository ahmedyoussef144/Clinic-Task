//
//  RoundedSideButton.swift
//  Clinic Task
//
//  Created by Ahmed Zaki on 3/19/19.
//  Copyright © 2019 Ahmed Zaki. All rights reserved.
//

import UIKit

class RoundedSideButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRaduis()
    }
    override var bounds: CGRect {
        didSet {
          setCornerRaduis()
        }
    }
    private func setCornerRaduis() {
        
        layer.cornerRadius = bounds.size.height / 2
        clipsToBounds = true
    }
}
