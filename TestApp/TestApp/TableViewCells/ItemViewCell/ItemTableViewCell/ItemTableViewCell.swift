//
//  ItemTableViewCell.swift
//  TestApp
//
//  Created by Владимир on 25.06.2022.
//

import UIKit
import Kingfisher

class ItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var itemImageView: UIImageView!
    
    var resultsFromApi: Results?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupDateLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupUI() {
        guard let resultsFromApi = resultsFromApi else {
            return
        }
        nameLabel.text = resultsFromApi.trackName
        descriptionLabel.text = "Описание отсутствует. На бэке его нет. К сожалению."
        
        if let trackPrice = resultsFromApi.trackPrice, let currency = resultsFromApi.currency {
            priceLabel.text = "\(trackPrice) \(currency)"
        } else {
            priceLabel.text = "No data"
        }
        
        if let urlFromApi = resultsFromApi.artworkUrl60 {
            let url = URL(string: urlFromApi)
            itemImageView.kf.setImage(with: url)
        }
    }
    
    func setupDateLabel() {
        let dateFormatter = ISO8601DateFormatter()
        guard let releaseDateText = resultsFromApi?.releaseDate else {
            return
        }
        guard let getDateFromJson = dateFormatter.date(from: releaseDateText) else {
            return
        }
        let dateFormatterToChange = DateFormatter()
        dateFormatterToChange.dateFormat = "dd MMMM"
        let changedDateFromJson = dateFormatterToChange.string(from: getDateFromJson)
        dateLabel.text = changedDateFromJson
    }
}
