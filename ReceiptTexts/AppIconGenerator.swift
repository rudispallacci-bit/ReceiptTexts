//
//  AppIconGenerator.swift
//  ReceiptTexts
//
//  Created by Rudi Spallacci on 3/20/26.
//

import SwiftUI

struct AppIconView: View {
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(red: 0.05, green: 0.15, blue: 0.10), Color(red: 0.02, green: 0.08, blue: 0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Subtle radial glow
            RadialGradient(
                colors: [Color(red: 0.25, green: 0.57, blue: 0.47).opacity(0.4), Color.clear],
                center: .center,
                startRadius: 0,
                endRadius: 200
            )
            
            // Shield + bubble icon
            ZStack {
                // Shield
                Image(systemName: "shield.fill")
                    .font(.system(size: 120, weight: .regular))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 0.32, green: 0.72, blue: 0.53),
                                Color(red: 0.18, green: 0.42, blue: 0.31)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                // Bubble overlay on shield
                Image(systemName: "bubble.fill")
                    .font(.system(size: 48, weight: .regular))
                    .foregroundColor(Color(red: 0.02, green: 0.08, blue: 0.05))
                    .offset(x: 4, y: 4)
                
                // Subtle shine on shield
                Image(systemName: "shield")
                    .font(.system(size: 120, weight: .thin))
                    .foregroundColor(.white.opacity(0.15))
            }
        }
        .frame(width: 1024, height: 1024)
    }
}

#Preview {
    AppIconView()
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 44))
}
