#version 330 compatibility

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

vec3 projectAndDivide(mat4 matrix, vec3 position) {
    vec4 p = matrix * vec4(position, 1.0);
    return p.xyz / max(abs(p.w), 0.00001) * sign(p.w);
}

float getShadow(vec3 screenPos) {
    if (screenPos.x < 0.0 || screenPos.x > 1.0 ||
        screenPos.y < 0.0 || screenPos.y > 1.0 ||
        screenPos.z < 0.0 || screenPos.z > 1.0) {
        return 1.0;
    }

    float storedDepth = texture(shadowtex0, screenPos.xy).r;
    float bias = 0.0018;
    return step(screenPos.z - bias, storedDepth);
}

void main() {
    color = texture(colortex0, texcoord);

    float depth = texture(depthtex0, texcoord).r;
    if (depth >= 1.0) return;

    vec3 lightmap = texture(colortex1, texcoord).rgb;
    vec3 normal = normalize(texture(colortex2, texcoord).rgb * 2.0 - 1.0);

    vec3 ndc = vec3(texcoord, depth) * 2.0 - 1.0;
    vec3 viewPos = projectAndDivide(gbufferProjectionInverse, ndc);
    vec3 playerPos = (gbufferModelViewInverse * vec4(viewPos, 1.0)).xyz;
    vec3 shadowViewPos = (shadowModelView * vec4(playerPos, 1.0)).xyz;
    vec4 shadowClip = shadowProjection * vec4(shadowViewPos, 1.0);
    vec3 shadowNdc = shadowClip.xyz / max(abs(shadowClip.w), 0.00001) * sign(shadowClip.w);
    vec3 shadowScreen = shadowNdc * 0.5 + 0.5;

    float shadow = getShadow(shadowScreen);

    // Keep block light and ambient illumination; attenuate only the sky contribution.
    float skyAmount = clamp(lightmap.g, 0.0, 1.0);
    float sunFacing = clamp(normal.y * 0.25 + 0.75, 0.0, 1.0);
    float shadowFactor = mix(1.0, mix(0.38, 1.0, shadow), skyAmount * sunFacing);

    vec3 warmDaylight = vec3(1.035, 1.015, 0.965);
    color.rgb *= mix(vec3(1.0), warmDaylight, skyAmount * 0.22);
    color.rgb *= mix(1.0, shadowFactor, 0.72);
}
