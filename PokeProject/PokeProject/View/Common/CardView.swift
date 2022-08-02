//
//  CardView.swift
//  PokeProject
//
//  Created by Aleyna on 31.07.2022.
//

import SwiftUI

struct CardView: View{
    let pokemon : Pokemon
    @Binding var isLoaded : Bool
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    @State var flipped: Bool = false
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0

    
    var body: some View {
        ZStack {
            if isLoaded {
                RoundedRectangle(cornerRadius: 36)
                           .foregroundColor(.white)
                           .frame(width: width*0.85, height: height*0.6)
                           .overlay(
                                   VStack{
                                       Text(pokemon.name)
                                           .padding(.top)
                                       Spacer(minLength: 0)
                                       ImageView(withURL: pokemon.sprites.frontDefault)
                                           
                                           .frame(width: width*0.5, height: width*0.5)
                                       Spacer(minLength: 0)
                                       HStack(){
                                           ForEach(pokemon.stats, id: \.stat.name) { stat in
                                               if stat.stat.name == StatsEnum.hp.rawValue || stat.stat.name == StatsEnum.attack.rawValue || stat.stat.name == StatsEnum.defense.rawValue {
                                                   VStack{
                                                       Text(stat.stat.name)
                                                           .frame(width: width*0.25, height: width*0.05)
                                                           .font(.system(size: 18.0, weight: .regular, design: .rounded))
                                                           
                                                       Text(stat.baseStat.intToString)
                                                           .frame(width: width*0.25, height: width*0.10)
                                                           .font(.system(size: 32.0, weight: .medium, design: .rounded))
                                                   }
                                               }
                                           }
                           
                                       }
                                       .padding(.bottom)
                                   }
                           )
            }
            else {
                RoundedRectangle(cornerRadius: 36)
                           .foregroundColor(.white)
                           .frame(width: width*0.85, height: height*0.6)
                           .overlay(
                            Text("Loading..")
                           )
            }
        }
    }
}
