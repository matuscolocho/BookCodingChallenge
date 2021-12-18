//
//  BookDetailViewController.swift
//  EBooks
//
//  Created by JoshuaMatus on 17/12/21.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    
    @IBOutlet weak var bookCoverIV: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var reviewTV: UITextView!
    var recomendations = [Book]()
    var mBook = Book()
    
    lazy var recomendationsCollection:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 2
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.dataSource = self
        cv.delegate = self
        
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        bookTitle.text = mBook.title
        bookAuthor.text = mBook.author != nil ? "" : mBook.author
        bookCoverIV.setImage(url: mBook.imageURL)
        
        self.view.addSubview(recomendationsCollection)
        
        _ = recomendationsCollection.anchor(self.reviewTV.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 60, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 110  )
        recomendationsCollection.register(UINib(nibName: "RecomendationViewCell", bundle: nil), forCellWithReuseIdentifier: "recomendationId")
    }
    

  

}




extension BookDetailViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recomendations.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recomendationId", for: indexPath) as! RecomendationViewCell
        
        let book = recomendations[indexPath.row]
        

        cell.bookCoverIV.setImage(url: book.imageURL)
        
        
        return cell
        
        
        
    }
    
    
}

extension BookDetailViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt index01Path: IndexPath) -> CGSize {
        
        
        return CGSize(width: self.view.frame.size.width * 0.18 ,
                      height: 100)
        
    }

}
