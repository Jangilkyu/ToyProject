//
//  MainViewController.swift
//  QuotesGenerator
//
//  Created by 장일규 on 2022/02/02.
//

import UIKit

class MainViewController: UIViewController {

    let quotesTitleLabel: UILabel = {
      let quotesTitleLabel = UILabel()
        quotesTitleLabel.text = "명언 생성기"
        quotesTitleLabel.textAlignment = .center
        quotesTitleLabel.font = .systemFont(ofSize: 20)
        quotesTitleLabel.sizeToFit()
      return quotesTitleLabel
    }()
    
    let quotesImageView: UIImageView = {
        let quotesImageView = UIImageView()
        quotesImageView.backgroundColor = ColorTheme.white.color
        return quotesImageView
    }()
    
    let quotesLabel: UILabel = {
        let quotesLabel = UILabel()
        quotesLabel.sizeToFit()

        quotesLabel.text = "Label"
        quotesLabel.numberOfLines = 0

        quotesLabel.backgroundColor = .gray
        return quotesLabel
    }()
    
    let quotesWriterLabel: UILabel = {
        let quotesWriterLabel = UILabel()
        quotesWriterLabel.text = "a"
        quotesWriterLabel.backgroundColor = .systemRed
        return quotesWriterLabel
    }()
    
    let quotesButton: UIButton = {
        let quotesButton = UIButton()
        quotesButton.setTitle("명언 생성", for: .normal)
        quotesButton.backgroundColor = .black
        
        return quotesButton
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(quotesTitleLabel)
        view.addSubview(quotesImageView)
        quotesImageView.addSubview(quotesLabel)
        quotesImageView.addSubview(quotesWriterLabel)
        view.addSubview(quotesButton)
    }
    
    func setConstraints() {
        quotesTitleLabelConstraints()
        quotesImageViewConstraints()
        quotesLabelConstrinats()
        quotesWriterLabelConstraints()
        quotesButtonConstraints()
    }
    
    func quotesTitleLabelConstraints() {
        quotesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        quotesTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quotesTitleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    }
    
    func quotesImageViewConstraints() {
        quotesImageView.translatesAutoresizingMaskIntoConstraints = false
        quotesImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        quotesImageView.topAnchor.constraint(equalTo: quotesTitleLabel.bottomAnchor, constant: 50).isActive = true
        quotesImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        view.trailingAnchor.constraint(equalTo: quotesImageView.trailingAnchor, constant: 24).isActive = true
    }
    
    func quotesLabelConstrinats() {
        quotesLabel.translatesAutoresizingMaskIntoConstraints = false
        quotesLabel.topAnchor.constraint(equalTo: quotesImageView.topAnchor, constant: 20).isActive = true
        quotesWriterLabel.bottomAnchor.constraint(equalTo: quotesLabel.bottomAnchor, constant: 20).isActive = true
        quotesLabel.leadingAnchor.constraint(equalTo: quotesImageView.leadingAnchor, constant: 20).isActive = true
        quotesImageView.trailingAnchor.constraint(equalTo: quotesLabel.trailingAnchor, constant: 20).isActive = true
        quotesLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
    }
    
    func quotesWriterLabelConstraints() {
        quotesWriterLabel.translatesAutoresizingMaskIntoConstraints = false
        quotesImageView.bottomAnchor.constraint(equalTo: quotesWriterLabel.bottomAnchor, constant: 20).isActive = true
        quotesWriterLabel.leadingAnchor.constraint(equalTo: quotesImageView.leadingAnchor, constant: 20).isActive = true
        quotesImageView.trailingAnchor.constraint(equalTo: quotesLabel.trailingAnchor, constant: 20).isActive = true
        quotesWriterLabel.setContentHuggingPriority(.init(rawValue: 2), for: .vertical)
        quotesWriterLabel.setContentCompressionResistancePriority(.init(rawValue: 500), for: .vertical)
    }
    
    func quotesButtonConstraints() {
        quotesButton.translatesAutoresizingMaskIntoConstraints = false
        quotesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quotesButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
