#version 150

in vec4 at_position;
in vec2 at_texcoord;
in vec2 at_texcoord2;
in vec4 at_color;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

out vec2 texCoord;
out vec2 lightCoord;
out vec4 vertexColor;
out vec3 viewPos;

void main() {
    vec4 view = modelViewMatrix * at_position;
    gl_Position = projectionMatrix * view;
    texCoord = at_texcoord;
    lightCoord = at_texcoord2;
    vertexColor = at_color;
    viewPos = view.xyz;
}
