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
    float face = 0.92 + 0.08 * max(normalize(viewNormal).y, 0.0);
    fragColor = vec4(tex.rgb * lm * face, tex.a);
}
