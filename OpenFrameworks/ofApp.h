#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp {

	public:
        int x = 0;
        int y = 0;
        int z = 0;
        int handRot = 0;
    
        // UArm expects 1 for an open gripper and 2 for a closed gripper
        int gripper =  2;
    
		void setup();
        void update();
		void exit();
        void keyPressed(int key);
        void keyReleased(int key);
    
		ofSerial uarm;
    
		void setArmTo(int x_l, int y_l, int z_l, int handRot_l, int gripper_l);
		
};
