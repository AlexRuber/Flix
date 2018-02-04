//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Mihai Ruber on 1/30/18.
//  Copyright © 2018 Mihai Ruber. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    
    // Variables
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
