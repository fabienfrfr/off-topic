#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Fri Jan 17 16:26:47 2020
@author: fabien
Inspired about Thesis of Romain Pousse 2020 :
http://www.theses.fr/s180631
"""
import numpy as np, pylab as plt
from random import gauss
import matplotlib.animation as animation
import matplotlib.collections as clt

def Potential_calc(rectangleList) :
    s = rectangleList.shape
    intersect = np.unique(rectangleList.reshape(s[0]*s[1],2), axis=0)
    U = []
    for r in rectangleList :
        #Centroid for each rectangle
        Crec = np.mean(r, axis=0)
        #Euclidean distance
        d = np.linalg.norm(intersect - Crec, axis=1) # dist.cdist(intersect, Crec, 'euclidean')
        L_u = np.linalg.norm(r[1:-1]-r[0], axis=1)
        U += [np.sum(1./(d**a))*(np.max(L_u)**b)]
    return np.asarray(U)

## Init
a,b = 5,5 #2.5,2.6
sigma = 0.2

Rect = np.array([[[0.,0.],[1.51,0.],[0.,3.],[1.51,3.]],
                [[1.51,0.],[3.,0.],[1.51,3.],[3.,3.]]]) # list rectangle (taille 4/3);  struct : ori,vA,vB,vA+vB

RECT, U_ = [Rect], [] # for animation

N = 124 #nb itération
## ALGORITHME PART
for n in range(N):
    ##Calcul des potentiels pour chaque rectangle
    U = Potential_calc(Rect)
    ##Division du rectangle avec le potentiel le plus eleve
    U = np.asarray(U)
    indexU = np.where(U==U.max())
    rect_ = Rect[indexU][0]
    rect = rect_ - rect_[0] #mise à l'origine
    #plus grande longueurs
    indexL = np.where(rect[-1] == rect[-1].max())[0]
    #valeur découpage suivant loi normale
    L = rect[-1, indexL]
    div = gauss(0.5, sigma)*L
    while div >= L or div <=  0 :
        div = gauss(0.5, sigma)*L # uniformisation [-inf;+inf] -> [0;1]  (modulo 1 sinon?)
    #new rectangle
    rect1,rect2 = rect.copy(), rect.copy()
    #new values calculation (geometric problem!)
    rect1[3,indexL] = div
    rect2[0,indexL] = div
    if indexL == 1 :
        rect1[2,1] = div
        rect2[1,1] = div
    elif indexL == 0 :
        rect1[1,0] = div
        rect2[2,0] = div
    #remise à la position
    rect1, rect2 = rect1 + rect_[0], rect2 + rect_[0]
    #ajout+remplacement rectangle
    Rect[indexU] = rect1
    Rect = np.concatenate((Rect,rect2[None,]))
    # for animation :
    RECT += [Rect]
    U_ += [U]

U_ += [Potential_calc(Rect)]
U_ = np.asarray(U_)

## ANIMATION PART
def ccw_sort(p):
    mean = np.mean(p,axis=0)
    d = p-mean
    s = np.arctan2(d[:,0], d[:,1])
    return p[np.argsort(s),:]

def color_gray(U) :
    return 1 - (U / np.linalg.norm(U))

fig, ax = plt.subplots(1,1,figsize=(7,7))
ax.set_xlim(0,3)
ax.set_ylim(0,3)

patch = []
for r in RECT[0]:
    poly = plt.Polygon(ccw_sort(r))
    patch.append(poly)

collection = clt.PatchCollection(patch, cmap=plt.cm.jet, alpha=0.4)
collection.set_clim([0, 1])
collection.set_edgecolor('k')
collection.set_array(color_gray(U_[0]))
ax.add_collection(collection)

def animate(i):
    patch = []
    for r in RECT[i]:
        poly = plt.Polygon(ccw_sort(r))
        patch.append(poly)
    collection.set_paths(patch)
    collection.set_array(color_gray(U_[i]))

anim = animation.FuncAnimation(fig, animate, frames=N, interval=1000, blit=False)
anim.save('animation.gif', writer='imagemagick', fps=10)
plt.show()


