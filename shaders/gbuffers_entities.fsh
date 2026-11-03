#version 330 compatibility

uniform sampler2D gtexture;
uniform sampler2D lightmap;

in vec2 texcoord;
in vec2 lmcoord;
in vec4 glcolor;
in vec3 viewNormal;

/* RENDERTARGETS: 0,1,2 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 lightData;
layout(location = 2) out vec4 normalData;

void main() {
    vec4 albedo = texture(gtexture, texcoord) * glcolor;
    if (albedo.a < 0.10) discard;

    color = albedo;
    lightData = vec4(texture(lightmap, lmcoord).rgb, 1.0);
    normalData = vec4(normalize(viewNormal) * 0.5 + 0.5, 1.0);
}
