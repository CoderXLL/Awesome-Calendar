//
//  ASYearCalendarHeaderView.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/22.
//

import Foundation
import UIKit

class ASYearCalendarHeaderView: UICollectionReusableView {
    // MARK: - life circle
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods
    private func makeUI() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(10)
            $0.centerY.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints {
            $0.trailing.equalTo(-10)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - public methods
    public func setup(title: String?, subTitle: String?) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    // MARK: - lazy loading
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .asRed
        label.font = .fontWithSize(30, .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .asLightGray
        label.font = .fontWithSize(15, .regular)
        label.textAlignment = .right
        return label
    }()
}
