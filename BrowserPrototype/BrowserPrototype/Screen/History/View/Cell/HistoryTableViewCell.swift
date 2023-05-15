//
//  HistoryTableViewCell.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell, ReusableNibLoadableView {
    @IBOutlet private weak var backgroundContentView: UIView!
    @IBOutlet private weak var urlTitleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundContentView.layer.borderColor = Constants.Colors.darkGray.cgColor
        backgroundContentView.layer.borderWidth = 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    func setup(model: HistoryModel?) {
        guard let model = model else { return }
        
        urlTitleLabel.text = model.urlTitle
        dateLabel.text = model.formattedDate
    }
}
