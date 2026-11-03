#version 330 compatibility

uniform sampler2D gtexture;
in vec2 texcoord;
in vec4 glcolor;

layout(location = 0) out vec4 shadowColor;

void main() {
    vec4 tex = texture(gtexture, texcoord) * glcolor;
    if (tex.a < 0.10) discard;
    shadowColor = vec4(1.0);
}
