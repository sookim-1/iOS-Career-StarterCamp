//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var informationTitle: UILabel!
    @IBOutlet weak var informationPoster: UIImageView!
    @IBOutlet weak var informationVisitors: UILabel!
    @IBOutlet weak var informationLocation: UILabel!
    @IBOutlet weak var informationDuration: UILabel!
    @IBOutlet weak var informationDescription: UILabel!
    
    private var koreaExhibitItems: [KoreaExhibitItem] = []
    private var expo1900Information = Expo1900Information(title: "", visitors: 0, location: "", duration: "", description: "")
    
    override func viewDidLoad() {
        let jsonDecoder = JSONDecoder()
        
        guard let koreaExhibitItemsData = NSDataAsset(name: "items"),
              let expo1900InformationData = NSDataAsset(name: "exposition_universelle_1900")
        else { return }
        
        do {
            koreaExhibitItems = try jsonDecoder.decode([KoreaExhibitItem].self, from: koreaExhibitItemsData.data)
            expo1900Information = try jsonDecoder.decode(Expo1900Information.self, from: expo1900InformationData.data)
        } catch  {
            print("Error")
        }
        
        informationTitle.text = expo1900Information.title
        informationVisitors.text = "방문객 :\(expo1900Information.visitors) 명"
        informationLocation.text = "개최지 :" + expo1900Information.location
        informationDuration.text = "개최 기간 :" + expo1900Information.duration
        informationDescription.text = expo1900Information.description
        
        print(koreaExhibitItems)
        print(expo1900Information)
    }
}
