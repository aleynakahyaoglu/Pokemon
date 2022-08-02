//
//  HomePageView.swift
//  PokeProject
//
//  Created by Aleyna on 31.07.2022.
//

import SwiftUI

struct HomePageView: View {
    @ObservedObject private var viewModel = PokemonDetailViewModel()
    @State private var id: Int
    @State var degree = 0.15
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    @State var flipped: Bool = false
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    @State var animationIndex = 1
    @State var xCoordinate : CGFloat = 0.0
    @State var yCoordibate : CGFloat = 1.0
    @State var zCoordinate : CGFloat = 0.0
    
    init(id: Int) {
        self.id = id
        viewModel.fetchPokemonDetail(pokemonId: id)
    }
    var body: some View {
        ZStack{
            BackGroundView()
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            flipFlashcard()
                            self.id = 0
                            viewModel.fetchPokemonDetail(pokemonId: id + 1)
                        }
                    } label: {
                        Image(Image.restartBtnImage)
                            .resizable()
                            .frame(width: width*0.1, height: width*0.1)
                            .padding()
                }
                    Spacer(minLength: 0)
                }
                Spacer(minLength: 0)

                CardView(pokemon: viewModel.pokemon, isLoaded: $viewModel.isLoaded)
                    .rotation3DEffect(.degrees(contentRotation), axis: (x: xCoordinate, y: yCoordibate, z: zCoordinate))
                    .onTapGesture {
                        withAnimation {
                            flipFlashcard()
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                                viewModel.fetchPokemonDetail(pokemonId: id + 1)
                                self.id += 1
                            }
                        }
                    }
                .rotation3DEffect(.degrees(flashcardRotation), axis: (x: xCoordinate, y: yCoordibate, z: zCoordinate))
                Spacer(minLength: 0)
            }
        }
    }
    
    func flipFlashcard() {
        let animationNo = animationIndex % 2
        
        switch animationNo {
        case 0:
            yCoordibate = 1.0
            xCoordinate = 0.0
           flipCard(isVertical: true)
        case 1:
            yCoordibate = 0.0
            xCoordinate = 1.0
           flipCard(isVertical: false)
        default:
            flipCard(isVertical: false)
        }
        animationIndex += 1
    }
    func flipCard(isVertical : Bool){
        let animationTime = 0.5
        withAnimation(Animation.easeIn(duration: animationTime)) {
            if isVertical {
                flashcardRotation += 180.0
            }
            else {
                flashcardRotation -= 180.0
            }
        }
        withAnimation(Animation.easeIn(duration: 0.001).delay(animationTime / 2)) {
            if isVertical {
                contentRotation += 180.0
            }
            else {
                contentRotation -= 180.0
            }
            flipped.toggle()
        }
    }
}
