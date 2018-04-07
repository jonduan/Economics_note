import matplotlib.pyplot as plt
import numpy as np

def fieldplot(f,g,xmin,xmax,ymin,ymax,color='b',aspect=None,nx=20,boostarrows=1.):
    #plt.clf()
    #figure(figsize=(12,12))
    #figure(figsize=(8,8),facecolor='w')
    #nx = 20
    xr = xmax-xmin
    yr = ymax-ymin
    ny = int(nx*yr/xr)
    if aspect!=None:
        plt.subplot(111,aspect=aspect)
    X,Y = np.meshgrid( np.linspace(xmin,xmax,nx), np.linspace(ymin,ymax,ny) )
    X = X.flatten()
    Y = Y.flatten()
    U = f(X,Y)
    V = g(X,Y)
    #print(U)
    #print(V)
    # scale length of arrows - note arrowhead is added beyond the end of the line segment
    h = boostarrows*0.9*min(xr/float(nx-1)/abs(U).max(),yr/float(ny-1)/abs(V).max())
    Xp = X + h*U
    Yp = Y + h*V
    arrowsX = np.vstack((X,Xp))
    arrowsY = np.vstack((Y,Yp))
    head_width  = 0.005*xr
    head_length = head_width/0.6
    for x,y,u,v in zip(X,Y,U,V):
        plt.arrow( x,y, h*u,h*v, fc=color, ec=color, alpha=0.5, width=head_width/5, head_width=head_width, head_length=head_length )
    plt.xlim(xmin,xmax) # plot ranges strangely are [0,1] x [0,1] otherwise
    plt.ylim(ymin,ymax)
    
