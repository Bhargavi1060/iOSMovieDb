//
//  MovileListCell.swift
//  MovieDB
//
//  Created by Bhargavi on 27/04/22.
//

import UIKit
import AlamofireImage

class MovileListCell: UITableViewCell {

    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView(movie:Results){
        lblTitle.text = movie.title
        lblPopularity.text = movie.popularity?.description
        lblReleaseDate.text = movie.releaseDate
        let url = URL(string: Api.imageBaseUrl + movie.posterPath!)
        imgBanner.af_setImage(withURL: (url )!)//?? URL(string: "")
        
    }

}
