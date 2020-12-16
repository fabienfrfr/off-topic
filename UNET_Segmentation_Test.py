#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 16 22:42:48 2020
@author: fabien
https://github.com/L42Project/
"""
import cv2, os, numpy as np, pylab as plt
from sklearn.model_selection import train_test_split
import tensorflow as tf
from tensorflow.keras import layers, models

################## PARAMETER
dir_data, dir_img, dir_mask = "./DATASET/", "images/", "labels/"
width, height, Nb_mask = 128, 128, 11 #need to (width, height) divisible 4 time (same padding)
l_batch, nbr_cycle  =  100, 20

img_test_path = '0_profils.jpg'
svg_fileout = '1_Profils-Mask.svg'

################## TRAINING FUNCTION
def Unet_model(nbr, Nb_mask, size):
    entree=layers.Input(shape=(size[0], size[1], size[2]), dtype='float32')
    
    # Start U-net operation (follow arrow, multi-lvl of input, semi-connected)
    result=layers.Conv2D(nbr, 3, activation='relu', padding='same')(entree)     #1
    result=layers.BatchNormalization()(result)                                  #1
    result=layers.Conv2D(nbr, 3, activation='relu', padding='same')(result)     #1
    result1=layers.BatchNormalization()(result)#ref                                 #1
    result=layers.MaxPool2D()(result1)                                          #1-2
    result=layers.Conv2D(2*nbr, 3, activation='relu', padding='same')(result)   #2
    result=layers.BatchNormalization()(result)                                  #2
    result=layers.Conv2D(2*nbr, 3, activation='relu', padding='same')(result)   #2
    result2=layers.BatchNormalization()(result)#ref                                 #2
    result=layers.MaxPool2D()(result2)                                          #2-3
    result=layers.Conv2D(4*nbr, 3, activation='relu', padding='same')(result)   #3
    result=layers.BatchNormalization()(result)                                  #3
    result=layers.Conv2D(4*nbr, 3, activation='relu', padding='same')(result)   #3
    result3=layers.BatchNormalization()(result)#ref                                 #3
    result=layers.MaxPool2D()(result3)                                          #3-4
    result=layers.Conv2D(4*nbr, 3, activation='relu', padding='same')(result)   #4
    result=layers.BatchNormalization()(result)                                  #4
    result=layers.Conv2D(4*nbr, 3, activation='relu', padding='same')(result)   #4
    result4=layers.BatchNormalization()(result)#ref                                 #4
    result=layers.MaxPool2D()(result4)                                          #4-5
    result=layers.Conv2D(8*nbr, 3, activation='relu', padding='same')(result)   #5
    result=layers.BatchNormalization()(result)                                  #5
    result=layers.Conv2D(4*nbr, 3, activation='relu', padding='same')(result)   #5
    result=layers.BatchNormalization()(result)                                  #5
    result=layers.UpSampling2D()(result)                                        #5-4
    result=tf.concat([result, result4], axis=3)                                 #5-4
    result=layers.Conv2D(8*nbr, 3, activation='relu', padding='same')(result)   #4
    result=layers.BatchNormalization()(result)                                  #4
    result=layers.Conv2D(4*nbr, 3, activation='relu', padding='same')(result)   #4
    result=layers.BatchNormalization()(result)                                  #4
    result=layers.UpSampling2D()(result)                                        #4-3
    result=tf.concat([result, result3], axis=3)                                 #4-3
    result=layers.Conv2D(4*nbr, 3, activation='relu', padding='same')(result)   #3
    result=layers.BatchNormalization()(result)                                  #3
    result=layers.Conv2D(2*nbr, 3, activation='relu', padding='same')(result)   #3
    result=layers.BatchNormalization()(result)                                  #3
    result=layers.UpSampling2D()(result)                                        #3-2
    result=tf.concat([result, result2], axis=3)                                 #3-2
    result=layers.Conv2D(2*nbr, 3, activation='relu', padding='same')(result)   #2
    result=layers.BatchNormalization()(result)                                  #2
    result=layers.Conv2D(nbr, 3, activation='relu', padding='same')(result)     #2
    result=layers.BatchNormalization()(result)                                  #2
    result=layers.UpSampling2D()(result)                                        #2-1
    result=tf.concat([result, result1], axis=3)                                 #2-1
    result=layers.Conv2D(nbr, 3, activation='relu', padding='same')(result)     #1
    result=layers.BatchNormalization()(result)                                  #1
    result=layers.Conv2D(nbr, 3, activation='relu', padding='same')(result)     #1
    result=layers.BatchNormalization()(result)                                  #1
    
    sortie=layers.Conv2D(Nb_mask, 1, activation='sigmoid', padding='same')(result)
    model=models.Model(inputs=entree, outputs=sortie)
    return model

################################### MODEL CONSTRUCT
try : 
    model = models.load_model('Helen-Unet')
except : 
    ################## FACE PARSING DATASET IMPORT
    # Construction of Array Dataset (Helen face dataset, FASSEG, https://www.kaggle.com/)
    tab_img, tab_mask = [], []
    for file in os.listdir(dir_data + dir_img) :
        #img
        img = cv2.imread(dir_data + dir_img +file); imShape = img.shape[:-1]
        tab_img.append(cv2.resize(img[:min(imShape),:min(imShape)], (width, height))/255)
        img_mask_result = np.zeros(shape = (height, width, Nb_mask), dtype = np.float32)
        #mask
        lab = os.listdir(dir_data + dir_mask + file.split('.')[0])
        for n in range(Nb_mask) :
            mask = np.mean(cv2.imread(dir_data + dir_mask + file.split('.')[0] + os.path.sep + lab[n]), axis=2)
            img_mask = cv2.resize(mask[:min(imShape),:min(imShape)], (width, height))
            img_mask_result[:,:,n][img_mask > 128] = 1.
        tab_mask.append(img_mask_result)
    tab_img, tab_mask = np.array(tab_img).astype(np.float32), np.array(tab_mask); print('Loading ok!')
    
    ################## TRAINING DATASET
    # Shuffle & outlier dataset (not ordered data necessary)
    train_images, test_images, train_labels, test_labels = train_test_split(tab_img, tab_mask, test_size = .05)
    del tab_img, tab_mask, test_images, test_labels
    
    # Crop data (same dimension per cycle recommanded)
    n_sample = int(len(train_images)/l_batch)
    train_images, train_labels = train_images[:n_sample*l_batch], train_labels[:n_sample*l_batch]
    
    # Initialisation of U-net Architecture (convolution neural network : "symetric" U-form) :
    model = Unet_model(64, Nb_mask, (height, width, 3))
    
    # Learning algorithme (gradiant descent form = minimize error by derivative exploration and retropropagation)
    model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])
    # Training conv-network
    model.fit(train_images, train_labels, epochs=nbr_cycle, batch_size=l_batch)
    
    # Save entire Model
    model.save('Helen-Unet')
model.summary()

################## PREDICT MASK
# Image for test
img_full = cv2.imread(os.getcwd() + os.path.sep + img_test_path)
img_test = cv2.resize(img_full, (width, height)).astype(np.float32)/255

# Predict mask
mask = np.zeros((width, height, Nb_mask), dtype=np.float32)
prediction = model.predict(np.array([img_test])) # shape = (1,w,h,3)
mask = (prediction[0]*255).astype(np.int)

# Binarisation
mask[mask < 32] = 0
mask[mask != 0] = 1
mask = np.rollaxis(mask, 2)

################## PLOT CONTOUR DETECTION
fig = plt.figure(figsize=(10, 10)) 
ax = fig.add_subplot(111)
fig.subplots_adjust(left=0, bottom=0, right=1, top=1, wspace=0, hspace=0)
plt.xticks([]), plt.yticks([])
plt.xlim(0,width); plt.ylim(0,height)

ax.spines['bottom'].set_color('None'); ax.spines['top'].set_color('None') 
ax.spines['right'].set_color('None'); ax.spines['left'].set_color('None')

# Find countour for each mask
for m in mask :
    elements = cv2.findContours(m.astype(np.uint8), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]
    for e in elements :
        xy = e.squeeze()
        ax.fill(width-xy[:,0], height-xy[:,1])
plt.savefig(svg_fileout)
