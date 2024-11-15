//
//  RootView.swift
//  rac
//
//  Created by ZongZiWang on 7/9/23.
//

import SwiftUI

struct RootView: View {
    @State var interactive = false
    @State var welcomeTab: WelcomeView.Tab = .about
    @State var character: CharacterOption? = nil

    var body: some View {
        NavigationView {
            VStack {
                if interactive {
                    InteractiveView(character: character) {
                        welcomeTab = .about
                        character = nil
                        withAnimation {
                            interactive.toggle()
                        }
                    }
                    .transition(.moveAndFade2)
                } else {
                    WelcomeView(tab: $welcomeTab, character: $character) { selected in
                        character = selected
                        // TODO: figure out why animation does not work well
//                        withAnimation {
                            interactive.toggle()
//                        }
                    }
                    .transition(.moveAndFade)
                }
            }
            .toolbar {
                if interactive {
                    ToolbarItem(placement: .principal) {
                        Image("logo")
                            .preferredColorScheme(.dark)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                interactive.toggle()
                            }
                        } label: {
                            Image("menu")
                                .tint(.white)
                                .padding(12)
                                .padding(.trailing, 20)
                        }

                    }
                } else {
                    ToolbarItemGroup(placement: .navigation) {
                            Image("logo")
                                .resizable()
                                .padding(.leading, 32)
                    }
                }
            }
        }
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .top).combined(with: .opacity),
            removal: .move(edge: .bottom).combined(with: .opacity)
        )
    }

    static var moveAndFade2: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .move(edge: .top).combined(with: .opacity)
        )
    }
}

struct LogoView: View {
    var body: some View {
        Image("logo")
            .resizable()
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
