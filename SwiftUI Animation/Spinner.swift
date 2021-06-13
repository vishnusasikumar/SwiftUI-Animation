//
//  Spinner.swift
//  SwiftUI Animation
//
//  Created by Vishnu Sasikumar on 14/06/21.
//

import SwiftUI

struct Spinner: View {
    
    let rotationTime: Double = 0.75
    let fullRotation: Angle = .degrees(360)
    static let initialDegree: Angle = .degrees(270)
    let animationTime: Double = 1.9
    
    @State var spinnerStart: CGFloat = 0.0
    @State var spinnerEndS1: CGFloat = 0.03
    @State var rotationDegreeS1 = initialDegree
    
    var body: some View {
        ZStack {
            SpinnerCircle(start: spinnerStart, end: spinnerEndS1, rotation: rotationDegreeS1, color: .blue)
        }.frame(width: 200, height: 200, alignment: .center)
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { (mainTimer) in
                self.animateSpinner()
            }
        }
    }
    
    // MARK: Animation methods
        func animateSpinner(with timeInterval: Double, completion: @escaping (() -> Void)) {
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
                withAnimation(Animation.easeInOut(duration: rotationTime)) {
                    completion()
                }
            }
        }

        func animateSpinner() {
            animateSpinner(with: rotationTime) { self.spinnerEndS1 = 1.0 }
        }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}

struct SpinnerCircle: View {
    var start: CGFloat
    var end:CGFloat
    var rotation: Angle
    var color: Color
    
    
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}
