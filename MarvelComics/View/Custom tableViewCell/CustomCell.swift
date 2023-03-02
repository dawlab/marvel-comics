//
//  CustomCell-snapkit.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 02/03/2023.
//

import UIKit
import SnapKit

final class CustomCell: UITableViewCell {
    let cellImageView: UIImageView = {
        let cellImageView = UIImageView()
        
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
        
        return cellImageView
    }()
    
    let cellTitle: UILabel = {
        let cellTitle = UILabel()
        
        cellTitle.numberOfLines = 2
        cellTitle.lineBreakMode = .byWordWrapping
        cellTitle.font = .boldSystemFont(ofSize: 20)
        
        return cellTitle
    }()
    
    let cellAuthors: UILabel = {
        let cellAuthors = UILabel()
        
        cellAuthors.font = UIFont.systemFont(ofSize: 12)
        cellAuthors.textColor = .lightGray
        
        return cellAuthors
    }()
    
    let cellDesc: UILabel = {
        let cellDesc = UILabel()
        
        cellDesc.font = UIFont.systemFont(ofSize: 14)
        cellDesc.numberOfLines = 5
        cellDesc.lineBreakMode = .byWordWrapping
        
        return cellDesc
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellTitle.text = nil
        cellAuthors.text = nil
        cellDesc.text = nil
    }
    
    private func setupLayout() {
        contentView.addSubview(cellImageView)
        
        cellImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(219)
        }
        
        contentView.addSubview(cellTitle)
        
        cellTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(cellImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(cellAuthors)
        
        cellAuthors.snp.makeConstraints { make in
            make.top.equalTo(cellTitle.snp.bottom).offset(8)
            make.leading.equalTo(cellImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(cellDesc)
        
        cellDesc.snp.makeConstraints { make in
            make.top.equalTo(cellAuthors.snp.bottom).offset(8)
            make.leading.equalTo(cellImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
        }
    }
}
