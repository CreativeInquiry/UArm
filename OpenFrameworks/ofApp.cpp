#include "ofApp.h"
//--------------------------------------------------------------
void ofApp::setup() {
    uarm.setup("/dev/tty.usbserial-A600CRMU", 9600);
}

//--------------------------------------------------------------
// x, y, z in cylindrical coordinates, handRot in degrees
void ofApp::setArmTo(int x_l, int y_l, int z_l, int handRot_l, int gripper_l) {

    unsigned char bytes[11] = {
        0xFF,
        0xAA,
        static_cast<unsigned char>((x_l >> 8) & 0xFF),
        static_cast<unsigned char>(x_l & 0xFF),
        static_cast<unsigned char>((y_l >> 8) & 0xFF),
        static_cast<unsigned char>(y_l & 0xFF),
        static_cast<unsigned char>((z_l >> 8) & 0xFF),
        static_cast<unsigned char>(z_l & 0xFF),
        static_cast<unsigned char>((handRot_l >> 8) & 0xFF),
        static_cast<unsigned char>(handRot_l & 0xFF),
        static_cast<unsigned char>(gripper_l)
    };
    uarm.writeBytes(&bytes[0], 11);
}

void ofApp::keyPressed(int key){

    if (key == 'x'){
        x++;
    }
    if (key == 'X'){
        x--;
    }
    if (key == 'y'){
        y++;
    }
    if (key == 'Y'){
        y--;
    }
    if (key == 'z'){
        z++;
    }
    if (key == 'Z'){
        z--;
    }
    if (key == 'r'){
        handRot++;
    }
    if (key == 'R'){
        handRot--;
    }
    if (key == 'g'){
        gripper = 1;
    }
}

void ofApp::keyReleased(int key){
    if (key == 'g'){
        gripper = 2;
    }

}

void ofApp::update(){
    setArmTo(x, y, z, handRot, gripper);

}

//--------------------------------------------------------------
void ofApp::exit() {
    uarm.flush(true,true);
}