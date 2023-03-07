varying mediump vec2 var_texcoord0;
varying mediump vec2 pos;

uniform lowp sampler2D tex0;
uniform lowp sampler2D tex1;

uniform mediump vec4 BLUR_viewPort_Radius;
float weight[5] = float[] (0.227027, 0.1945946, 0.1216216, 0.054054, 0.016216);

vec4 blur(int horizontal, vec2 TexCoords, sampler2D image);

void main()
{
    vec2 p = var_texcoord0;
    vec4 blurF = blur(int(BLUR_viewPort_Radius.w), p, tex1);

    gl_FragColor = vec4(blurF.xyz, 1);
}

vec4 blur(int horizontal, vec2 TexCoords, sampler2D image)
{
    vec2 tex_offset = 2.0 / textureSize(image, 0); // gets size of single texel
    vec3 result = texture(image, TexCoords).rgb * weight[0]; // current fragment's contribution
    if(horizontal == 1)
    {
        for(int i = 1; i < 5; ++i)
        {
            result += texture(image, TexCoords + vec2(tex_offset.x * i, 0.0)).rgb * weight[i];
            result += texture(image, TexCoords - vec2(tex_offset.x * i, 0.0)).rgb * weight[i];
        }
    }
    else
    {
        for(int i = 1; i < 5; ++i)
        {
            result += texture(image, TexCoords + vec2(0.0, tex_offset.y * i)).rgb * weight[i];
            result += texture(image, TexCoords - vec2(0.0, tex_offset.y * i)).rgb * weight[i];
        }
    }

    return vec4(result, 1.0);
}
/*
vec4 blur(vec2 viewPort, int radius, vec2 pos, sampler2D texture)
{
    float xs, ys;            // texture resolution

    xs = viewPort.x;
    ys = viewPort.y;

    float x,y,xx,yy,rr=radius*radius,dx,dy,w,w0;
    w0=0.3780/pow(radius,1.975);
    vec2 p;
    vec4 col=vec4(0.0,0.0,0.0,0.0);
    for (dx=2.0f/xs,x=-radius,p.x=0.5+(pos.x*0.5)+(x*dx); x<=radius;x++, p.x+=dx)
    {
        xx=x*x;
        for (dy=2.0f/ys,y=-radius,p.y=0.5+(pos.y*0.5)+(y*dy); y<=radius; y++,p.y+=dy)
        {
            vec4 pixel = texture2D(texture, vec2(xx, yy));

            float brightness = dot(pixel.rgb, vec3(1, 1, 1));
            if(brightness > 1.0)
            {
                yy=y*y;
                if (xx+yy<=rr)
                {
                    w=w0*exp((-xx-yy)/(2.0*rr));
                    col+=texture2D(texture,p)*w;
                }
            }
        }
    }

    return col;
}
*/

