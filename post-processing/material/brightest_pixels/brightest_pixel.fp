varying mediump vec2 var_texcoord0;
varying mediump vec2 pos;

uniform lowp sampler2D tex0;

void main()
{
    vec4 blurF = texture2D(tex0, var_texcoord0);

    vec4 pxl = blurF;
    float fac = .8;
    float brightness = dot(pxl.rgb, vec3(fac, fac, fac));
    if(brightness > 1.0)
        pxl = vec4(pxl.rgb, 1.0);
    else
        pxl = vec4(0.0, 0.0, 0.0, 1.0);

    blurF = pxl;

    gl_FragColor = vec4(blurF.xyz, 1);
}