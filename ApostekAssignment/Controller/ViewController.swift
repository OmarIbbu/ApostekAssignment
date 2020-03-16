//
//  ViewController.swift
//  ApostekAssignment
//
//  Created by OMAR on 14/03/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var model = MovieViewModel()
    
    static var tableViewCellCoordinator: [Int: IndexPath] = [:]
    static var imageBaseurl : String?
    static var baseUrl : String?
    static var endPoint : String?
    static var popularEndPoint : String?
    static var discoverEndPoint : String?
    static var topRelatedEndPoint : String?
    
    fileprivate func Configure() {
        let config = model.parseConfig()
        ViewController.baseUrl =  config.baseUrl
        ViewController.endPoint = config.endPoint
        ViewController.imageBaseurl = config.imageBaseUrl
        ViewController.topRelatedEndPoint = config.topRelatedEndPoint
        ViewController.discoverEndPoint = config.discoverEndPoint
        ViewController.popularEndPoint = config.popularEndPoint
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        Configure()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = tableView.frame
        
        let addButton = UIButton(frame: CGRect(x: frame.size.width - 85, y: 30, width: 100, height: 30))
        addButton.setTitle("Show All", for: .normal)
        addButton.titleLabel?.font =  UIFont(name: "Poppins-Regular", size: 14)
        addButton.titleLabel?.font = addButton.titleLabel?.font.withSize(14)
        addButton.tag = section
        addButton.addTarget(self,action:#selector(buttonClicked),for:.touchUpInside)
        addButton.setTitleColor(.blue, for: .normal)
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 30, width: 200, height: 30))
        
        switch section {
        case 0:
            titleLabel.attributedText = setTitle(name:"Popular Movies",location:8,length:6)
        case 1:
            titleLabel.attributedText = setTitle(name:"Top Related Movies",location:12,length:6)
        case 2:
            titleLabel.attributedText = setTitle(name:"Discover Movies",location:9,length:6)
        default:
            break
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        headerView.addSubview(titleLabel)
        headerView.addSubview(addButton)
        return headerView
    }
    
    @objc func buttonClicked(sender:UIButton)
    {
        switch sender.tag {
        case 0:
            tapSection(endPoint: ViewController.popularEndPoint!,title: "Popular Movies")
        case 1:
            tapSection(endPoint: ViewController.topRelatedEndPoint!,title: "TopRelated Movies")
        case 2:
            tapSection(endPoint: ViewController.discoverEndPoint!,title: "Discover  Movies")
        default:
            break
        }
    }
    
    func tapSection(endPoint:String, title:String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        controller.endPoint = endPoint
        controller.title = title
        self.navigationController?.pushViewController(controller, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    func setTitle(name:String,location:Int,length:Int) -> NSMutableAttributedString {
        let title = NSMutableAttributedString(string: name as String, attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue-Medium", size: 18.0)!])
        title.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: NSRange(location:location,length:length))
        
        return title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell
        {
            let tag = ViewController.tableViewCellCoordinator.count
            cell.collectionView.tag = tag
            ViewController.tableViewCellCoordinator[tag] = indexPath
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension String {
    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
        let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(boldFontAttribute, range: range)
        return fullString
}}
