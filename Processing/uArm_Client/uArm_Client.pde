/************************************************************************
* File Name          : uArm_Client
* Author             : Evan
* Updated            : Alex
* Version            : V0.65
* Date               : 23 Apr, 2015
* Description        : Processing to control uArm using LeapMotion
                       using the "Standard.ino" on uArm.
                       Need G4P library and LeapMotionForProcessing library.
* Update Note        : V0.6  Slider2d support Mouse move without drag. armHeight slider support Mouse wheel - 10-Apr-2015
                       V0.65 Myo Control, UDP socket Control  - 23-Apr-2015
* Copyright(C) 2014 UFactory Team. All right reserved.
*************************************************************************/

import g4p_controls.*;
import processing.serial.*;
//import de.voidplus.leapmotion.*;
//import gab.opencv.*;
//import processing.video.*;
import java.awt.*;
import javax.swing.*;
//import de.voidplus.myo.*;

boolean LEAPMOTION_EN  = false;
boolean CAMERA_EN  = false;
boolean UPDATE_EN = false;
boolean SERIAL_EN = false;
//socket control
boolean SOCKET_EN = false;
//myo control
boolean MYO_EN = false;
byte suctionCup = 0x02;
DatagramClient client = new DatagramClient();
String ip = "0.0.0.0";
int port = 0;

//Lissajous
boolean lissajous;
float period = 240;
float period2 = 160;
float amplitude = 75;  //200

public void setup()
{
  size(1000, 500, JAVA2D);
 
  createGUI();
  customGUI();
  scanPort();
  
}

public void draw()
{
  background(220);
  if(LEAPMOTION_EN)
  {
//    readLeapMotion();
  }
  if(CAMERA_EN)
  {
//    readCamera();
  }
  if(MYO_EN)
  {
//    readMyo();
  }  
  if(UPDATE_EN)
  {
    sendPos(slider2d2.getValueYI(), slider1.getValueI(), slider2d2.getValueXI(), knob1.getValueI(), suctionCup);
    label4.setText(slider2d2.getValueXS());
    label4.setTextBold();
    label5.setText(slider2d2.getValueYS());
    label5.setTextBold();
    label7.setText(knob1.getValueS());
    label7.setTextBold();
    UPDATE_EN = false;
  }
  // if(SOCKET_EN)
  // {
  //   // tf_ip_port.setEnabled(true);
  // }
  
  if(lissajous){
    float xOff = amplitude * cos(TWO_PI * frameCount / period);  
    float yOff = amplitude * cos(TWO_PI * frameCount / period2); 
    
    slider2d2.setValueX(xOff);
    slider1.setValue(35+yOff);
  }

}

void setUIPos(int _handPosX, int _handPosY, int _handPosZ, int _handRot)
{
  knob1.setValue(_handRot);
  slider1.setValue(_handPosY);
  slider2d2.setValueX(_handPosX);
  slider2d2.setValueY(_handPosZ);
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI()
{
  slider2d2.setEasing(8.0);
  frame.setTitle("uArm Control Panel");
}

void keyPressed(){
  if(key == 'l'){
    lissajous = !lissajous;
  }
}
