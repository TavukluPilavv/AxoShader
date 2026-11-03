#version 150

in vec4 at_position;
in vec3 at_normal;
in vec2 at_texcoord;
in vec2 at_texcoord2;
in vec4 at_color;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform float frameTimeCounter;

out vec2 texCoord;
out vec2 lightCoord;
out vec4 vertexColor;
out vec3 viewNormal;

void main() {
    vec4 pos = at_position;
    // Small sway approximation; may affect non-leaf terrain too.
    float sway = sin(frameTimeCounter * 1.7 + pos.x * 0.8 + pos.z * 0.6) * 0.012;
    pos.x += sway * clamp(at_color.g, 0.0, 1.0);
    pos.z += sway * 0.35 * clamp(at_color.g, 0.0, 1.0);

    gl_Position = projectionMatrix * modelViewMatrix * pos;
    texCoord = at_texcoord;
    lightCoord = at_texcoord2;
    vertexColor = at_color;
    viewNormal = mat3(modelViewMatrix) * at_normal;
}
