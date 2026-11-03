#version 150

uniform sampler2D texture;
uniform sampler2D lightmap;

in vec2 texCoord;
in vec2 lightCoord;
in vec4 vertexColor;
in vec3 viewNormal;

out vec4 fragColor;

void main() {
    vec4 tex = texture2D(texture, texCoord) * vertexColor;
    if (tex.a < 0.1) discard;

    vec3 lm = texture2D(lightmap, lightCoord).rgb;
    vec3 n = normalize(viewNormal);
    float sunFacing = max(dot(n, normalize(vec3(0.35, 0.8, 0.25))), 0.0);
    vec3 warmSun = vec3(1.04, 1.02, 0.94);
    vec3 lit = tex.rgb * lm * mix(vec3(0.88, 0.92, 1.0), warmSun, sunFacing * 0.22);
    fragColor = vec4(lit, tex.a);
}
