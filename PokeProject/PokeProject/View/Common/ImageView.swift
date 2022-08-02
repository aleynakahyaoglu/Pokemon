//
//  ImageView.swift
//  PokeProject
//
//  Created by Aleyna on 31.07.2022.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL:  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    }
}
