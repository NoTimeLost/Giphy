//
//  GifListResponse.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

struct GifListResponse: Decodable {
    let data: [Gif]
    let pagination: Pagination
}

extension GifListResponse {
    struct Gif: Decodable {
        let images: GifImage
        let id: String
    }

    struct GifImage: Decodable {
        let original: GifImageParameters
        let fixedWidthDownsampled: GifImageParameters
        let previewGif: GifImageParameters
    }

    struct GifImageParameters: Decodable {
        let height: String
        let width: String
        let url: String
    }
}
