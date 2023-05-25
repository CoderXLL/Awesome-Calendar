//
//  ASTestCell.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/19.
//

import Foundation
import UIKit

class ASTestCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func set(item: Int, section: Int) {
        label.text = "\(section) --- \(item)"
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .fontWithSize(20, .medium)
        label.textAlignment = .center
        return label
    }()
}
