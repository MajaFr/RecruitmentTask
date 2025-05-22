//
//  CharactersView.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var viewModel: CharactersViewModel
    @EnvironmentObject private var appRouter: AppRouter
    
    var body: some View {
        VStack {
            if viewModel.isShowingCharacters {
                BackButtonView(title: Constants.titleLabel) {
                    viewModel.isShowingCharacters = false
                }
                .padding()
                ScrollView {
                    LazyVStack(spacing: .sizeMedium) {
                        ForEach(viewModel.charterers) { character in
                            CharacterRowView(character: character) 
                            .onTapGesture {
                                appRouter.routeToCharacter(character)
                            }
                        }
                    }
                    .padding(.top)
                }
            } else {
                instructionView
            }
        }
    }
    
    private var instructionView: some View {
        VStack(spacing: .sizeLarge) {
            Image("logo")
                .resizable()
                    .scaledToFit()
                    .frame(width: .imageLargeSize, height: .imageLargeSize)
            Text(Constants.helloLabel)
                .bold()
            Text(Constants.instructionText)
                .font(.body)
                .multilineTextAlignment(.center)
            
            Button(Constants.loadCharactersLabel) {
                Task {
                    await viewModel.getCharacters()
                    viewModel.isShowingCharacters = true
                }
            }
            .tint(.green)
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal)
    }
}

#Preview {
    PreviewRouterContainer(startingAt: .characterView)
}

private extension CharactersView {
    struct Constants {
        static let helloLabel = "Hello in Rick and Morty Universe!"
        static let titleLabel = "Characters List"
        static let instructionText = "Tap the button below to load list of characters from the Rick and Morty Universe."
        static let loadCharactersLabel = "Load Characters"
    }
}
