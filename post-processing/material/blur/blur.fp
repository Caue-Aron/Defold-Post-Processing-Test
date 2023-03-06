varying mediump vec2 var_texcoord0;
varying mediump vec2 pos;
uniform lowp sampler2D tex0;
uniform mediump vec4 BLUR_viewPort_Radius;

vec4 blur(vec2 viewPort, float radius, vec2 pos, sampler2D texture);

void main()
{
    vec4 finalColor = blur(BLUR_viewPort_Radius.xy, BLUR_viewPort_Radius.z, pos, tex0);


    // vec4 finalColor = texture2D(tex0,var_texcoord0);
    gl_FragColor = vec4(finalColor.xyz, 1);
}

vec4 blur(vec2 viewPort, float radius, vec2 pos, sampler2D texture)
{
    float xs, ys;            // texture resolution
    float r;                 // blur radius

    xs = viewPort.x;
    ys = viewPort.y;
    r = radius;

    float x,y,xx,yy,rr=r*r,dx,dy,w,w0;
    w0=0.25/pow(r,1.975);
    vec2 p;
    vec4 col=vec4(0.0,0.0,0.0,0.0);
    for (dx=2.0f/xs,x=-r,p.x=0.5+(pos.x*0.5)+(x*dx); x<=r;x++, p.x+=dx)
    {
        xx=x*x;
        for (dy=2.0f/ys,y=-r,p.y=0.5+(pos.y*0.5)+(y*dy); y<=r; y++,p.y+=dy)
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

