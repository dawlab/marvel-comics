//
//  CustomView-snapkit.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 02/03/2023.
//

import UIKit
import SnapKit

final class CustomView: UIView {
    let grabber: UIView = {
        let grabber = UIView()
        
        grabber.backgroundColor = .systemGray5
        grabber.layer.cornerRadius = 5.0
        
        return grabber
    }()
    
    let title: UILabel = {
        let title = UILabel()
        
        title.font = UIFont.systemFont(ofSize: 20)
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        
        return title
    }()
    
    let authors: UILabel = {
        let authors = UILabel()
        
        authors.font = UIFont.systemFont(ofSize: 14)
        authors.textColor = .lightGray
        
        return authors
    }()
    
    let desc: UILabel = {
        let desc = UILabel()
        
        desc.font = UIFont.systemFont(ofSize: 17)
        desc.numberOfLines = 10
        desc.lineBreakMode = .byWordWrapping
        
        return desc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        layer.cornerRadius = 25
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        layer.masksToBounds = true
        
        addSubview(grabber)
        
        grabber.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(101)
            make.height.equalTo(7)
        }
        
        addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(authors)
        
        authors.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(desc)
        
        desc.snp.makeConstraints { make in
            make.top.equalTo(authors.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
        }
    }
}

