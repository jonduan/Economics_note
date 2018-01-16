from numpy import *
import matplotlib.pyplot as plt

def dfield( slope, xmin,xmax,ymin,ymax, nx=21, woverh=1.2 ):

	#woverh = 1.2 #1. #.71 # height to width ratio of picture (a matter of taste)
	gap = 0.3    # relative gap between grid circles
  
	width = 10. # (nominal - doesn't currently have any effect)
	height = width/woverh 
	
	rx = xmax - xmin
	ry = ymax - ymin

	xfac = width /rx
	yfac = height/ry

	dpx = width /float(nx-1)   # horizontal distance between gridpoints in picture
	ny = int( floor(height/dpx) )
	dpy = height/float(ny-1)   # vertical   distance between gridpoints in picture (as close as possible to horizontal)

	xsemi = 0.5*dpx/xfac*(1.-gap)  # horizontal semi-axis of ellipses in x coordinates
	ysemi = 0.5*dpx/yfac*(1.-gap)  # vertical   semi-axis of ellipses in y coordinates
	
	x = linspace(xmin,xmax,nx)
	y = linspace(ymin,ymax,ny)
	X,Y = meshgrid(x,y)

	with errstate(divide='ignore',invalid='ignore'):	
		S = slope(X,Y)
	A = arctan( S*(xsemi/ysemi) )  
	Xplus  = ( X + xsemi*cos(A) ).reshape(nx*ny)
	Xminus = ( X - xsemi*cos(A) ).reshape(nx*ny)
	Yplus  = ( Y + ysemi*sin(A) ).reshape(nx*ny)
	Yminus = ( Y - ysemi*sin(A) ).reshape(nx*ny)
	
	plt.subplot(111, aspect = rx/woverh/float(ry) ) 

	plt.plot( array(list(zip(Xminus,Xplus))).T, array(list(zip(Yminus,Yplus))).T, color='k', alpha=0.5 )
	plt.xlim(xmin,xmax)
	plt.ylim(ymin,ymax)

if __name__ == "__main__":
	# direction field

	plt.figure(facecolor='w')

	def f(x,y): return (2*x**2*y + y)/x
	dfield( f, -1,1, -5,5, 25 )

	# solution curves
	x = linspace(-1,1,200)
	for k in range(-5,6): 
		plt.plot( x, k*x*exp(x**2), linewidth=2.5, alpha=0.5 )

	plt.xlabel('x')
	plt.ylabel('y')
	plt.show()


