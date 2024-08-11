# Detecting-Generated-Images-by-Real-Images
## Setup
python >= 3.11.9

## Make LNP dataset
We have extracted the LNP using the code in [CycleISP](https://github.com/swz30/CycleISP).  If you want to generate real images LNP and fake images LNP, please swap the positions of 0_real and 1_fake in dataset_rgb.py.
```python
python test_sidd_rgb.py
```  
## Classification
Take the produced LNP dataset and sort it using the code provided by [CNNDetection](https://github.com/peterwang512/CNNDetection).  
```python
python train.py --name model --dataroot ./dataset/ --classes airplane,bird,bicycle,boat,bottle,bus,car,cat,cow,chair,diningtable,dog,person,pottedplant,motorbike,tvmonitor,train,sheep,sofa,horse
 ```
 ## Acknowledgments
 This repository borrows content from [CycleISP](https://github.com/swz30/CycleISP), as well as the [CNNDetection](https://github.com/peterwang512/CNNDetection) repository.

 ref: https://github.com/Tangsenghenshou/Detecting-Generated-Images-by-Real-Images
