//
//  DashboardViewModel.swift
//  CompositionalLayout
//
//  Created by User on 04.06.25.
//

import Foundation
class DashboardViewModel {
    
    let cards: [CardModel] = [
        CardModel(imageName: "card1"),
        CardModel(imageName: "card2"),
        CardModel(imageName: "card3")
    ]

    let frequentlyUsed: [FrequentlyUsedModel] = [
        FrequentlyUsedModel(iconName: "image1", title: "Mobile Recharge"),
        FrequentlyUsedModel(iconName: "image2", title: "Bill Payments"),
        FrequentlyUsedModel(iconName: "image3", title: "Bank Tranfer"),
        FrequentlyUsedModel(iconName: "image4", title: "Request Money"),
        FrequentlyUsedModel(iconName: "image5", title: "Transaction History")
    ]

    let services: [ServiceModel] = [
        ServiceModel(title: "Open Account"),
        ServiceModel(title: "Manage Cards")
    ]
}
