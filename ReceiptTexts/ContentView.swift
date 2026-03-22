//
//  ContentView.swift
//  ReceiptTexts
//
//  Created by Rudi Spallacci on 3/20/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showConversations = false
    
    var body: some View {
        if showConversations {
            NavigationView {
                ConversationListView()
            }
        } else {
            ZStack {
                Color(hex: "0A0A0A")
                    .ignoresSafeArea()
                
                VStack {
                    RadialGradient(
                        colors: [Color(hex: "40916C").opacity(0.2), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 350
                    )
                    .frame(height: 450)
                    Spacer()
                }
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 28) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "40916C").opacity(0.12))
                                .frame(width: 130, height: 130)
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color(hex: "1B4332"), Color(hex: "0D2B1F")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 108, height: 108)
                            Circle()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [Color(hex: "52B788"), Color(hex: "40916C").opacity(0.3)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                                .frame(width: 108, height: 108)
                            ZStack {
                                Image(systemName: "shield.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(Color(hex: "52B788"))
                                Image(systemName: "bubble.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color(hex: "0D2B1F"))
                                    .offset(x: 2, y: 2)
                            }
                        }
                        
                        VStack(spacing: 12) {
                            Text("ReceiptTexts")
                                .font(.custom("Didot", size: 44))
                                .foregroundColor(.white)
                                .tracking(1)
                            
                            Text("Save. Export. Prove it.")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(hex: "52B788"))
                                .tracking(4)
                                .textCase(.uppercase)
                            
                            Text("Export your entire iMessage conversations\nas PDF — simple, fast, private.")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(Color(hex: "8E8E93"))
                                .multilineTextAlignment(.center)
                                .lineSpacing(6)
                                .tracking(0.2)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        FeaturePill(icon: "lock.shield.fill", text: "100% Private — stays on your device")
                        FeaturePill(icon: "doc.richtext.fill", text: "Export full conversations to PDF")
                        FeaturePill(icon: "bolt.fill", text: "Fast, simple, no account needed")
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                    
                    VStack(spacing: 14) {
                        Button(action: {
                            showConversations = true
                        }) {
                            HStack(spacing: 10) {
                                Text("Get Started")
                                    .font(.system(size: 14, weight: .semibold))
                                    .tracking(3)
                                    .textCase(.uppercase)
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 12, weight: .semibold))
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 17)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "52B788"), Color(hex: "2D6A4F")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(4)
                            .shadow(color: Color(hex: "52B788").opacity(0.25), radius: 16, x: 0, y: 8)
                        }
                        .padding(.horizontal, 24)
                        
                        Text("No ads · No subscriptions · No nonsense")
                            .font(.system(size: 11, weight: .regular))
                            .tracking(1.5)
                            .textCase(.uppercase)
                            .foregroundColor(Color(hex: "555555"))
                    }
                    
                    Spacer().frame(height: 44)
                }
            }
        }
    }
}

struct FeaturePill: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 13))
                .foregroundColor(Color(hex: "52B788"))
                .frame(width: 20)
            Text(text)
                .font(.system(size: 13, weight: .regular))
                .tracking(0.2)
                .foregroundColor(Color(hex: "AEAEB2"))
            Spacer()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(Color(hex: "111111"))
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(Color(hex: "222222"), lineWidth: 1)
        )
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ContentView()
}
