//
//  LoginViewController.swift
//  qChat
//
//  Created by Highest on 04.09.2024.
//

import UIKit

protocol LoginViewControllerDelegate{
    func openRegVC()
    func openAuthVC()
    func startApp()
    func closeVC()
}

class LoginViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var authVC: AuthViewController!
    var regVC: RegViewController!
    let sliderSlides = SliderSlides()
    var slides: [Slides] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        slides = sliderSlides.getSlides()

    }
    func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        	
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        collectionView.isPagingEnabled = true
        
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: SlideLoginCollectionViewCell.reoseId, bundle: nil), forCellWithReuseIdentifier: SlideLoginCollectionViewCell.reoseId)
    }
}
extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideLoginCollectionViewCell.reoseId, for: indexPath) as! SlideLoginCollectionViewCell
            cell.delegate = self
            let slide = slides[indexPath.row]
            cell.configure(slide: slide)
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
}
extension LoginViewController: LoginViewControllerDelegate{
    
    
    func openAuthVC() {
        if authVC == nil {
            authVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController?
        }
        authVC.delegate = self
        navigationController?.pushViewController(authVC, animated: true)
      self.view.insertSubview(authVC.view, at: 1)
    }
    func openRegVC() {
        if regVC == nil{
            regVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegViewController") as! RegViewController?
        }
        regVC.delegate = self
        self.view.insertSubview(regVC.view, at: 1)
    }
    func closeVC() {
        if authVC != nil {
            authVC.view.removeFromSuperview()
            authVC = nil
        }
        if regVC != nil {
            regVC.view.removeFromSuperview()
            regVC = nil
        }
    }
    func startApp() {
        let startVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AppViewController")
        self.view.insertSubview(startVC.view, at: 2)
    }
}



