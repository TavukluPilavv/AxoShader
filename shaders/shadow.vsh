#version 150

in vec4 at_position;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

void main() {
    gl_Position = shadowProjection * shadowModelView * at_position;
}
