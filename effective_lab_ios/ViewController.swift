//
//  ViewController.swift
//  effective_lab_ios
//
//  Created by user225687 on 12/12/22.
//
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let heroes: [HeroData] = [
        HeroData(image: "iron_man", name: "Iron Man"),
        HeroData(image: "thanos", name: "Thanos"),
        HeroData(image: "wolverine", name: "Wolverine"),
        HeroData(image: "bullseye", name: "Bullseye")
    ]
    
    let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    let cellHeight = (3 / 5) * UIScreen.main.bounds.height
    let sectionSpacing = (1 / 8) * UIScreen.main.bounds.width
    let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
    
    let cellId = "cell id"
    
    private let textTitle: UILabel = {
        let textTitle = UILabel()
        textTitle.text = "Choose your hero"
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        textTitle.textAlignment = .center
        textTitle.textColor = .white
        textTitle.font = .systemFont(ofSize: 36)
        return textTitle
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = PagingCollectionViewLayout()
        layout.itemSize = CGSize(width: cellWidth,height: cellHeight)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        return collectionView
    }()
    let screenBounds = UIScreen.main.bounds
    
    private let titleImageView: UIImageView = {
        let titleImageView = UIImageView()
        titleImageView.image = UIImage(named: "marvel")
        titleImageView.backgroundColor = .black
        return titleImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        view.addSubview(textTitle)
        view.addSubview(titleImageView)
        registerCollectionViewCells()
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleImageView.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: screenBounds.width/3, height: 40))
            make.top.equalTo(view).offset(70.0)
        }
        textTitle.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(titleImageView.snp.bottom).offset(26)
        }
        collectionView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(textTitle.snp.bottom)
            make.bottom.equalTo(view.snp.bottom).offset(-30)
        }
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}

// MARK: - CollectionView Data Source
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let data = heroes[indexPath.item]
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: data.image)
            imageView.backgroundColor = .black
            imageView.contentMode = .scaleToFill
            return imageView
        }()
        
        let textLabel: UILabel = {
            let textLabel = UILabel()
            textLabel.text = data.name
            textLabel.textColor = .white
            textLabel.font = .systemFont(ofSize: 30)
            textLabel.backgroundColor = .black.withAlphaComponent(0.5)
            return textLabel
        }()
        
        cell.layer.cornerRadius = 10
        cell.backgroundView = imageView
        cell.addSubview(textLabel)
        textLabel.snp.makeConstraints{ make in
            make.bottomMargin.equalTo(cell.snp.bottomMargin)
            make.leftMargin.equalTo(cell.snp.leftMargin)
            make.left.equalTo(cell.snp.left).offset(16)
            make.bottom.equalTo(cell.snp.bottom).offset(-16)
        }
        return cell
    }
}
