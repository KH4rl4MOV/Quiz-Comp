//
//  MetalScreen.metal
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 passthrought(float2 pos, half4 color) {
    return color;
}

[[ stitchable ]] half4 recolor(float2 pos, half4 color) {
    return half4(0, 0, 0, color.a);
}


[[ stitchable ]] half4 invertAlpha(float2 pos, half4 color) {
    return half4(1, 0, 0, 1 - color.a);
}

[[ stitchable ]] half4 gradient(float2 pos, half4 color) {
    return half4(
                 pos.x / pos.y,
                 0,
                 pos.y / pos.x,
                 0
    );
}

[[ stitchable ]] half4 rainbow(float2 pos, half4 color, float time) {
    float angle = atan2(pos.y, pos.x) + time;
    return half4(
                 sin(angle),
                 sin(angle + 2),
                 sin(angle + 4),
                 color.a
    );
}

[[ stitchable ]] float2 wave(float2 pos, float time, float2 size) {
    float2 dist = pos / size;
    pos.y += sin(pos.y / 10 + time * 5) * dist.x * 10;
    return pos;
}

[[ stitchable ]] half4 loupe(float2 pos, SwiftUI::Layer l, float2 s, float2 touch) {
    float maxDist = 0.05;
    
    float2 uv = pos / s;
    float2 center = touch / s;

    float2 delta = uv - center;
    
    float aspectRation = s.x / s.y;
    
    float dist = ((delta.x * delta.x) + (delta.y * delta.y)) / aspectRation;
    
    float zoom = 1;
    
    if (dist <= maxDist) {
        zoom /= 2;
        zoom += dist * 10;
    }
    
    float2 newPos = zoom * delta + center;
    
    return l.sample(newPos * s);
    
}
