#version 150

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform float frameTimeCounter;

in vec2 texCoord;
in vec2 lightCoord;
in vec4 vertexColor;
in vec3 viewPos;

out vec4 fragColor;

void main() {
    vec2 uv = texCoord + vec2(
        sin(frameTimeCounter * 0.7 + texCoord.y * 8.0),
        cos(frameTimeCounter * 0.6 + texCoord.x * 7.0)
    ) * 0.003;
    vec4 water = texture2D(texture, uv) * vertexColor;
    vec3 lm = texture2D(lightmap, lightCoord).rgb;
    float highlight = pow(max(0.0, sin(frameTimeCounter + viewPos.x * 0.08 + viewPos.z * 0.06)), 18.0) * 0.12;
    vec3 color = water.rgb * lm + vec3(highlight);
    fragColor = vec4(color, water.a);
}
