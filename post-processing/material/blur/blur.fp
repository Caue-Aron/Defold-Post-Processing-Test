varying mediump vec2 var_texcoord0;
varying mediump vec2 pos;

uniform lowp sampler2D tex0;

uniform mediump vec4 BLUR_viewPort_Radius;

vec4 blur(vec2 viewPort, int radius, vec2 pos, sampler2D texture);

void main()
{
    vec2 p = var_texcoord0;
    vec4 blurF = texture2D(tex0, p);
    vec4 blurFFinal;

    vec4 pxl = texture2D(tex0, p);
    float brightness = dot(pxl.rgb, vec3(0.35, 0.35, 0.35));
    if(brightness > 1.0)
        pxl = vec4(pxl.rgb, 1.0);
    else
        pxl = vec4(0.0, 0.0, 0.0, 1.0);

    blurFFinal += texture2D(tex0, p) * pxl;

    blurF += blurFFinal;

    blurF += blur(BLUR_viewPort_Radius.xy, int(BLUR_viewPort_Radius.z), pos, tex0);

    gl_FragColor = vec4(blurF.xyz, 1);
}

vec4 blur(vec2 viewPort, int radius, vec2 pos, sampler2D texture)
{
    float xs, ys;
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
            yy=y*y;
            if (xx+yy<=rr)
            {
                w=w0*exp((-xx-yy)/(2.0*rr));
                col+=texture2D(texture,p)*w;
            }
        }
    }

    return col;
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

