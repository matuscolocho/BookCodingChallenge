//
//  ViewController.swift
//  EBooks
//
//  Created by JoshuaMatus on 17/12/21.
//

import UIKit

class BooksViewController: UIViewController {
    
    
    
    var mBooks = [Book]()
    let bookId  = "bookId"
    
    @IBOutlet weak var titleLbl: UILabel!
    lazy var booksCollection:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.dataSource = self
        cv.delegate = self
        
        cv.backgroundColor = UIColor.clear
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(booksCollection)
        
        _ = booksCollection.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0  )
        booksCollection.register(UINib(nibName: "BookViewCell", bundle: nil), forCellWithReuseIdentifier: bookId)
        
        
        HttpHelper.fetchBooks { books in
            self.mBooks  = books
            self.booksCollection.reloadData()
           
        }
        // Do any additional setup after loading the view.
    }
    
    
   


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        let bookDetailVC = segue.destination as! BookDetailViewController
         var recomendations = [Book]()
        for _ in 0..<5{
            
            let randomIndex = Int.random(in: 0..<20)
            recomendations.append(mBooks[randomIndex])
            
        }
        bookDetailVC.mBook = mBooks[indexPath.row]
        bookDetailVC.recomendations = recomendations
        
    }
    


}


extension BooksViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showBookDetail", sender: indexPath)
    }
}


extension BooksViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mBooks.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookId, for: indexPath) as! BookViewCell
        
        let book = mBooks[indexPath.row]
        
        cell.bookTitle.text = book.title
        cell.bookAuthor.text = book.author != nil ? "" : book.author
        cell.bookCoverIV.setImage(url: book.imageURL)
        
        
        return cell
        
        
        
    }
    
    
}

extension BooksViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt index01Path: IndexPath) -> CGSize {
        
        
        return CGSize(width: self.booksCollection.frame.width * 0.9 ,
                      height: 150)
        
    }

}
