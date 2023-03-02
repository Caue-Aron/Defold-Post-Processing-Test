varying mediump vec2 var_texcoord0;
varying mediump vec2 pos;
uniform lowp sampler2D tex0;
uniform mediump vec4 blurConfig;

float xs, ys;            // texture resolution
float r;                // blur radius
//---------------------------------------------------------------------------
void main()
{
    xs = blurConfig.x;
    ys = blurConfig.y;
    r = blurConfig.z;

    float x,y,xx,yy,rr=r*r,dx,dy,w,w0;
    w0=0.3780/pow(r,1.975);
    vec2 p;
    vec4 col=vec4(0.0,0.0,0.0,0.0);
    for (dx=1.0/xs,x=-r,p.x=0.5+(pos.x*0.5)+(x*dx); x<=r;x++, p.x+=dx)
    {
        xx=x*x;
        for (dy=1.0/ys,y=-r,p.y=0.5+(pos.y*0.5)+(y*dy); y<=r; y++,p.y+=dy)
        {
            yy=y*y;
            if (xx+yy<=rr)
            {
                w=w0*exp((-xx-yy)/(2.0*rr));
                col+=texture2D(tex0,p)*w;
            }
        }
    }


    gl_FragColor=col;
}

