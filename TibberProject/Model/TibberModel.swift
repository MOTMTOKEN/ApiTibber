//
//  TibberModel.swift
//  TibberProject
//
//  Created by Amir Nilsson on 2022-06-04.
//

import Foundation

struct TibberModel: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let assignmentData: [AssignmentDatum]
}

struct AssignmentDatum: Codable, Identifiable {
    let id = UUID()
    let title, assignmentDatumDescription, longDescription: String
    let connected: Bool
    let storeURL: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case assignmentDatumDescription = "description"
        case longDescription, connected
        case storeURL = "storeUrl"
        case imageURL = "imageUrl"
    }
}
