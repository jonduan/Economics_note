from pylab import *
from numpy import *

def fieldplot(f,g,xmin,xmax,ymin,ymax,color='b',arrowscale=0.6,arrowheadscale=1.):
    #figure(figsize=(12,12))
    #figure(figsize=(8,8),facecolor='w')
    nx = 20
    xr = xmax-xmin
    yr = ymax-ymin
    ny = int(nx*yr/xr)
    X,Y = meshgrid( linspace(xmin,xmax,nx), linspace(ymin,ymax,ny) )
    X = X.flatten()
    Y = Y.flatten()
    U = f(X,Y)
    V = g(X,Y)
    # scale length of arrows - note arrowhead is added beyond the end of the line segment
    h = arrowscale*min(xr/float(nx-1)/abs(U).max(),yr/float(ny-1)/abs(V).max())
    Xp = X + h*U
    Yp = Y + h*V
    arrowsX = vstack((X,Xp))
    arrowsY = vstack((Y,Yp))
    for x,y,u,v in zip(X,Y,U,V):
        arrow( x,y, h*u,h*v, fc='b', ec='b', alpha=0.5, head_width=arrowheadscale*0.02, head_length=arrowheadscale*0.04 )
    xlim(xmin,xmax) # plot ranges strangely are [0,1] x [0,1] otherwise
    ylim(ymin,ymax)
    
