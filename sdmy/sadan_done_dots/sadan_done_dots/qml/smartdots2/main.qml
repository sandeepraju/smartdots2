import QtQuick 1.0
import "qml.js" as UI;
import "savedjsconsole.js" as D;
/**
  smartDots working
  *PROJECT: smartdots
  *AUTHORS: SANDEEP RAJU P & SADAN SOHAN M
  *PROJECT GUIDE: PROF. KRUPESHA D
  **/
/**
  *Edit Info: sandeep.raju-31.08.2011-12.04AM-(v1.0)
  *have implemented the logo rolling animation
  *main menu Cards are placed and the animation of play card is done
  **/

/**
  *Edit Info: sandeep.raju-11.09.2011-08.14PM-(v2.0)
  *have completed the menu cards movement for all the cards
  *the inner items of each card should be placed
  *Bug #1: the menu cards should be clicked only after the moving animation is completed
  *if the menu cards are clicked when the animation is still running, the flags gets corrupted and
  *as a result the cards move in an unexpected manner
  *Bug #1 Solution: until this time the solution is not known, but the basic logic is that the
  *mouse areas' of the menu cards should be activated only once the  moving animation is complete.
  *the current idea to solve this is to have a timer or something but the solution is yet unclear
  *Next Plan: The fadein and fadeout should be implemented. the two opacity number animation of playcard should
  *be renamed. And, the next menu should be implemented and then the playarea.
  **/

/**
  *Edit Info: sandeep.raju-11.09.2011-09.26PM-(v2.1)
  *have decreased the animation time from 1500ms to 300 only
  *the menu and not for the logo animation
  *this is a temporary solution for the bug #1
  *Bug #1 Soultion: Found a (hopefully) permanent solution for the bug.
  *as soon as someone clicks the menucards, all the ma's are turned off and a timer is started
  *when this is done for the time period same as that of animation time. Once this time is done, the animation is
  *complete and also the timer is triggered which sets the mouse areas back to normal.
  *the number of timers is equal to the number of menu cards.
  *
  *created a js file name 'qml.js' to implement the UI logic
  *the duration of 300 has been replaced with a js variable named UI.menuDuration to make it modular and easy to modify
  *and debug.
  **/

/**
  *Edit Info: sadan.sohan-9.10.2011-11.35PM-(v2.2)
  *have completed the entire grid
  *mouse areas of each line has to be incorporated with the relevant logic

  **/
/**
  *Edit Info: sadan.sohan-11.10.2011-10.35PM-(v2.3)
  *all the relevant logic associated with each line has been added
  *change the name of common()
  *examine the necessity of pleasework() and change its name
  *examine the necessity of tolosewinTimer used in common()
  **/

/**
  *Edit Info: sandeepraju-25.11.2011-10.52AM-(v2.4)
  *The sdots and rdots buttons have been added to help card and exit card
  *The about info pic has been added
  *The 'are you sure' text and yes/no button has been added to the menu
  *
  *The fade in and  out of the buttons has to be done. (!important)
  *HighScores has to be implemented by Sadan Sohan
  *when the user clicks NO in exit, the play menu should appear.. (!important)
  **/

/**
  *Edit Info: sandeepraju-26.11.2011-02.03PM-(v2.5)
  *The Start menu is complete (phew!)
  *Get set go area has been implemented but not yet connected
  *Review the use of fadeout during start and back instead of opacity = 0
  *The final ending menu has to be done
  *The dots have to be replaced and main background has to replaced
  **/






Rectangle {
    id: rect
    width: 640
    height: 360
    //Vivek Editing
    /** List View for SmartDots Help
     * This contains the help text related to the game SmartDots
     */
    ListView {
                id: helpListView
                x: 0
                y: 0
                width: 640
                height: 360
                opacity: 0
                model: helpModel
                delegate: Text {
                    x: 150
                    text: helpFile
                    font.pixelSize: 20
                }
            }

            ListModel {
                id: helpModel
                ListElement {
                    helpFile : "
                    <pre align='right'><b>
                    SMART DOTS

                    Your aim is to get maximum boxes
                    in this game. To accomplish this,
                    you have to create boxes by drawing
                    lines between the dots.
                    This can be done by touching between
                    the dots. 2 players play the game
                    where they take turns to draw lines.
                    Make sure you draw lines in a manner
                    in which your opponent does not get
                    a chance to complete a box or else you
                    lose that box to your opponent. Be wary
                    of intelligent moves but also hope for
                    random mistakes by your opponents.
                    You can choose to play against a
                    friend or against your phone.

                    REMEMBER THAT YOU NEED TO TOUCH
                    BETWEEN THE DOTS TO DRAW A LINE
                    BETWEEN THE DOTS.

                    Go make yourself proud!
                    </b>
                                                </pre>

                    "

              }
            }

            /** List View for ReverseDots Help
             * This contains the help text related to the game ReverseDots
             **/
            ListView {
                        id: helpRListView
                        x: 0
                        y: 0
                        width: 640
                        height: 360
                        opacity: 0
                        model: helpRModel
                        delegate: Text {
                            x:70
                            text: helpRFile
                            font.pixelSize: 20
                        }
                    }

                    ListModel {
                        id: helpRModel
                        ListElement {
                            helpRFile : "<pre align='right'>

                            <b>
                            REVERSE DOTS

                            This is a game similar to SmartDots.
                            The objective here is to make sure
                            your opponent gets maximum boxes.
                            Yes,you got it right.
                            It is SmartDots with a twist.
                            You have to make sure you draw lines
                            between the dots in a manner in which
                            you allow your opponent to complete boxes.
                            But the only condition is that you yourself
                            must have atleast 4 boxes,6 and 8 boxes
                            in the beginner,intermediate and expert
                            levels respectively.
                            Again, intelligent moves and random
                            mistakes are the flavors of this game.
                            Battle it out against your friend or
                            against your phone.
                            When you play against your friend,
                            make sure you atleast have 5 boxes.

                            REMEMBER AGAIN TO TOUCH BETWEEN DOTS.

                            Constant vigilance!!
                            </b>
                            </pre>"

                      }
                    }
    //Vivek editing end
    Timer {
           id:getSetGoTimer
           interval: 1000
           running: false
           repeat: true
           onTriggered: {
               if(D.playmode == 1)
               {
                   scoreL.text = ""+"PLAYER 1";
                   scoreR.text = ""+"PLAYER 2";
               }
               else
               {
                   scoreL.text = ""+"PLAYER";
                   scoreR.text = ""+"PHONE";
               }
               rect.state = "playArea"
               getSetGoTimer.stop();

           }
    }

    Timer {
           interval: 5000
           running: true
           id:tolosewinTimer
           repeat: true
           onTriggered: {
               console.log(D.count1+D.count2);
               if(D.count1 + D.count2 == 18) {
                   tolosewinTimer.stop();

                   rect.state = "aboutMenu"
                   if(D.dotsMode == 1) {
                       if(D.count1>D.count2)
                       {

                           D.greater = D.count1;

                           if(D.playmode == 1) {
                               console.log("PLAYER - 1 WON")

                                rect.state = "endmenu";
                               p1win.opacity = 1;
                               //things to be done when game finishes and upon jumping to endmenu - START
                               endCardDown.running = true;
                               //things to be done when game finishes and upon jumping to endmenu - END
                              /* trophy.z=0;
                               playAgain.z=5;
                               losewinquit.z=0;
                               btmm.z=0;
                               lost.z=0;
                               youwin.z=0
                               p1Wins.z=5
                               p2Wins.z=0
                               gameDraw.z=0*/
                           }
                           else {
                               highscore(0);
                               if(D.count1>=D.highScoreValue)
                               {

                               console.log("YOU WON")
                                rect.state = "endmenu"
                                highwin.opacity = 1;
                               //things to be done when game finishes and upon jumping to endmenu - START
                               endCardDown.running = true;
                               //things to be done when game finishes and upon jumping to endmenu - END
                              /* trophy.z=5;
                               playAgain.z=5;
                               losewinquit.z=0;
                               btmm.z=0;
                               lost.z=0;
                               youwin.z=5
                               p1Wins.z=0
                               p2Wins.z=0
                               gameDraw.z=0*/
                               }
                               else
                               {

                                   rect.state = "endmenu"
                                   win.opacity = 1;
                                  //things to be done when game finishes and upon jumping to endmenu - START
                                  endCardDown.running = true;
                               }
                               }

                       }
                       else if(D.count1 == D.count2) {
                            D.greater = D.count1;

                            highscore(0);

                           console.log("Game Drawed")
                            rect.state = "endmenu"
                           draw.opacity = 1;
                           //things to be done when game finishes and upon jumping to endmenu - START
                           endCardDown.running = true;
                           //things to be done when game finishes and upon jumping to endmenu - END
                          /* trophy.z=0;
                           playAgain.z=5;
                           losewinquit.z=0;
                           btmm.z=0;
                           lost.z=0;
                           youwin.z=0
                           p1Wins.z=0
                           p2Wins.z=0
                           gameDraw.z=5*/
                       }

                       else {

                           if(D.playmode == 1) {
                               D.greater = D.count2;
                                highscore(0);

                               console.log("PLAYER - 2 WON")
                                rect.state = "endmenu"
                                p2win.opacity = 1;
                               //things to be done when game finishes and upon jumping to endmenu - START
                               endCardDown.running = true;
                               //things to be done when game finishes and upon jumping to endmenu - END
                              /* trophy.z=0;
                               playAgain.z=5;
                               losewinquit.z=0;
                               btmm.z=0;
                               lost.z=0;
                               youwin.z=0
                               p1Wins.z=0
                               p2Wins.z=5
                               gameDraw.z=0*/

                           }
                           else {

                               console.log("YOU LOST ..beginner")
                                rect.state = "endmenu"
                                lose.opacity = 1;
                               //things to be done when game finishes and upon jumping to endmenu - START
                               endCardDown.running = true;
                               //things to be done when game finishes and upon jumping to endmenu - END
                              /* trophy.z=0;
                               playAgain.z=5;
                               losewinquit.z=0;
                               btmm.z=0;
                               lost.z=5;
                               youwin.z=0*/


                           }

                       }
                   }
                   else if(D.dotsMode == 2) {
                       if(D.count1<D.count2)
                       {

                           if(D.playmode == 1) {
                               if(D.count1>=5)
                               {

                               console.log("PLAYER - 1 WON")

                                rect.state = "endmenu"
                                p1win.opacity = 1;
                               //things to be done when game finishes and upon jumping to endmenu - START
                               endCardDown.running = true;
                               //things to be done when game finishes and upon jumping to endmenu - END
                              /* trophy.z=0;
                               playAgain.z=5;
                               losewinquit.z=0;
                               btmm.z=0;
                               lost.z=0;
                               youwin.z=0
                               p1Wins.z=5
                               p2Wins.z=0
                               gameDraw.z=0*/
                               }
                               else
                               {

                               console.log("PLAYER - 1 WON")

                                rect.state = "endmenu"
                                 p2win.opacity = 1;
                               //things to be done when game finishes and upon jumping to endmenu - START
                               endCardDown.running = true;
                               }
                           }
                           else {

                               if(D.level == 1)
                               {
                                   if(D.count1>=4)
                                   {

                                       console.log("YOU WON")
                                        rect.state = "endmenu"
                                        win.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                      /* trophy.z=5;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=0;
                                       youwin.z=5
                                       p1Wins.z=0
                                       p2Wins.z=0
                                       gameDraw.z=0*/
                                   }
                                   else
                                   {

                                       console.log("YOU LOST")
                                       rect.state = "endmenu"
                                       lose.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                     /*  trophy.z=0;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=5;
                                       youwin.z=0*/

                                   }
                               }

                               if(D.level == 2)
                               {
                                   if(D.count1>=6)
                                   {

                                       console.log("YOU WON")
                                        rect.state = "endmenu"
                                       win.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                      /* trophy.z=5;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=0;
                                       youwin.z=5
                                       p1Wins.z=0
                                       p2Wins.z=0
                                       gameDraw.z=0*/
                                   }
                                   else
                                   {

                                       console.log("YOU LOST")
                                       rect.state = "endmenu"
                                       lose.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                     /*  trophy.z=0;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=5;
                                       youwin.z=0*/

                                   }
                               }

                               if(D.level == 3)
                               {
                                   if(D.count1>=8)
                                   {

                                       console.log("YOU WON")
                                        rect.state = "endmenu"
                                       win.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                      /* trophy.z=5;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=0;
                                       youwin.z=5
                                       p1Wins.z=0
                                       p2Wins.z=0
                                       gameDraw.z=0*/
                                   }
                                   else
                                   {

                                       console.log("YOU LOST")
                                       rect.state = "endmenu"
                                       lose.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                     /*  trophy.z=0;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=5;
                                       youwin.z=0*/

                                   }
                               }


                               }

                       }
                       else if(D.count1 == D.count2) {

                           console.log("Game Drawed")
                            rect.state = "endmenu"
                           draw.opacity = 1;
                           //things to be done when game finishes and upon jumping to endmenu - START
                           endCardDown.running = true;
                           //things to be done when game finishes and upon jumping to endmenu - END
                          /* trophy.z=0;
                           playAgain.z=5;
                           losewinquit.z=0;
                           btmm.z=0;
                           lost.z=0;
                           youwin.z=0
                           p1Wins.z=0
                           p2Wins.z=0
                           gameDraw.z=5*/
                       }

                       else {
                           if(D.playmode == 1) {
                               if(D.count2>=5)
                               {

                               console.log("PLAYER - 2 WON")
                               rect.state = "endmenu"
                               p2win.opacity = 1;
                               //things to be done when game finishes and upon jumping to endmenu - START
                               endCardDown.running = true;
                               //things to be done when game finishes and upon jumping to endmenu - END
                               /*trophy.z=0;
                               playAgain.z=5;
                               losewinquit.z=0;
                               btmm.z=0;
                               lost.z=0;
                               youwin.z=0
                               p1Wins.z=0
                               p2Wins.z=5
                               gameDraw.z=0*/
                               }
                               else
                               {

                                   console.log("YOU LOST")
                                   rect.state = "endmenu"
                                    p1win.opacity = 1;
                                   //things to be done when game finishes and upon jumping to endmenu - START
                                   endCardDown.running = true;
                                   //things to be done when game finishes and upon jumping to endmenu - END
                                 /*  trophy.z=0;
                                   playAgain.z=5;
                                   losewinquit.z=0;
                                   btmm.z=0;
                                   lost.z=5;
                                   youwin.z=0*/
                               }

                           }
                           else {

                               if(D.level == 1)
                               {
                                   if(D.count2<4)
                                   {

                                       console.log("YOU WON")
                                        rect.state = "endmenu"
                                       win.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                      /* trophy.z=5;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=0;
                                       youwin.z=5
                                       p1Wins.z=0
                                       p2Wins.z=0
                                       gameDraw.z=0*/
                                   }
                                   else
                                   {

                                       console.log("YOU LOST")
                                       rect.state = "endmenu"
                                       lose.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                     /*  trophy.z=0;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=5;
                                       youwin.z=0*/

                                   }
                               }

                               if(D.level == 2)
                               {
                                   if(D.count2<6)
                                   {

                                       console.log("YOU WON")
                                        rect.state = "endmenu"
                                       win.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                      /* trophy.z=5;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=0;
                                       youwin.z=5
                                       p1Wins.z=0
                                       p2Wins.z=0
                                       gameDraw.z=0*/
                                   }
                                   else
                                   {

                                       console.log("YOU LOST")
                                       rect.state = "endmenu"
                                       lose.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                     /*  trophy.z=0;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=5;
                                       youwin.z=0*/

                                   }
                               }

                               if(D.level == 3)
                               {
                                   if(D.count2<8)
                                   {

                                       console.log("YOU WON")
                                        rect.state = "endmenu"
                                        win.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                      /* trophy.z=5;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=0;
                                       youwin.z=5
                                       p1Wins.z=0
                                       p2Wins.z=0
                                       gameDraw.z=0*/
                                   }
                                   else
                                   {

                                       console.log("YOU LOST")
                                       rect.state = "endmenu"
                                       lose.opacity = 1;
                                       //things to be done when game finishes and upon jumping to endmenu - START
                                       endCardDown.running = true;
                                       //things to be done when game finishes and upon jumping to endmenu - END
                                     /*  trophy.z=0;
                                       playAgain.z=5;
                                       losewinquit.z=0;
                                       btmm.z=0;
                                       lost.z=5;
                                       youwin.z=0*/

                                   }
                               }

                           }

                       }

                   }

               }
           }
       }




    function common()
    {
        D.f();
        console.log(D.count1);
        line1.color = "#2c2c2c"
        line1.opacity = 0.5;
        line2.color = "#2c2c2c"
        line2.opacity = 0.5;
        line3.color = "#2c2c2c"
        line3.opacity = 0.5;
        line4.color = "#2c2c2c"
        line4.opacity = 0.5;
        line5.color = "#2c2c2c"
        line5.opacity = 0.5;
        line6.color = "#2c2c2c"
        line6.opacity = 0.5;
        line7.color = "#2c2c2c"
        line7.opacity = 0.5;
        line8.color = "#2c2c2c"
        line8.opacity = 0.5;
        line9.color = "#2c2c2c"
        line9.opacity = 0.5;
        line10.color = "#2c2c2c"
        line10.opacity = 0.5;
        line11.color = "#2c2c2c"
        line11.opacity = 0.5;
        line12.color = "#2c2c2c"
        line12.opacity = 0.5;
        line13.color = "#2c2c2c"
        line13.opacity = 0.5;
        line14.color = "#2c2c2c"
        line14.opacity = 0.5;
        line15.color = "#2c2c2c"
        line15.opacity = 0.5;
        line16.color = "#2c2c2c"
        line16.opacity = 0.5;
        line17.color = "#2c2c2c"
        line17.opacity = 0.5;
        line18.color = "#2c2c2c"
        line18.opacity = 0.5;
        line19.color = "#2c2c2c"
        line19.opacity = 0.5;
        line20.color = "#2c2c2c"
        line20.opacity = 0.5;
        line21.color = "#2c2c2c"
        line21.opacity = 0.5;
        line22.color = "#2c2c2c"
        line22.opacity = 0.5;
        line23.color = "#2c2c2c"
        line23.opacity = 0.5;
        line24.color = "#2c2c2c"
        line24.opacity = 0.5;

        vline1.color = "#2c2c2c"
        vline1.opacity = 0.5;
        vline2.color = "#2c2c2c"
        vline2.opacity = 0.5;
        vline3.color = "#2c2c2c"
        vline3.opacity = 0.5;
        vline4.color = "#2c2c2c"
        vline4.opacity = 0.5;
        vline5.color = "#2c2c2c"
        vline5.opacity = 0.5;
        vline6.color = "#2c2c2c"
        vline6.opacity = 0.5;
        vline7.color = "#2c2c2c"
        vline7.opacity = 0.5;
        vline8.color = "#2c2c2c"
        vline8.opacity = 0.5;
        vline9.color = "#2c2c2c"
        vline9.opacity = 0.5;
        vline10.color = "#2c2c2c"
        vline10.opacity = 0.5;
        vline11.color = "#2c2c2c"
        vline11.opacity = 0.5;
        vline12.color = "#2c2c2c"
        vline12.opacity = 0.5;
        vline13.color = "#2c2c2c"
        vline13.opacity = 0.5;
        vline14.color = "#2c2c2c"
        vline14.opacity = 0.5;
        vline15.color = "#2c2c2c"
        vline15.opacity = 0.5;
        vline16.color = "#2c2c2c"
        vline16.opacity = 0.5;
        vline17.color = "#2c2c2c"
        vline17.opacity = 0.5;
        vline18.color = "#2c2c2c"
        vline18.opacity = 0.5;
        vline19.color = "#2c2c2c"
        vline19.opacity = 0.5;
        vline20.color = "#2c2c2c"
        vline20.opacity = 0.5;
        vline21.color = "#2c2c2c"
        vline21.opacity = 0.5;

        rectangle1.color = "#ffffff"
        rectangle2.color = "#ffffff"
        rectangle3.color = "#ffffff"
        rectangle4.color = "#ffffff"
        rectangle5.color = "#ffffff"
        rectangle6.color = "#ffffff"
        rectangle7.color = "#ffffff"
        rectangle8.color = "#ffffff"
        rectangle9.color = "#ffffff"
        rectangle10.color = "#ffffff"
        rectangle11.color = "#ffffff"
        rectangle12.color = "#ffffff"
        rectangle13.color = "#ffffff"
        rectangle14.color = "#ffffff"
        rectangle15.color = "#ffffff"
        rectangle16.color = "#ffffff"
        rectangle17.color = "#ffffff"
        rectangle18.color = "#ffffff"
        scoreNumL.text = "0"
        scoreNumR.text = "0"
        tolosewinTimer.running = true
    }

    function highscore(flag)
    {
    var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);
    db.transaction(
                     function(tx) {
                         tx.executeSql("CREATE TABLE IF NOT EXISTS HighScore(mode TEXT,score TEXT)");
                         var rs1= tx.executeSql("SELECT * FROM HighScore");
                        if(rs1.rows.length == 0)
                        {
                        tx.executeSql("INSERT into HighScore VALUES('BEGINNER\n',0)");
                            tx.executeSql("INSERT into HighScore VALUES('INTERMEDIATE\n',0)");
                         tx.executeSql("INSERT into HighScore VALUES('EXPERT\n',0)");
                        }

                        if(flag==0)
                        {

                            if(D.level == 1)
                            {
                         var rs= tx.executeSql("SELECT * FROM HighScore");
                        if(D.greater > rs.rows.item(0).score)
                        {
                              console.log("rows="+rs.rows.length );
                         // Create the database if it doesn't already exist
                            console.log(D.greater)


                            tx.executeSql("UPDATE HighScore set score=? where mode ='BEGINNER\n'",[D.greater]);
                            var ars= tx.executeSql("SELECT * FROM HighScore");
                        }
                        D.highScoreValue = rs.rows.item(0).score;
                         }

                            if(D.level == 2)
                            {
                                var rs= tx.executeSql("SELECT * FROM HighScore");
                               if(D.greater > rs.rows.item(1).score)
                               {

                                // Create the database if it doesn't already exist
                                   console.log(D.greater)


                                   tx.executeSql("UPDATE HighScore set score=? where mode ='INTERMEDIATE\n'",[D.greater]);

                               }
                                D.highScoreValue = rs.rows.item(1).score;
                            }
                            if(D.level == 3)
                            {
                                var rs= tx.executeSql("SELECT * FROM HighScore");
                               if(D.greater > rs.rows.item(2).score)
                               {

                                // Create the database if it doesn't already exist
                                   console.log(D.greater)


                                   tx.executeSql("UPDATE HighScore set score=? where mode ='EXPERT\n'",[D.greater]);
                               }
                                D.highScoreValue = rs.rows.item(2).score;
                            }

                       }
                        else if(flag==1)
                        {
                            console.log("flag = 1");
                            //tx.executeSql("DROP TABLE HighScore");
                          D.s = tx.executeSql("Select * From HighScore");
                            highScoreBeginner.text ="BEGINNER\n"+ D.s.rows.item(0).score;

                            highScoreIntermediate.text="INTERMEDIATE\n"+D.s.rows.item(1).score;
                            highScoreExpert.text = "EXPERT\n"+D.s.rows.item(2).score;

                        }






                        console.log(highScoreBeginner.text);



                        console.log("in highSCORE");
                       // highScoreBeginner.visible = "true";

                         }


    )
    }

   /* function drawLine(x,y,a,b)
    {
        if(x==a)
        {
            if(x==1)
            {
                if(y==1)

                {  console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line1.color ="#af12fe";
                    line1.opacity=1
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle1.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle1.color="#ff0000"
                    }


                }

                if(y==2)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line2.color ="#af12fe";
                    line2.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle2.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle2.color="#ff0000"
                    }


                }


                if(y==3 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line3.color ="#af12fe";
                    line3.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle3.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle3.color="#ff0000"
                    }


                }




                if(y==4)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line4.color ="#af12fe";
                    line4.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle4.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle4.color="#ff0000"
                    }


                }



                if(y==5 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line5.color ="#af12fe";
                    line5.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle5.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle5.color="#ff0000"
                    }


                }



                if(y==6 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line6.color ="#af12fe";
                    line6.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle6.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle6.color="#ff0000"
                    }


                }


            }
            if(x==2)
            {
                if(y==1 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin1")
                    line7.color ="#af12fe";
                    line7.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle1.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle7.color="#ff0000"
                    }


                }

                if(y==2 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b+"line2")
                    line8.color ="#af12fe";
                    line8.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle2.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle8.color="#ff0000"
                    }


                }



                if(y==3 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin3")

                    line9.color ="#af12fe";
                    line9.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle3.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle9.color="#ff0000"
                    }


                }



                if(y==4)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin4")
                    line10.color ="#af12fe";
                    line10.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle4.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle10.color="#ff0000"
                    }


                }


                if(y==5 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin5")

                    line11.color ="#af12fe";
                    line11.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle5.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle11.color="#ff0000"
                    }


                }


                if(y==6 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin6")
                    line12.color ="#af12fe";
                    line12.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle6.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle12.color="#ff0000"
                    }



                }


            }
            if(x==3)
            {
                if(y==1)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line13.color ="#af12fe";
                    line13.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle7.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle13.color="#ff0000"
                    }


                }

                if(y==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line14.color ="#af12fe";
                    line14.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle8.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle14.color="#ff0000"
                    }


                }



                if(y==3 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line15.color ="#af12fe";
                    line15.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle9.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle15.color="#ff0000"
                    }


                }


                if(y==4 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line16.color ="#af12fe";
                    line16.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle10.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle16.color="#ff0000"
                    }


                }



                if(y==5  )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line17.color ="#af12fe";
                    line17.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle11.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle17.color="#ff0000"
                    }


                }



                if(y==6  )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line18.color ="#af12fe";
                    line18.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle12.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle18.color="#ff0000"
                    }


                }


            }
            if(x==4)
            {
                if(y==1 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line19.color ="#af12fe";
                    line19.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle13.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle19.color="#ff0000"
                    }


                }

                if(y==2 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line20.color ="#af12fe";
                    line20.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle14.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle20.color="#ff0000"
                    }


                }



                if(y==3 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line21.color ="#af12fe";
                    line21.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle15.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle21.color="#ff0000"
                    }


                }



                if(y==4 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line22.color ="#af12fe";
                    line22.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle16.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle22.color="#ff0000"
                    }


                }



                if(y==5  )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line23.color ="#af12fe";
                    line23.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle17.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle23.color="#ff0000"
                    }


                }

                if(y==6)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line24.color ="#af12fe";
                    line24.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle18.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle24.color="#ff0000"
                    }


                }

            }

        }
        if(y==b)
        {
            if(y==1)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline1.color ="#af12fe";
                    vline1.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle1.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle1.color="#ff0000"
                    }


                }

                if(x==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline8.color ="#af12fe";
                    vline8.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle7.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle7.color="#ff0000"
                    }


                }



                if(x==3 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline15.color ="#af12fe";
                    vline15.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle13.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle13.color="#ff0000"
                    }


                }


            }
            if(y==2)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline2.color ="#af12fe";
                    vline2.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle2.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle1.color="#ff0000"
                    }


                }
                if(x==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline9.color ="#af12fe";
                    vline9.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle8.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle7.color="#ff0000"
                    }


                }


                if(x==3 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline16.color ="#af12fe";
                    vline16.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle14.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle13.color="#ff0000"
                    }


                }


            }
            if(y==3)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline3.color ="#af12fe";
                    vline3.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle3.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle2.color="#ff0000"
                    }


                }
                if(x==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline10.color ="#af12fe";
                    vline10.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle9.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle8.color="#ff0000"
                    }


                }


                if(x==3  )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline17.color ="#af12fe";
                    vline17.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle15.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle14.color="#ff0000"
                    }


                }

            }
            if(y==4)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline4.color ="#af12fe";
                    vline4.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle4.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle3.color="#ff0000"
                    }


                }
                if(x==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline11.color ="#af12fe";
                    vline11.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle10.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle9.color="#ff0000"
                    }


                }

                if(x==3 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline18.color ="#af12fe";
                    vline18.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle16.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle15.color="#ff0000"
                    }


                }


            }
            if(y==5)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline5.color ="#af12fe";
                    vline5.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle5.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle4.color="#ff0000"
                    }


                }
                if(x==2)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline12.color ="#af12fe";
                    vline12.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle11.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle10.color="#ff0000"
                    }


                }


                if(x==3)
                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    vline19.color ="#af12fe";
                    vline19.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle17.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle16.color="#ff0000"
                    }


                }
            }
            if(y==6)
            {
                if(x==1)
                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    vline6.color ="#af12fe";
                    vline6.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle6.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle5.color="#ff0000"
                    }


                }
                if(x==2)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline13.color ="#af12fe";
                    vline13.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle12.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle11.color="#ff0000"
                    }


                }
                if(x==3)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline20.color ="#af12fe";
                    vline20.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle18.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle17.color="#ff0000"
                    }


                }
            }
            if(y==7)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline7.color ="#af12fe";
                    vline7.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle6.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle6.color="#ff0000"
                    }


                }
                if(x==2)
                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    vline14.color ="#af12fe";
                    vline14.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle12.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle12.color="#ff0000"
                    }


                }
                if(x==3)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline21.color ="#af12fe";
                    vline21.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle18.color="#ff0000"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle18.color="#ff0000"
                    }


                }
            }
        }
    }*/

    function drawLine(x,y,a,b)
    {
        if(x==a)
        {
            if(x==1)
            {
                if(y==1)

                {  console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line1.color ="#af12fe";
                    line1.opacity=1
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle1.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle1.color="#af12fe"
                    }


                }

                if(y==2)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line2.color ="#af12fe";
                    line2.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle2.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle2.color="#af12fe"
                    }


                }


                if(y==3 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line3.color ="#af12fe";
                    line3.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle3.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle3.color="#af12fe"
                    }


                }




                if(y==4)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line4.color ="#af12fe";
                    line4.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle4.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle4.color="#af12fe"
                    }


                }



                if(y==5 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line5.color ="#af12fe";
                    line5.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle5.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle5.color="#af12fe"
                    }


                }



                if(y==6 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line6.color ="#af12fe";
                    line6.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle6.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle6.color="#af12fe"
                    }


                }


            }
            if(x==2)
            {
                if(y==1 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin1")
                    line7.color ="#af12fe";
                    line7.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle1.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle7.color="#af12fe"
                    }


                }

                if(y==2 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b+"line2")
                    line8.color ="#af12fe";
                    line8.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle2.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle8.color="#af12fe"
                    }


                }



                if(y==3 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin3")

                    line9.color ="#af12fe";
                    line9.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle3.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle9.color="#af12fe"
                    }


                }



                if(y==4)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin4")
                    line10.color ="#af12fe";
                    line10.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle4.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle10.color="#af12fe"
                    }


                }


                if(y==5 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin5")

                    line11.color ="#af12fe";
                    line11.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle5.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle11.color="#af12fe"
                    }


                }


                if(y==6 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b+"lin6")
                    line12.color ="#af12fe";
                    line12.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle6.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle12.color="#af12fe"
                    }



                }


            }
            if(x==3)
            {
                if(y==1)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line13.color ="#af12fe";
                    line13.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle7.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle13.color="#af12fe"
                    }


                }

                if(y==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line14.color ="#af12fe";
                    line14.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle8.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle14.color="#af12fe"
                    }


                }



                if(y==3 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line15.color ="#af12fe";
                    line15.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle9.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle15.color="#af12fe"
                    }


                }


                if(y==4 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line16.color ="#af12fe";
                    line16.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle10.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle16.color="#af12fe"
                    }


                }



                if(y==5  )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line17.color ="#af12fe";
                    line17.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle11.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle17.color="#af12fe"
                    }


                }



                if(y==6  )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line18.color ="#af12fe";
                    line18.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle12.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle18.color="#af12fe"
                    }


                }


            }
            if(x==4)
            {
                if(y==1 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line19.color ="#af12fe";
                    line19.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle13.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle19.color="#af12fe"
                    }


                }

                if(y==2 )

                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    line20.color ="#af12fe";
                    line20.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle14.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle20.color="#af12fe"
                    }


                }



                if(y==3 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line21.color ="#af12fe";
                    line21.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle15.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle21.color="#af12fe"
                    }


                }



                if(y==4 )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line22.color ="#af12fe";
                    line22.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle16.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle22.color="#af12fe"
                    }


                }



                if(y==5  )

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line23.color ="#af12fe";
                    line23.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle17.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle23.color="#af12fe"
                    }


                }

                if(y==6)

                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    line24.color ="#af12fe";
                    line24.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle18.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle24.color="#af12fe"
                    }


                }

            }

        }
        if(y==b)
        {
            if(y==1)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline1.color ="#af12fe";
                    vline1.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle1.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle1.color="#af12fe"
                    }


                }

                if(x==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline8.color ="#af12fe";
                    vline8.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle7.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle7.color="#af12fe"
                    }


                }



                if(x==3 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline15.color ="#af12fe";
                    vline15.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle13.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle13.color="#af12fe"
                    }


                }


            }
            if(y==2)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline2.color ="#af12fe";
                    vline2.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle2.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle1.color="#af12fe"
                    }


                }
                if(x==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline9.color ="#af12fe";
                    vline9.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle8.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle7.color="#af12fe"
                    }


                }


                if(x==3 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline16.color ="#af12fe";
                    vline16.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle14.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle13.color="#af12fe"
                    }


                }


            }
            if(y==3)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline3.color ="#af12fe";
                    vline3.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle3.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle2.color="#af12fe"
                    }


                }
                if(x==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline10.color ="#af12fe";
                    vline10.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle9.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle8.color="#af12fe"
                    }


                }


                if(x==3  )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline17.color ="#af12fe";
                    vline17.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle15.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle14.color="#af12fe"
                    }


                }

            }
            if(y==4)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline4.color ="#af12fe";
                    vline4.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle4.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle3.color="#af12fe"
                    }


                }
                if(x==2 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline11.color ="#af12fe";
                    vline11.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle10.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle9.color="#af12fe"
                    }


                }

                if(x==3 )
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline18.color ="#af12fe";
                    vline18.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle16.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle15.color="#af12fe"
                    }


                }


            }
            if(y==5)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline5.color ="#af12fe";
                    vline5.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle5.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle4.color="#af12fe"
                    }


                }
                if(x==2)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline12.color ="#af12fe";
                    vline12.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle11.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle10.color="#af12fe"
                    }


                }


                if(x==3)
                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    vline19.color ="#af12fe";
                    vline19.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle17.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle16.color="#af12fe"
                    }


                }
            }
            if(y==6)
            {
                if(x==1)
                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    vline6.color ="#af12fe";
                    vline6.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle6.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle5.color="#af12fe"
                    }


                }
                if(x==2)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline13.color ="#af12fe";
                    vline13.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle12.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle11.color="#af12fe"
                    }


                }
                if(x==3)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline20.color ="#af12fe";
                    vline20.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle18.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle17.color="#af12fe"
                    }


                }
            }
            if(y==7)
            {
                if(x==1)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline7.color ="#af12fe";
                    vline7.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle6.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle6.color="#af12fe"
                    }


                }
                if(x==2)
                {console.log("x"+x,"y"+y,"a"+a,"b"+b)

                    vline14.color ="#af12fe";
                    vline14.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle12.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle12.color="#af12fe"
                    }


                }
                if(x==3)
                {
                    console.log("x"+x,"y"+y,"a"+a,"b"+b)
                    vline21.color ="#af12fe";
                    vline21.opacity=1;
                    if(D.winnerFlag1==1)
                    {
                        D.winnerFlag1=0;
                        rectangle18.color="#af12fe"
                    }

                    if(D.winnerFlag2==1)
                    {
                        D.winnerFlag2=0;
                        rectangle18.color="#af12fe"
                    }


                }
            }
        }
    }

    Timer {
        id:start
        running: true
        interval: 500;
        onTriggered: {
            console.log(UI.menuDuration);
            D.f();
            highscore(1);
            rect.state = "smartdots";
            //smartdots logo rolls in. duration 1500ms
            //start a timer here to wait for 2500ms for the animation to complete and the main menu to appear
            towardsMainMenu.running = true;
        }
    }

    Timer {
        id:towardsMainMenu
        //this timer waits for 2500ms and when triggered moves to main menu
        running:false
        interval: 2500
        onTriggered: {
            //jump to main menu (logo animation is over)
            rect.state = "mainmenu";
            playmoveR.running = true;    //running the playCard movement
            ///////////sdotsopacity.running = true;    //running the play smartdots opacity
            ///////////rdotsopacity.running = true;    //running the play reversedots opacity
            //deactivate play ma
            maPlay.opacity = 0;
            //activate all other ma
            maHelp.opacity = 1;
            maAbout.opacity = 1;
            maHighscores.opacity = 1;
            maExit.opacity = 1;

            //everything's else contents fadeout
            aysfadeout.running = true;
            yesfadeout.running = true;
            nofadeout.running = true;
            helpsdotsfadeout.running = true;
            helprdotsfadeout.running = true;
            //if any fadeout for highscores
            hsbeginnerfadeout.running = true;
            hsintermediatefadeout.running = true;
            hsexpertfadeout.running = true;
            abouttextfadeout.running = true;


            //play's content fadein
            playsdotsfadein.running = true;
            playrdotsfadein.running = true;
        }
    }

    Image {
        id: bg
        x: 0
        y: 0
        z: 5
        source: "img/bg.jpg"

        Image {
            id: mainLogo
            x: 640
            y: 115
            source: "img/logo.png"
            opacity: 0
            //Animating the logo using NumberAnimation - movement and rotation
            NumberAnimation on x { from: 640; to: 239; duration: 1500; easing.type: Easing.InOutQuad; }
            NumberAnimation on rotation { from: 360; to: 0; duration: 1500; easing.type: Easing.InOutQuad; }
        }

        Image {
            id: shadow
            x: 575
            y: 170
            source: "img/shadow.png"
            opacity: 0
            //Animating the shadow motion so that it is in sync with the logo
            NumberAnimation on x {from: 575; to: 190; duration: 1500; easing.type: Easing.InOutQuad; }
        }


    }


    states: [
        State {
            name: "snd"

            PropertyChanges {
                target: highScoreBeginner
                //visible: true
                opacity: 1

            }
        },
        State {
            name: "smartdots"

            PropertyChanges {
                target: mainLogo
                x: 640
                y: 118
                z: 2
                opacity: 1
            }

            PropertyChanges {
                target: shadow
                x: 575
                y: 170
                opacity: 1
            }

            PropertyChanges {
                target: line2
                opacity: 0.500
            }

            PropertyChanges {
                target: line1
                opacity: 0.500
            }
        },
        State {
            name: "mainmenu"

            PropertyChanges {
                target: logo
                x: 487
                y: 110
                z: 8
                opacity: 1
            }

            PropertyChanges {
                target: playCard
                x: -158
                y: 11
                z: 8
                opacity: 1
            }

            PropertyChanges {
                target: helpCard
                x: -158
                y: 11
                z: 9
                opacity: 1
            }

            PropertyChanges {
                target: highscoreCard
                x: -158
                y: 11
                z: 10
                opacity: 1
            }

            PropertyChanges {
                target: aboutCard
                x: -158
                y: 11
                z: 11
                opacity: 1
            }

            PropertyChanges {
                target: exitCard
                x: -158
                y: 11
                z: 12
                opacity: 1
            }

            PropertyChanges {
                target: playsdots
                x: 273
                y: 30
                opacity: 1
            }

            PropertyChanges {
                target: playrdots
                x: 273
                y: 116
                opacity: 1
            }

            PropertyChanges {
                target: maplaydots
                x: 0
                y: 0
                width: 164
                height: 56
                opacity: 1
            }

            PropertyChanges {
                target: maplayrdots
                x: 0
                y: 0
                width: 165
                height: 57
                opacity: 1
            }

            PropertyChanges {
                target: bg
                z: 0
            }

            PropertyChanges {
                target: maExit
                x: 163
                y: 18
                width: 58
                height: 304
                opacity: 1
            }

            PropertyChanges {
                target: maAbout
                x: 225
                y: 16
                width: 48
                height: 306
                opacity: 1
            }

            PropertyChanges {
                target: maHighscores
                x: 280
                y: 14
                width: 57
                height: 307
                opacity: 1
            }

            PropertyChanges {
                target: maHelp
                x: 340
                y: 16
                width: 59
                height: 306
                opacity: 1
            }

            PropertyChanges {
                target: maPlay
                x: 403
                y: 16
                width: 60
                height: 306
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area2
                opacity: 0
            }

            PropertyChanges {
                target: areyousure
                x: 23
                y: 34
                opacity: 1
            }

            PropertyChanges {
                target: mainExitYes
                x: 11
                y: 70
                opacity: 1
            }

            PropertyChanges {
                target: mainExitNo
                x: 11
                y: 157
                opacity: 1
            }

            PropertyChanges {
                target: maExitYes
                x: 0
                y: 0
                width: 171
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: maExitNo
                x: 0
                y: 0
                width: 171
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: aboutText
                x: 80
                y: 62
                opacity: 1
            }

            PropertyChanges {
                target: helpsdots
                x: 205
                y: 30
                opacity: 1
            }

            PropertyChanges {
                target: helprdots
                x: 205
                y: 116
                opacity: 1
            }

            PropertyChanges {
                target: mahelprdots
                x: 0
                y: 0
                width: 171
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: mahelpsdots
                x: 0
                y: 1
                width: 171
                height: 65
                opacity: 1
            }

            PropertyChanges {
                target: highScoreBeginner
                x: 119
                y: 85
                width: 161
                height: 58
                color: "#ffffff"
                text: "BEGINNER\n0"
                font.bold: true
                wrapMode: "NoWrap"
                //visible: false
                font.pixelSize: 20
                font.family: "Lucida Console"
                textFormat: "PlainText"
                horizontalAlignment: "AlignRight"
                opacity: 1
            }

            PropertyChanges {
                target: highScoreIntermediate
                x: 120
                y: 153
                width: 160
                height: 49
                color: "#ffffff"
                text: "INTERMEDIATE\n0"
                font.bold: true
                font.family: "Lucida Console"
                horizontalAlignment: "AlignRight"
                font.pixelSize: 20
                opacity: 1
            }

            PropertyChanges {
                target: highScoreExpert
                x: 144
                y: 218
                width: 136
                height: 48
                color: "#ffffff"
                text: "Expert\n0"
                horizontalAlignment: "AlignRight"
                font.bold: true
                font.family: "Lucida Console"
                font.pixelSize: 20
                opacity: 1
            }
        },
        State {
            name: "mainmenu2"

            PropertyChanges {
                target: mode
                y: -297
                z: 10
                opacity: 1
            }

            PropertyChanges {
                target: oplayer
                x: 69
                y: 116
                opacity: 1
            }

            PropertyChanges {
                target: tplayer
                x: 331
                y: 116
                opacity: 1
            }

            PropertyChanges {
                target: maop
                x: 0
                y: 0
                width: 171
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: matp
                x: 0
                y: 0
                width: 171
                height: 66
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                opacity: 1
            }

            PropertyChanges {
                target: level
                z: 10
                opacity: 1
            }

            PropertyChanges {
                target: malevel
                width: 536
                height: 57
                opacity: 1
            }

            PropertyChanges {
                target: mamode
                x: 17
                y: 206
                width: 538
                height: 56
                opacity: 1
            }

            PropertyChanges {
                target: beginner
                x: 31
                y: 116
                opacity: 1
            }

            PropertyChanges {
                target: intermediate
                x: 202
                y: 116
                opacity: 1
            }

            PropertyChanges {
                target: expert
                x: 373
                y: 116
                opacity: 1
            }

            PropertyChanges {
                target: mabeginner
                width: 164
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: maexpert
                width: 165
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: maintermediate
                width: 165
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: back
                z: 10
                opacity: 1
            }

            PropertyChanges {
                target: maBack
                x: 0
                y: 0
                width: 175
                height: 72
                opacity: 1
            }
        },



        State {
            name: "playArea"

            PropertyChanges {
                target: bg
                z: 0
            }

            PropertyChanges {
                target: playGrid
                width: 640
                height: 360
                source: "img/grid.jpg"
                visible: true
                z: 0
                opacity: 1
            }

            PropertyChanges {
                target: refGrid
                x: 0
                y: 0
                z: 5
                opacity: 1
            }

            PropertyChanges {
                target: line2
                x: 155
                y: 38
                width: 64
                height: 31
                //color: "#ffffff"
                z: 10
                opacity: 0.5
            }

            PropertyChanges {
                target: line2
                x: 148
                y: 38
                width: 64
                height: 31
                z: 10
                opacity: 0.5
            }

            PropertyChanges {
                target: line3
                x: 241
                y: 38
                width: 61
                height: 29
                z: 10
                opacity: 0.5
            }

            PropertyChanges {
                target: line4
                x: 333
                y: 37
                width: 60
                height: 32
                z: 10
                opacity: 0.5
            }

            PropertyChanges {
                target: mabeginner
                opacity: 1
            }

            PropertyChanges {
                target: maexpert
                opacity: 1
            }

            PropertyChanges {
                target: maintermediate
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area1
                x: 0
                y: 0
                width: 56
                height: 29
                drag.minimumY: -1000
                drag.minimumX: -1000
                drag.maximumY: 1000
                drag.maximumX: 1000
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area2
                x: 5
                y: 0
                width: 51
                height: 31
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area3
                x: 1
                y: 0
                width: 53
                height: 29
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area4
                x: 0
                y: 0
                width: 60
                height: 32
                opacity: 1
            }

            PropertyChanges {
                target: line5
                x: 423
                y: 38
                width: 63
                height: 31
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area5
                x: 0
                y: 0
                width: 63
                height: 31
                opacity: 1
            }

            PropertyChanges {
                target: line6
                x: 513
                y: 37
                width: 61
                height: 32
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area6
                x: 0
                y: 0
                width: 62
                height: 32
                opacity: 1
            }

            PropertyChanges {
                target: line7
                x: 59
                y: 129
                width: 61
                height: 33
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area7
                x: 0
                y: 0
                width: 61
                height: 33
                opacity: 1
            }

            PropertyChanges {
                target: line8
                x: 148
                y: 129
                width: 64
                height: 33
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area8
                x: 0
                y: 0
                width: 64
                height: 33
                opacity: 1
            }

            PropertyChanges {
                target: line9
                x: 241
                y: 129
                width: 61
                height: 33
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area9
                x: 0
                y: 0
                width: 60
                height: 33
                opacity: 1
            }

            PropertyChanges {
                target: line10
                x: 333
                y: 129
                width: 60
                height: 33
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area10
                x: 0
                y: 0
                width: 62
                height: 33
                opacity: 1
            }

            PropertyChanges {
                target: line11
                x: 423
                y: 129
                width: 63
                height: 33
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area11
                x: 0
                y: 0
                width: 63
                height: 33
                opacity: 1
            }

            PropertyChanges {
                target: line12
                x: 513
                y: 129
                width: 61
                height: 33
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area12
                x: 0
                y: 0
                width: 62
                height: 33
                opacity: 1
            }

            PropertyChanges {
                target: line1
                x: 59
                y: 38
                width: 61
                height: 29
                opacity: 0.5
            }

            PropertyChanges {
                target: line13
                x: 59
                y: 221
                width: 61
                height: 31
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area13
                x: 0
                y: 0
                width: 58
                height: 33
                opacity: 1
            }

            PropertyChanges {
                target: line14
                x: 148
                y: 221
                width: 64
                height: 31
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area14
                x: 0
                y: 0
                width: 64
                height: 31
                opacity: 1
            }

            PropertyChanges {
                target: line15
                x: 241
                y: 221
                width: 61
                height: 31
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area15
                x: 0
                y: 0
                width: 60
                height: 31
                opacity: 1
            }

            PropertyChanges {
                target: line16
                x: 333
                y: 221
                width: 60
                height: 31
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area16
                x: 0
                y: 0
                width: 63
                height: 31
                opacity: 1
            }

            PropertyChanges {
                target: line17
                x: 423
                y: 221
                width: 63
                height: 31
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area17
                x: 0
                y: 0
                width: 63
                height: 31
                opacity: 1
            }

            PropertyChanges {
                target: line18
                x: 513
                y: 221
                width: 61
                height: 31
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area18
                x: 0
                y: 0
                width: 63
                height: 31
                opacity: 1
            }

            PropertyChanges {
                target: line19
                x: 59
                y: 311
                width: 61
                height: 35
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area19
                x: 0
                y: 0
                width: 61
                height: 35
                opacity: 1
            }

            PropertyChanges {
                target: line20
                x: 148
                y: 311
                width: 64
                height: 34
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area20
                x: 0
                y: 0
                width: 64
                height: 34
                opacity: 1
            }

            PropertyChanges {
                target: line21
                x: 241
                y: 311
                width: 61
                height: 34
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area21
                x: 0
                y: 0
                width: 61
                height: 34
                opacity: 1
            }

            PropertyChanges {
                target: vline2
                x: 119
                y: 67
                width: 28
                height: 63
                opacity: 0.5
            }

            PropertyChanges {
                target: line22
                x: 333
                y: 311
                width: 60
                height: 34
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area22
                x: 0
                y: 0
                width: 60
                height: 35
                opacity: 1
            }

            PropertyChanges {
                target: line23
                x: 423
                y: 312
                width: 63
                height: 31
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area23
                x: 0
                y: 0
                width: 63
                height: 31
                opacity: 1
            }

            PropertyChanges {
                target: line24
                x: 513
                y: 312
                width: 61
                height: 33
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area24
                x: 0
                y: 0
                width: 61
                height: 33
                opacity: 1
            }

            PropertyChanges {
                target: vline1
                x: 30
                y: 67
                width: 28
                height: 63
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area25
                x: 0
                y: 0
                width: 28
                height: 63
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area26
                x: 0
                y: 0
                width: 28
                height: 63
                opacity: 1
            }

            PropertyChanges {
                target: vline3
                x: 212
                y: 69
                width: 27
                height: 60
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area27
                x: 0
                y: 0
                width: 27
                height: 60
                opacity: 1
            }

            PropertyChanges {
                target: vline6
                x: 487
                y: 69
                width: 27
                height: 60
                opacity: 0.5
            }

            PropertyChanges {
                target: vline4
                x: 303
                y: 69
                width: 26
                height: 60
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area28
                x: 0
                y: 0
                width: 26
                height: 60
                opacity: 1
            }

            PropertyChanges {
                target: vline5
                x: 394
                y: 69
                width: 29
                height: 60
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area29
                x: 0
                y: 0
                width: 29
                height: 60
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area30
                x: 0
                y: 0
                width: 27
                height: 60
                opacity: 1
            }

            PropertyChanges {
                target: vline13
                x: 487
                y: 162
                width: 27
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: vline10
                x: 210
                y: 162
                width: 31
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: vline7
                x: 575
                y: 69
                width: 28
                height: 60
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area31
                x: 0
                y: 0
                width: 28
                height: 61
                opacity: 1
            }

            PropertyChanges {
                target: vline8
                x: 30
                y: 159
                width: 28
                height: 61
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area32
                x: 0
                y: 0
                width: 31
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: vline9
                x: 119
                y: 162
                width: 31
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area33
                x: 0
                width: 31
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area34
                x: 0
                y: 0
                width: 31
                height: 58
                opacity: 1
            }

            PropertyChanges {
                target: vline11
                x: 303
                y: 162
                width: 29
                height: 58
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area35
                x: 0
                y: 0
                width: 29
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: vline12
                x: 394
                y: 162
                width: 29
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area36
                x: 0
                y: 0
                width: 28
                height: 60
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area37
                x: 0
                y: 0
                width: 27
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: vline18
                x: 303
                y: 252
                width: 29
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: vline14
                x: 574
                y: 162
                width: 29
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area38
                x: 0
                y: 0
                width: 29
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: vline15
                x: 30
                y: 252
                width: 28
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area39
                x: 0
                y: 0
                width: 28
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: vline16
                x: 120
                y: 252
                width: 28
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area40
                x: 0
                y: 0
                width: 28
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: vline17
                x: 212
                y: 252
                width: 30
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area41
                x: 0
                y: 0
                width: 30
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: mouse_area42
                x: 0
                y: 0
                width: 29
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: vline20
                x: 487
                y: 252
                width: 27
                height: 60
                opacity: 0.5
            }

            PropertyChanges {
                target: vline19
                x: 394
                y: 252
                width: 29
                height: 60
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area43
                x: 0
                y: 0
                width: 29
                height: 60
                opacity: 1
            }



            PropertyChanges {
                target: mouse_area45
                x: 0
                y: 0
                width: 27
                height: 53
                opacity: 1
            }

            PropertyChanges {
                target: vline21
                x: 576
                y: 252
                width: 27
                height: 59
                opacity: 0.5
            }

            PropertyChanges {
                target: mouse_area46
                x: 0
                y: 0
                width: 27
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: rectangle1
                x: 65
                y: 75
                width: 50
                height: 49
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle2
                width: 49
                height: 50
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle3
                width: 49
                height: 50
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle4
                x: 337
                y: 74
                width: 51
                height: 50
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle5
                x: 428
                y: 75
                width: 52
                height: 49
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle6
                width: 48
                height: 50
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle7
                x: 65
                y: 167
                width: 50
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle8
                x: 155
                y: 167
                width: 49
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle9
                width: 49
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle10
                width: 49
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle11
                width: 52
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle12
                x: 520
                y: 168
                width: 49
                height: 46
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle13
                width: 50
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle14
                x: 155
                y: 260
                width: 49
                height: 45
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle15
                x: 247
                y: 258
                width: 49
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle16
                x: 339
                y: 258
                width: 49
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle17
                x: 428
                y: 258
                width: 52
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: rectangle18
                x: 520
                y: 258
                width: 49
                height: 47
                opacity: 0.5
            }

            PropertyChanges {
                target: maHighscores
                drag.minimumY: -1000
                drag.minimumX: -1000
                drag.maximumY: 1000
                drag.maximumX: 1000
            }

            PropertyChanges {
                target: image1
                x: 24
                y: 33
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image2
                x: 113
                y: 34
                width: 41
                height: 42
                z: 10
                opacity: 1
            }

            PropertyChanges {
                target: image3
                x: 206
                y: 32
                width: 41
                height: 42
                z: 10
                opacity: 1
            }

            PropertyChanges {
                target: image4
                x: 296
                y: 32
                width: 41
                height: 42
                z: 10
                opacity: 1
            }

            PropertyChanges {
                target: image5
                x: 388
                y: 32
                width: 41
                height: 42
                z: 10
                opacity: 1
            }

            PropertyChanges {
                target: image6
                x: 479
                y: 33
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image7
                x: 571
                y: 33
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image8
                x: 24
                y: 124
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image9
                x: 113
                y: 124
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image10
                x: 206
                y: 125
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image11
                x: 296
                y: 124
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image12
                x: 388
                y: 125
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image13
                x: 479
                y: 126
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image14
                x: 569
                y: 124
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image15
                x: 24
                y: 216
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image16
                x: 114
                y: 216
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image17
                x: 206
                y: 215
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image18
                x: 297
                y: 214
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image19
                x: 388
                y: 214
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image20
                x: 479
                y: 216
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image21
                x: 569
                y: 214
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image22
                x: 24
                y: 306
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image23
                x: 115
                y: 306
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image24
                x: 205
                y: 308
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image25
                x: 298
                y: 306
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image26
                x: 389
                y: 307
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image27
                x: 480
                y: 306
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: image28
                x: 569
                y: 306
                width: 41
                height: 42
                opacity: 1
            }

            PropertyChanges {
                target: playScore
                z: 15
                opacity: 1
            }

            PropertyChanges {
                target: scoreL
                x: 6
                y: 0
                width: 110
                height: 25
                font.pixelSize: 25
                font.bold: true
                verticalAlignment: "AlignVCenter"
                z: 30
                opacity: 1
            }

            PropertyChanges {
                target: scoreR
                x: 515
                y: 0
                width: 119
                height: 25
                font.pixelSize: 25
                font.bold: true
                verticalAlignment: "AlignVCenter"
                horizontalAlignment: "AlignRight"
                z: 30
                opacity: 1
            }

            PropertyChanges {
                target: scoreNumL
                x: 121
                y: 0
                width: 45
                height: 25
                text: qsTr("0")
                font.bold: true
                font.pixelSize: 25
                verticalAlignment: "AlignVCenter"
                horizontalAlignment: "AlignHCenter"
                z: 15
                opacity: 1
            }

            PropertyChanges {
                target: scoreNumR
                x: 465
                y: -2
                text: qsTr("0")
                z: 15
                font.pixelSize: 25
                font.bold: true
                verticalAlignment: "AlignVCenter"
                horizontalAlignment: "AlignHCenter"
                opacity: 1
            }

            PropertyChanges {
                target: pauseDropCard
                x: 0
                y: -354
                z: 20
                opacity: 1
            }

            PropertyChanges {
                target: maPause
                width: 131
                height: 59
                opacity: 1
            }

            PropertyChanges {
                target: pauseMainMenu
                opacity: 1
            }

            PropertyChanges {
                target: pauseHelp
                opacity: 1
            }

            PropertyChanges {
                target: maPauseMainMenu
                x: 0
                y: 0
                width: 311
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: maPauseHelp
                width: 311
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: pauseHelpsdots
                z: -50
                opacity: 1
            }

            PropertyChanges {
                target: pauseHelprdots
                z: -50
                opacity: 1
            }

            PropertyChanges {
                target: pauseHelpsdotsback
                z: 15
                opacity: 1
            }

            PropertyChanges {
                target: pauseHelprdotsback
                z: 15
                opacity: 1
            }

            PropertyChanges {
                target: maPHsdb
                x: 0
                y: 0
                width: 175
                height: 72
                opacity: 1
            }

            PropertyChanges {
                target: maPHrdb
                x: 0
                y: 0
                width: 175
                height: 72
                opacity: 1
            }

            PropertyChanges {
                target: helpListView
                x: 209
                y: 0
                width: 431
                height: 360
            }

            PropertyChanges {
                target: helpRListView
                x: 209
                y: 0
                width: 431
                height: 360
            }
        },
        State {
            name: "getSetGo"

            PropertyChanges {
                target: getSetGo
                x: 249
                y: 43
                z: 6
                opacity: 1
            }

            PropertyChanges {
                target: getSetGoTimer
                running : true;
            }

        },
        State {
            name: "endmenu"

            PropertyChanges {
                target: endDropCard
                z: 50
                opacity: 1
            }

            PropertyChanges {
                target: endPlayAgain
                x: 72
                y: 281
                opacity: 1
            }

            PropertyChanges {
                target: endMainMenu
                x: 398
                y: 281
                opacity: 1
            }

            PropertyChanges {
                target: maEndPlayAgain
                x: 0
                y: 0
                width: 171
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: maEndMainMenu
                x: 0
                y: 0
                width: 171
                height: 66
                opacity: 1
            }

            PropertyChanges {
                target: win
                opacity: 0
            }

            PropertyChanges {
                target: lose
                opacity: 0
                //y: 11
            }

            PropertyChanges {
                target: highwin
                opacity: 0
            }

            PropertyChanges {
                target: p1win
                x: 40
                y: 11
                opacity: 0
            }

            PropertyChanges {
                target: p2win
                opacity: 0
            }

            PropertyChanges {
                target: draw
                x: 39
                y: 11
                opacity: 0
            }
        },
        State {
            name: "sdotsHelp"

            PropertyChanges {
                target: mainsdotsBack
                z: 15
                opacity: 1
            }
            PropertyChanges {
                target: helpListView
                z:10
                opacity: 1

            }

            PropertyChanges {
                target: maMainSdotsBack
                width: 175
                height: 72
                opacity: 1
            }
        },
        State {
            name: "rdotsHelp"

            PropertyChanges {
                target: helpRListView
                z:10
                opacity: 1

            }

            PropertyChanges {
                target: mainrdotsBack
                z: 15
                opacity: 1
            }

            PropertyChanges {
                target: maMainRdotsBack
                x: 0
                y: 0
                width: 175
                height: 72
                opacity: 1
            }
        }
    ]

    Image {
        id: logo
        x: 480
        y: 105
        source: "img/menulogo.png"
        opacity: 0
    }

    Image {
        id: playCard
        x: -158
        y: 32
        source: "img/playCard.png"
        opacity: 0
        //Animation to move the playCard when this menu is state is entered
        NumberAnimation on x { id:playmoveR; running: false;  from: -158; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        NumberAnimation on x { id:playmoveL; running: false;  from: 0; to: -158; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        Image {
            id: playsdots
            x: 273
            y: 43
            source: "img/sdots.png"
            opacity: 0
            //Animating opacity - for smartdots play button
            //NumberAnimation on opacity {id:sdotsopacity; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

            NumberAnimation on opacity { id:playsdotsfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:playsdotsfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }


            MouseArea {
                id: maplaydots
                x: 536
                y: 253
                width: 100
                height: 100
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    //proceed to the next menu to select the modes and diffuculty levels
                    console.log("play smart dots clicked!");
                    D.dotsMode = 1;
                    rect.state = "mainmenu2";
                    modemoveDown.running = true;
                    modeopfadein.running = true;
                    modetpfadein.running = true;
                    mamode.opacity = 0;

                }
            }
        }

        Image {
            id: playrdots
            x: 273
            y: 107
            source: "img/rdots.png"
            opacity: 0
            //Animating opacity - for smartdots play button
            /////////NumberAnimation on opacity {id:rdotsopacity; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }


            NumberAnimation on opacity { id:playrdotsfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:playrdotsfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }


            MouseArea {
                id: maplayrdots
                x: 543
                y: 278
                width: 100
                height: 100
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    //proceed to the next menu to select the modes and diffuculty levels
                    console.log("play reverse dots clicked!");
                    D.dotsMode = 2;
                    rect.state = "mainmenu2";
                    modemoveDown.running = true;
                    modeopfadein.running = true;
                    modetpfadein.running = true;
                    mamode.opacity = 0;

                }
            }
        }

        MouseArea {
            id: maPlay
            x: 179
            y: 0
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                console.log("play clicked");
                if(exitCard.x == 0)
                {
                    //current view is exit
                    //exit's fadeout
                    exitmoveL.running = true;
                    aboutmoveL.running = true;
                    highscoremoveL.running = true;
                    helpmoveL.running = true;
                    //play's fadein

                    //exit's content fadeout
                    aysfadeout.running = true;
                    yesfadeout.running = true;
                    nofadeout.running = true;

                }
                else if(aboutCard.x == 0)
                {
                    //current view is about
                    //about's fadeout
                    aboutmoveL.running = true;
                    highscoremoveL.running = true;
                    helpmoveL.running = true;
                    //play's fadein

                    //about's content fadeout
                    abouttextfadeout.running = true;

                }
                else if(highscoreCard.x == 0)
                {
                    //current view is highscore
                    //highscore's fadeout
                    highscoremoveL.running = true;
                    helpmoveL.running = true;
                    //play's fadein

                    //highscore's content fadeout SHOULD BE IMPLMENTED HERE (!important)

                    hsbeginnerfadeout.running = true;
                    hsintermediatefadeout.running = true;
                    hsexpertfadeout.running = true;

                }
                else if(helpCard.x == 0)
                {
                    //current view is help
                    //help's fadeout
                    helpmoveL.running = true;
                    //play's fadein


                    //help's content fadeout
                    helpsdotsfadeout.running = true;
                    helprdotsfadeout.running = true;

                }


                //Handling mas'
                maAbout.opacity = 1;
                maExit.opacity = 1;
                maHighscores.opacity = 1;
                maHelp.opacity = 1;
                //turning off play's opacity
                maPlay.opacity = 0;

                //after the appropriate fade out, now play's content fadein
                playsdotsfadein.running = true;
                playrdotsfadein.running = true;
            }
        }
    }

    Image {
        id: helpCard
        x: 6
        y: 0
        source: "img/helpCard.png"
        opacity: 0
        NumberAnimation on x { id:helpmoveR; running: false;  from: -158; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        NumberAnimation on x { id:helpmoveL; running: false;  from: 0; to: -158; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        Image {
            id: helpsdots
            x: 215
            y: 108
            source: "img/sdots.png"
            opacity: 0

            NumberAnimation on opacity { id:helpsdotsfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:helpsdotsfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }


            MouseArea {
                id: mahelpsdots
                x: 4
                y: 1
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    rect.state = "sdotsHelp"
                }
            }
        }

        Image {
            id: helprdots
            x: 221
            y: 111
            source: "img/rdots.png"
            opacity: 0

            NumberAnimation on opacity { id:helprdotsfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:helprdotsfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }


            MouseArea {
                id: mahelprdots
                x: 58
                y: 19
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    rect.state = "rdotsHelp"
                }
            }
        }

        MouseArea {
            id: maHelp
            x: 117
            y: 139
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                console.log("help clicked");

                if(exitCard.x == 0)
                {
                    //current view is exit
                    //exit's fadeout
                    exitmoveL.running = true;
                    aboutmoveL.running = true;
                    highscoremoveL.running = true;
                    //help's fadein

                    //exit's content fadeout
                    aysfadeout.running = true;
                    yesfadeout.running = true;
                    nofadeout.running = true;
                }
                else if(aboutCard.x == 0)
                {
                    //current view is about
                    //about's fadeout
                    aboutmoveL.running = true;
                    highscoremoveL.running = true;
                    //help's fadein

                    //about's content fadeout
                    abouttextfadeout.running = true;
                }
                else if(highscoreCard.x == 0)
                {
                    //current view is highscore
                    //highscore's fadeout
                    highscoremoveL.running = true;
                    //helps's fadein


                    //highscore's content fadeout SHOULD BE IMPLMENTED HERE (!important)

                    hsbeginnerfadeout.running = true;
                    hsintermediatefadeout.running = true;
                    hsexpertfadeout.running = true;
                }
                else if(playCard.x == 0)
                {
                    //current view is play
                    //play's fadeout
                    helpmoveR.running = true;
                    //help's fadein

                    //play's content fadeout
                    playsdotsfadeout.running = true;
                    playrdotsfadeout.running = true;
                }


                //Handling mas'
                maAbout.opacity = 1;
                maExit.opacity = 1;
                maHighscores.opacity = 1;
                //turning off help's opacity
                maHelp.opacity = 0;
                maPlay.opacity = 1;

                //now the help contents should appear
                helpsdotsfadein.running = true;
                helprdotsfadein.running = true;
            }
        }


    }

    Image {
        id: highscoreCard
        x: -38
        y: 86
        source: "img/highscoresCard.png"
        opacity: 0
        NumberAnimation on x { id:highscoremoveR; running: false;  from: -158; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        NumberAnimation on x { id:highscoremoveL; running: false;  from: 0; to: -158; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        MouseArea {
            id: maHighscores
            x: 68
            y: 192
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                highscore(1);
                var hsb = "BEGINNER\n"+ D.s.rows.item(0).score;
                if(D.s.rows.item(0).score!=0)
                highScoreBeginner.text = hsb.substring(0,hsb.length - 2);

                var hsi = "INTERMEDIATE\n"+D.s.rows.item(1).score;
                if(D.s.rows.item(1).score!=0)
                highScoreIntermediate.text = hsi.substring(0,hsi.length - 2);

                var hse =  "EXPERT\n"+D.s.rows.item(2).score;
                if(D.s.rows.item(2).score!=0)
                highScoreExpert.text = hse.substring(0,hse.length - 2);
                //highScoreBeginner.visible = "true";

                console.log("highscores clicked");

                if(exitCard.x == 0)
                {
                    //current view is exit
                    //exit's fadeout
                    exitmoveL.running = true;
                    aboutmoveL.running = true;
                    //highscore's fadein

                    //exit's content fadeout
                    aysfadeout.running = true;
                    yesfadeout.running = true;
                    nofadeout.running = true;

                }
                else if(aboutCard.x == 0)
                {
                    //current view is about
                    //about's fadeout
                    aboutmoveL.running = true;
                    //highscore's fadein


                    //about's content fadeout
                    abouttextfadeout.running = true;

                }
                else if(helpCard.x == 0 && playCard.x == 0)
                {
                    //current view is help
                    //help's fadeout
                    highscoremoveR.running = true;
                    //highscore's fadein

                    //help's content fadeout
                    helpsdotsfadeout.running = true;
                    helprdotsfadeout.running = true;

                }
                else if(playCard.x == 0)
                {
                    //current view is play
                    //play's fadeout
                    helpmoveR.running = true;
                    highscoremoveR.running = true;
                    //highscore's fadein

                    //play's content fadeout
                    playsdotsfadeout.running = true;
                    playrdotsfadeout.running = true;

                }



                //Handling mas'
                maAbout.opacity = 1;
                maExit.opacity = 1;
                //turning off highscore's opacity
                maHighscores.opacity = 0;
                maHelp.opacity = 1;
                maPlay.opacity = 1;

                //highscore's fadein should be done here
                hsbeginnerfadein.running = true;
                hsintermediatefadein.running = true;
                hsexpertfadein.running = true;

            }
        }

        TextEdit {
            id: highScoreBeginner
            x: 129
            y: 146
            width: 45
            height: 45
            text: "BEGINNER\n0"
            font.pixelSize: 5
            opacity: 0
            //visible: true
            NumberAnimation on opacity { id:hsbeginnerfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:hsbeginnerfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }


        }

        TextEdit {
            id: highScoreIntermediate
            x: 124
            y: -23
            width: 80
            height: 20
            text: "INTERMEDIATE\n0"
            font.pixelSize: 5
            opacity: 0

            NumberAnimation on opacity { id:hsintermediatefadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:hsintermediatefadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

        }

        TextEdit {
            id: highScoreExpert
            x: 54
            y: 213
            width: 80
            height: 20
            text: "EXPERT\n0"
            font.pixelSize: 5
            opacity: 0

            NumberAnimation on opacity { id:hsexpertfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:hsexpertfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

        }
    }

    Image {
        id: aboutCard
        x: -40
        y: 260
        source: "img/aboutCard.png"
        opacity: 0
        NumberAnimation on x { id:aboutmoveR; running: false;  from: -158; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        NumberAnimation on x { id:aboutmoveL; running: false;  from: 0; to: -158; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

        Image {
            id: aboutText
            x: 134
            y: 178
            source: "img/aboutText.png"
            opacity: 0

            NumberAnimation on opacity { id:abouttextfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:abouttextfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        }

        MouseArea {
            id: maAbout
            x: 456
            y: 136
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                console.log("About clicked");
                console.log(playCard.x);

                if(exitCard.x == 0)
                {
                    //The current view is exit
                    //exit's fadeout
                    exitmoveL.running = true;
                    //about's fadein

                    //exit's content fadeout
                    aysfadeout.running = true;
                    yesfadeout.running = true;
                    nofadeout.running = true;
                }
                else if(highscoreCard.x == 0 && helpCard.x == 0 && playCard.x == 0)
                {
                    //The current view is highscore
                    //highscore's fadeout
                    aboutmoveR.running = true;
                    //about's fadein

                    //if something is there in highscore... fadeout here

                    hsbeginnerfadeout.running = true;
                    hsintermediatefadeout.running = true;
                    hsexpertfadeout.running = true;
                }
                else if(helpCard.x == 0 && playCard.x == 0)
                {
                    //The current view is help
                    //help's fadeout
                    highscoremoveR.running = true;
                    aboutmoveR.running = true;
                    //about's fadein

                    //help's content fadeout
                    helpsdotsfadeout.running = true;
                    helprdotsfadeout.running = true;
                }
                else if(playCard.x == 0)
                {
                    //The current view is play
                    //play's fadeout
                    helpmoveR.running = true;
                    highscoremoveR.running = true;
                    aboutmoveR.running = true;
                    //about's fadein

                    //play's content fadeout
                    playsdotsfadeout.running = true;
                    playrdotsfadeout.running = true;


                }

                //Handling mas'
                //turning off ma of about
                maAbout.opacity = 0;
                //turning on all other's ma
                maExit.opacity = 1;
                maHighscores.opacity = 1;
                maHelp.opacity = 1;
                maPlay.opacity = 1;

                //about's content fadein
                abouttextfadein.running = true;



            }
        }

    }

    Image {
        id: mode
        x: 34
        y: -37
        source: "img/scr2Card.png"
        opacity: 0

        NumberAnimation on y { id:modemoveDown; running: false;  from: -297; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        NumberAnimation on y { id:modemoveUp; running: false;  from: 0; to: -297; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

        Image {
            id: oplayer
            x: 80
            y: 170
            source: "img/oplayer.png"
            opacity: 0
            NumberAnimation on opacity { id:modeopfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:modeopfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

            MouseArea {
                id: maop
                x: 31
                y: 6
                width: 100
                height: 100
                opacity: 0
                anchors.fill: parent;
                onClicked: {
                    D.playmode = 2;
                    console.log("one player clicked");
                    modeopfadeout.running = true;
                    modetpfadeout.running = true;
                    levelmovedown.running = true;
                    mamode.opacity = 1;

                    beginnerfadein.running = true;
                    intermediatefadein.running = true;
                    expertfadein.running = true;
                }
            }
        }

        Image {
            id: tplayer
            x: 316
            y: 173
            source: "img/tplayer.png"
            opacity: 0
            NumberAnimation on opacity { id:modetpfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:modetpfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

            MouseArea {
                id: matp
                x: 1
                y: -4
                width: 100
                height: 100
                opacity: 0
                anchors.fill: parent;
                onClicked: {
                    D.playmode = 1;

                    console.log("one player clicked");
                    rect.state = "getSetGo";
                }
            }
        }

        MouseArea {
            id: mamode
            x: 18
            y: 206
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                if(level.y == -50)
                {
                    levelmoveup.running = true;
                    modeopfadein.running = true;
                    modetpfadein.running = true;
                    mamode.opacity = 0;
                    beginnerfadeout.running = true;
                    intermediatefadeout.running = true;
                    expertfadeout.running = true;
                }
            }
        }
    }

    Image {
        id: level
        x: 34
        y: -297
        source: "img/scr2Card2.png"
        opacity: 0

        NumberAnimation on y { id:levelmovedown; running: false;  from: -297; to: -50; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        NumberAnimation on y { id:levelmoveup; running: false;  from: -50; to: -297; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

        MouseArea {
            id: malevel
            x: 18
            y: 205
            width: 100
            height: 100
            opacity: 0
        }

        Image {
            id: beginner
            x: 76
            y: 151
            source: "img/beginner.png"
            opacity: 0
            NumberAnimation on opacity { id:beginnerfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:beginnerfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

            MouseArea {
                id: mabeginner
                x: 0
                y: 0
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    D.level = 1;
                    rect.state = "getSetGo";
                    modemoveUp.running = true;
                    levelmoveup.running = true;
                }
            }
        }

        Image {
            id: expert
            x: 442
            y: 162
            source: "img/expert.png"
            opacity: 0
            NumberAnimation on opacity { id:expertfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:expertfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

            MouseArea {
                id: maexpert
                x: -1
                y: 0
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    D.level = 3;
                    rect.state = "getSetGo";
                    getSetGoTimer.running = true;
                    modemoveUp.running = true;
                    levelmoveup.running = true;
                }
            }
        }

        Image {
            id: intermediate
            x: 258
            y: 159
            source: "img/intermediate.png"
            opacity: 0
            NumberAnimation on opacity { id:intermediatefadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:intermediatefadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

            MouseArea {
                id: maintermediate
                x: -1
                y: 0
                width: 100
                height: 100
                opacity: 0
                onClicked:{
                    D.level=2;
                    rect.state = "getSetGo";
                    modemoveUp.running = true;
                    levelmoveup.running = true;
                }
            }
        }

    }

    Image {
        id: exitCard
        x: -43
        y: 227
        source: "img/exitCard.png"
        opacity: 0
        NumberAnimation on x { id:exitmoveR; running: false;  from: -158; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        NumberAnimation on x { id:exitmoveL; running: false;  from: 0; to: -158; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

        MouseArea {
            id: maExit
            x: 152
            y: 52
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                console.log("exit clicked!");

                if(aboutCard.x == 0 && highscoreCard.x == 0 && helpCard.x == 0 && playCard.x == 0)
                {
                    //current view is about
                    //about's fadeout
                    exitmoveR.running = true;
                    //exit's fadein

                    //about's content fadeout
                    abouttextfadeout.running = true;

                }
                else if(highscoreCard.x == 0 && helpCard.x == 0 && playCard.x == 0)
                {
                    //current view is highscore
                    //highscore's fadeout
                    aboutmoveR.running = true;
                    exitmoveR.running = true;
                    //exit's fadein

                    //if something is there in highscores fadeout here

                    hsbeginnerfadeout.running = true;
                    hsintermediatefadeout.running = true;
                    hsexpertfadeout.running = true;

                }
                else if(helpCard.x == 0 && playCard.x == 0)
                {
                    //current view is help
                    //help's fadeout
                    highscoremoveR.running = true;
                    aboutmoveR.running = true;
                    exitmoveR.running = true;
                    //exits fadein


                    //help's content fadeout
                    helpsdotsfadeout.running = true;
                    helprdotsfadeout.running = true;
                }
                else if(playCard.x == 0)
                {
                    //current view is play
                    //play's fadeout
                    helpmoveR.running = true;
                    highscoremoveR.running = true;
                    aboutmoveR.running = true;
                    exitmoveR.running = true;
                    //exit's fadein


                    //play's content fadeout
                    playsdotsfadeout.running = true;
                    playrdotsfadeout.running = true;


                }


                //Handling mas'
                maAbout.opacity = 1;
                //turning off ma of exit
                maExit.opacity = 0;
                maHighscores.opacity = 1;
                maHelp.opacity = 1;
                maPlay.opacity = 1;

                //exit's content fadein
                aysfadein.running = true;
                yesfadein.running = true;
                nofadein.running = true;
            }
        }

        Image {
            id: mainExitYes
            x: -31
            y: 81
            source: "img/mainExitYes.png"
            opacity: 0

            NumberAnimation on opacity { id:yesfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:yesfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

            MouseArea {
                id: maExitYes
                x: 28
                y: 18
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    console.log("Exit yes clicked! Game will exit now...");
                    Qt.quit();
                }
            }
        }

        Image {
            id: mainExitNo
            x: -40
            y: 167
            source: "img/mainExitNo.png"
            opacity: 0

            NumberAnimation on opacity { id:nofadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:nofadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

            MouseArea {
                id: maExitNo
                x: 20
                y: 15
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    console.log("Exit No clicked");
                    // now all the menus should come left activating the play menu
                    //that is same action as if play was clicked!
                    // same actions as when play was clicked
                    console.log("play clicked");
                    if(exitCard.x == 0)
                    {
                        //current view is exit
                        //exit's fadeout
                        exitmoveL.running = true;
                        aboutmoveL.running = true;
                        highscoremoveL.running = true;
                        helpmoveL.running = true;
                        //play's fadein

                        //exit's content fadeout
                        aysfadeout.running = true;
                        yesfadeout.running = true;
                        nofadeout.running = true;

                    }
                    else if(aboutCard.x == 0)
                    {
                        //current view is about
                        //about's fadeout
                        aboutmoveL.running = true;
                        highscoremoveL.running = true;
                        helpmoveL.running = true;
                        //play's fadein

                        //about's content fadeout
                        abouttextfadeout.running = true;

                    }
                    else if(highscoreCard.x == 0)
                    {
                        //current view is highscore
                        //highscore's fadeout
                        highscoremoveL.running = true;
                        helpmoveL.running = true;
                        //play's fadein

                        //highscore's content fadeout SHOULD BE IMPLMENTED HERE (!important)

                    }
                    else if(helpCard.x == 0)
                    {
                        //current view is help
                        //help's fadeout
                        helpmoveL.running = true;
                        //play's fadein


                        //help's content fadeout
                        helpsdotsfadeout.running = true;
                        helprdotsfadeout.running = true;

                    }


                    //Handling mas'
                    maAbout.opacity = 1;
                    maExit.opacity = 1;
                    maHighscores.opacity = 1;
                    maHelp.opacity = 1;
                    //turning off play's opacity
                    maPlay.opacity = 0;

                    //after the appropriate fade out, now play's content fadein
                    playsdotsfadein.running = true;
                    playrdotsfadein.running = true;
                }
            }
        }

        Image {
            id: areyousure
            x: 11
            y: 32
            source: "img/areyousure.png"
            opacity: 0

            NumberAnimation on opacity { id:aysfadeout; running: false;  from: 1; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
            NumberAnimation on opacity { id:aysfadein; running: false;  from: 0; to: 1; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
        }




    }

    Image {
        id: back
        x: 6
        y: 280
        source: "img/back.png"
        opacity: 0

        MouseArea {
            id: maBack
            x: 16
            y: 20
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                levelmoveup.running = true;
                rect.state = "mainmenu";
                playmoveR.running = true;    //running the playCard movement
                ///////// sdotsopacity.running = true;    //running the play smartdots opacity
                ////////////rdotsopacity.running = true;    //running the play reversedots opacity


                //everything's else contents fadeout
                aysfadeout.running = true;
                yesfadeout.running = true;
                nofadeout.running = true;
                helpsdotsfadeout.running = true;
                helprdotsfadeout.running = true;
                //if any fadeout for highscores

                hsbeginnerfadeout.running = true;
                hsintermediatefadeout.running = true;
                hsexpertfadeout.running = true;
                abouttextfadeout.running = true;


                playsdotsfadein.running = true;
                playrdotsfadein.running = true;

                //deactivate play ma
                maPlay.opacity = 0;
                //activate all other ma
                maHelp.opacity = 1;
                maAbout.opacity = 1;
                maHighscores.opacity = 1;
                maExit.opacity = 1;
            }
        }
    }







    Image {
        id: playGrid
        x: 0
        y: 0
        source: "img/grid.jpg"
        opacity: 0
    }

    Image {
        id: refGrid
        x: 12
        y: 0
        source: "img/grid.jpg"
        opacity: 0

        Rectangle {
                   id: line2
                   x: 109
                   y: 105
                   width: 100
                   height: 31
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area1
                       x: 55
                       y: 81
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][2][0]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line2.color = "#ff0000";
                                   line2.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line2.color = "#af12fe";
                                   line2.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,2,1,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle2.color="#ff0000"
                                           else
                                               rectangle2.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle2.color="#af12fe"
                                           else
                                               rectangle2.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle2.color="#ff0000"
                                           else
                                               rectangle2.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle2.color="#af12fe"
                                           else
                                               rectangle2.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {


                                   console.log("CPU");
                                   D.dotsCaller(1,2,1,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle2.color="#ff0000"
                                       else
                                           rectangle2.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle2.color="#ff0000"
                                       else
                                           rectangle2.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {
                                       D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: line1
                   x: 101
                   y: 112
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area2
                       x: 130
                       y: 94
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           console.log(D.winnerFlag1+"..................."+D.winnerFlag2);

                           if(D.count<45 && D.dot[1][1][0]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line1.color = "#ff0000";
                                   line1.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line1.color = "#af12fe";
                                   line1.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,1,1,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle1.color="#ff0000"
                                           else
                                               rectangle1.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle1.color="#af12fe"
                                           else
                                               rectangle1.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle1.color="#ff0000"
                                           else
                                               rectangle1.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle1.color="#af12fe"
                                           else
                                               rectangle1.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {

                                   console.log("CPU");

                                   D.dotsCaller(1,1,1,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle1.color="#ff0000"
                                       else
                                           rectangle1.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle1.color="#ff0000"
                                       else
                                           rectangle1.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {

                                       D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           console.log("CPU plays  1");
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);
                                           console.log("AIC");
                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           console.log("reverse logic");
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: line3
                   x: 258
                   y: 104
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area3
                       x: 221
                       y: 38
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][3][0]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line3.color = "#ff0000";
                                   line3.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line3.color = "#af12fe";
                                   line3.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,3,1,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle3.color="#ff0000"
                                           else
                                               rectangle3.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle3.color="#af12fe"
                                           else
                                               rectangle3.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle3.color="#ff0000"
                                           else
                                               rectangle3.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle3.color="#af12fe"
                                           else
                                               rectangle3.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,3,1,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle3.color="#ff0000"
                                       else
                                           rectangle3.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle3.color="#ff0000"
                                       else
                                           rectangle3.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);




                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: line4
                   x: 258
                   y: 130
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area4
                       x: 201
                       y: 94
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][4][0]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line4.color = "#ff0000";
                                   line4.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line4.color = "#af12fe";
                                   line4.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,4,1,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle4.color="#ff0000"
                                           else
                                               rectangle4.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle4.color="#af12fe"
                                           else
                                               rectangle4.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle14color="#ff0000"
                                           else
                                               rectangle4.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle4.color="#af12fe"
                                           else
                                               rectangle4.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,4,1,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle4.color="#ff0000"
                                       else
                                           rectangle4.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle4.color="#af12fe"
                                       else
                                           rectangle4.color="#af12fe"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: line5
                   x: 303
                   y: 86
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area5
                       x: 189
                       y: 94
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][5][0]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line5.color = "#ff0000";
                                   line5.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line5.color = "#af12fe";
                                   line5.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,5,1,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle5.color="#ff0000"
                                           else
                                               rectangle5.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle5.color="#af12fe"
                                           else
                                               rectangle5.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle5.color="#ff0000"
                                           else
                                               rectangle5.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle5.color="#ff0000"
                                           else
                                               rectangle5.color="#ff0000"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,5,1,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle5.color="#ff0000"
                                       else
                                           rectangle5.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle5.color="#ff0000"
                                       else
                                           rectangle5.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           console.log("reverse logic");
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);




                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: line6
                   x: 514
                   y: 38
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area6
                       x: 289
                       y: 102
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][6][0]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line6.color = "#ff0000";
                                   line6.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line6.color = "#af12fe";
                                   line6.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,6,1,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle6.color="#ff0000"
                                           else
                                               rectangle6.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle6.color="#af12fe"
                                           else
                                               rectangle6.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle6.color="#ff0000"
                                           else
                                               rectangle6.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle6.color="#af12fe"
                                           else
                                               rectangle6.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,6,1,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle6.color="#ff0000"
                                       else
                                           rectangle6.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle6.color="#ff0000"
                                       else
                                           rectangle6.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);




                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: line7
                   x: 58
                   y: 122
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area7
                       x: 70
                       y: 167
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[2][1][0]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line7.color = "#ff0000";
                                   line7.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line7.color = "#af12fe";
                                   line7.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,1,2,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       console.log("D.wwinnerflag1....."+D.winnerFlag1)
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle1.color="#ff0000"
                                           else
                                               rectangle1.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle1.color="#af12fe"
                                           else
                                               rectangle1.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       console.log("D.wwinnerflag2....."+D.winnerFlag2)
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle7.color="#ff0000"
                                           else
                                               rectangle7.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle7.color="#af12fe"
                                           else
                                               rectangle7.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,1,2,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle1.color="#ff0000"
                                       else
                                           rectangle1.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle7.color="#ff0000"
                                       else
                                           rectangle7.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }



                   }
               }

               Rectangle {
                   id: line8
                   x: 148
                   y: 124
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area8
                       x: 64
                       y: 184
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][2][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line8.color = "#ff0000";
                                   line8.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line8.color = "#af12fe";
                                   line8.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,2,2,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle2.color="#ff0000"
                                           else
                                               rectangle2.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle2.color="#af12fe"
                                           else
                                               rectangle2.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle8.color="#ff0000"
                                           else
                                               rectangle8.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle8.color="#af12fe"
                                           else
                                               rectangle8.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,2,2,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle2.color="#ff0000"
                                       else
                                           rectangle2.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle8.color="#ff0000"
                                       else
                                           rectangle8.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: line9
                   x: 241
                   y: 124
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area9
                       x: 89
                       y: 191
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][3][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line9.color = "#ff0000";
                                   line9.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line9.color = "#af12fe";
                                   line9.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,3,2,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle3.color="#ff0000"
                                           else
                                               rectangle3.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle3.color="#af12fe"
                                           else
                                               rectangle3.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle9.color="#ff0000"
                                           else
                                               rectangle9.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle9.color="#af12fe"
                                           else
                                               rectangle9.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,3,2,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle3.color="#ff0000"
                                       else
                                           rectangle3.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle9.color="#ff0000"
                                       else
                                           rectangle9.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }


               }

               Rectangle {
                   id: line10
                   x: 332
                   y: 124
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area10
                       x: 262
                       y: 203
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           console.log("line10 clicked")
                           enabled:false;
                           if(D.count<45 && D.dot[1][4][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line10.color = "#ff0000";
                                   line10.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line10.color = "#af12fe";
                                   line10.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,4,2,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       console.log("D.wwinnerflag1....."+D.winnerFlag1)
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           //console.log("D.wwinnerflag2....."+D.winnerFlag2+"after setting")
                                           if (D.dotsMode==1)
                                               rectangle4.color="#ff0000"
                                           else
                                               rectangle4.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle4.color="#af12fe"
                                           else
                                               rectangle4.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       console.log("D.wwinnerflag2....."+D.winnerFlag2)
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle10.color="#ff0000"
                                           else
                                               rectangle10.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle10.color="#af12fe"
                                           else
                                               rectangle10.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,4,2,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle4.color="#ff0000"
                                       else
                                           rectangle4.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle10.color="#ff0000"
                                       else
                                           rectangle10.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: line11
                   x: 439
                   y: 175
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area11
                       x: 332
                       y: 194
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           console.log("line11 clicked")
                           enabled:false;
                           if(D.count<45 && D.dot[2][5][0]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line11.color = "#ff0000";
                                   line11.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line11.color = "#af12fe";
                                   line11.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,5,2,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       console.log("D.wwinnerflag1....."+D.winnerFlag1)
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle5.color="#ff0000"
                                           else
                                               rectangle5.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle5.color="#af12fe"
                                           else
                                               rectangle5.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       console.log("D.wwinnerflag2....."+D.winnerFlag2)
                                       console.log(D.tempPlayer)
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           console.log("D.wwinnerflag2....."+D.winnerFlag2+"after setting")
                                           if (D.dotsMode==1)
                                               rectangle11.color="#ff0000"
                                           else
                                               rectangle11.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           console.log("D.wwinnerflag2....."+D.winnerFlag2+"after setting")
                                           if (D.dotsMode==1)
                                               rectangle11.color="#af12fe"
                                           else
                                               rectangle11.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,5,2,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle5.color="#ff0000"
                                       else
                                           rectangle5.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle11.color="#ff0000"
                                       else
                                           rectangle11.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }





               Rectangle {
                   id: line12
                   x: 274
                   y: 0
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0



                   MouseArea {
                       id: mouse_area12
                       x: 341
                       y: 191
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[2][6][0]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line12.color = "#ff0000";
                                   line12.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line12.color = "#af12fe";
                                   line12.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,6,2,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle6.color="#ff0000"
                                           else
                                               rectangle6.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)



                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle6.color="#af12fe"
                                           else
                                               rectangle6.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle12.color="#ff0000"
                                           else
                                               rectangle12.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle12.color="#af12fe"
                                           else
                                               rectangle12.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,6,2,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle6.color="#ff0000"
                                       else
                                           rectangle6.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle12.color="#ff0000"
                                       else
                                           rectangle12.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};          c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }
               Rectangle {
                   id: line13
                   x: 81
                   y: 216
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area13
                       x: 156
                       y: 232
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[2][1][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line13.color = "#ff0000";
                                   line13.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line13.color = "#af12fe";
                                   line13.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,1,3,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle7.color="#ff0000"
                                           else
                                               rectangle7.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle7.color="#af12fe"
                                           else
                                               rectangle7.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle13.color="#ff0000"
                                           else
                                               rectangle13.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle13.color="#af12fe"
                                           else
                                               rectangle13.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,1,3,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle7.color="#ff0000"
                                       else
                                           rectangle7.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle13.color="#ff0000"
                                       else
                                           rectangle13.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {


                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }



                   }


               }

               Rectangle {
                   id: line14
                   x: 186
                   y: 200
                   width: 100
                   height: 100
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area14
                       x: 16
                       y: 11
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[2][2][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line14.color = "#ff0000";
                                   line14.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line14.color = "#af12fe";
                                   line14.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,2,3,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle8.color="#ff0000"
                                           else
                                               rectangle8.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle8.color="#af12fe"
                                           else
                                               rectangle8.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle14.color="#ff0000"
                                           else
                                               rectangle14.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle14.color="#af12fe"
                                           else
                                               rectangle14.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,2,3,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle8.color="#ff0000"
                                       else
                                           rectangle8.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle14.color="#ff0000"
                                       else
                                           rectangle14.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: line15
                   x: 213
                   y: 248
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area15
                       x: 89
                       y: 21
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           console.log('line 15 clicked')
                           enabled:false;
                           if(D.count<45 && D.dot[2][3][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line15.color = "#ff0000";
                                   line15.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line15.color = "#af12fe";
                                   line15.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,3,3,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle9.color="#ff0000"
                                           else
                                               rectangle9.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle9.color="#af12fe"
                                           else
                                               rectangle9.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle15.color="#ff0000"
                                           else
                                               rectangle15.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle15.color="#af12fe"
                                           else
                                               rectangle15.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,3,3,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle9.color="#ff0000"
                                       else
                                           rectangle9.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle15.color="#ff0000"
                                       else
                                           rectangle15.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: line16
                   x: 292
                   y: 223
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area16
                       x: 232
                       y: 273
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           console.log("line 16 clicked")
                           enabled:false;
                           if(D.count<45 && D.dot[2][4][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line16.color = "#ff0000";
                                   line16.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line16.color = "#af12fe";
                                   line16.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,4,3,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle10.color="#ff0000"
                                           else
                                               rectangle10.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle10.color="#af12fe"
                                           else
                                               rectangle10.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle16.color="#ff0000"
                                           else
                                               rectangle16.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle16.color="#af12fe"
                                           else
                                               rectangle16.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,4,3,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle10.color="#ff0000"
                                       else
                                           rectangle10.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle16.color="#ff0000"
                                       else
                                           rectangle16.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: line17
                   x: 361
                   y: 250
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area17
                       x: 212
                       y: 272
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[2][5][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line17.color = "#ff0000";
                                   line17.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line17.color = "#af12fe";
                                   line17.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,5,3,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle11.color="#ff0000"
                                           else
                                               rectangle11.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle11.color="#af12fe"
                                           else
                                               rectangle11.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle17.color="#ff0000"
                                           else
                                               rectangle17.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle17.color="#af12fe"
                                           else
                                               rectangle17.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,5,3,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle11.color="#ff0000"
                                       else
                                           rectangle11.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle17.color="#ff0000"
                                       else
                                           rectangle17.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: line18
                   x: 426
                   y: 270
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area18
                       x: 182
                       y: 2
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[2][6][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line18.color = "#ff0000";
                                   line18.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line18.color = "#af12fe";
                                   line18.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,6,3,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle12.color="#ff0000"
                                           else
                                               rectangle12.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle12.color="#af12fe"
                                           else
                                               rectangle12.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle18.color="#ff0000"
                                           else
                                               rectangle18.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle18.color="#af12fe"
                                           else
                                               rectangle18.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,6,3,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle12.color="#ff0000"
                                       else
                                           rectangle12.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle18.color="#ff0000"
                                       else
                                           rectangle18.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: line19
                   x: 67
                   y: 151
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area19
                       x: 58
                       y: 298
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[3][1][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line19.color = "#ff0000";
                                   line19.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line19.color = "#af12fe";
                                   line19.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(4,1,4,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle13.color="#ff0000"
                                           else
                                               rectangle13.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle13.color="#af12fe"
                                           else
                                               rectangle13.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle13.color="#ff0000"
                                           else
                                               rectangle13.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle13.color="#af12fe"
                                           else
                                               rectangle13.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(4,1,4,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle13.color="#ff0000"
                                       else
                                           rectangle13.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle13.color="#ff0000"
                                       else
                                           rectangle13.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);




                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }


               }

               Rectangle {
                   id: line20
                   x: 246
                   y: 311
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area20
                       x: 99
                       y: 240
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;

                           if(D.count<45 && D.dot[3][2][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line20.color = "#ff0000";
                                   line20.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line20.color = "#af12fe";
                                   line20.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(4,2,4,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle14.color="#ff0000"
                                           else
                                               rectangle14.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle14.color="#af12fe"
                                           else
                                               rectangle14.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle14.color="#ff0000"
                                           else
                                               rectangle14.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle14.color="#af12fe"
                                           else
                                               rectangle14.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(4,2,4,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle14.color="#ff0000"
                                       else
                                           rectangle14.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle14.color="#ff0000"
                                       else
                                           rectangle14.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: line21
                   x: 182
                   y: 0
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area21
                       x: 155
                       y: 311
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {

                           enabled:false;
                           if(D.count<45 && D.dot[3][3][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line21.color = "#ff0000";
                                   line21.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line21.color = "#af12fe";
                                   line21.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(4,3,4,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle15.color="#ff0000"
                                           else
                                               rectangle15.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle15.color="#af12fe"
                                           else
                                               rectangle15.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle15.color="#ff0000"
                                           else
                                               rectangle15.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle15.color="#af12fe"
                                           else
                                               rectangle15.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(4,3,4,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle15.color="#ff0000"
                                       else
                                           rectangle15.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle15.color="#ff0000"
                                       else
                                           rectangle15.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);




                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: line22
                   x: 339
                   y: 311
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area22
                       x: 339
                       y: 310
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {

                           enabled:false;
                           if(D.count<45 && D.dot[3][4][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line22.color = "#ff0000";
                                   line22.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line22.color = "#af12fe";
                                   line22.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(4,4,4,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle16.color="#ff0000"
                                           else
                                               rectangle16.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle16.color="#af12fe"
                                           else
                                               rectangle16.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle16.color="#ff0000"
                                           else
                                               rectangle16.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle16.color="#af12fe"
                                           else
                                               rectangle16.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(4,4,4,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle16.color="#ff0000"
                                       else
                                           rectangle16.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle16.color="#ff0000"
                                       else
                                           rectangle16.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }



               Rectangle {
                   id: line23
                   x: 429
                   y: 314
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area23
                       x: 429
                       y: 312
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;

                           if(D.count<45 && D.dot[3][5][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line23.color = "#ff0000";
                                   line23.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line23.color = "#af12fe";
                                   line23.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(4,5,4,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle17.color="#ff0000"
                                           else
                                               rectangle17.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle17.color="#af12fe"
                                           else
                                               rectangle17.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle17.color="#ff0000"
                                           else
                                               rectangle17.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle17.color="#af12fe"
                                           else
                                               rectangle17.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(4,5,4,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle17.color="#ff0000"
                                       else
                                           rectangle17.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle17.color="#ff0000"
                                       else
                                           rectangle17.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);



                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: line24
                   x: 524
                   y: 314
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area24
                       x: 520
                       y: 310
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {

                           enabled:false;
                           if(D.count<45 && D.dot[3][6][2]==0)
                           { if(D.tempPlayer==8)
                               {
                                   line24.color = "#ff0000";
                                   line24.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   line24.color = "#af12fe";
                                   line24.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(4,6,4,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle18.color="#ff0000"
                                           else
                                               rectangle18.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if (D.dotsMode==1)
                                               rectangle18.color="#af12fe"
                                           else
                                               rectangle18.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle18.color="#ff0000"
                                           else
                                               rectangle18.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if (D.dotsMode==1)
                                               rectangle18.color="#af12fe"
                                           else
                                               rectangle18.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(4,6,4,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if (D.dotsMode==1)
                                           rectangle18.color="#ff0000"
                                       else
                                           rectangle18.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if (D.dotsMode==1)
                                           rectangle18.color="#ff0000"
                                       else
                                           rectangle18.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var u = {x:0,y:0,a:0,b:0};

                                           var u=D.AIcoordinateGenerator();
                                           D.dotsCaller(u.x,u.y,u.a,u.b);

                                           drawLine(u.x,u.y,u.a,u.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);




                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }
               Rectangle {
                   id:vline1
                   x: 46
                   y: 105
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area25
                       x: 28
                       y: 76
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][1][3]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline1.color = "#ff0000";
                                   vline1.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline1.color = "#af12fe";
                                   vline1.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,1,2,1)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle1.color="#ff0000"
                                           else
                                               rectangle1.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle1.color="#af12fe"
                                           else
                                               rectangle1.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle1.color="#ff0000"
                                           else
                                               rectangle1.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle1.color="#af12fe"
                                           else
                                               rectangle1.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,1,2,1)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle1.color="#ff0000"
                                       else
                                           rectangle1.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle1.color="#ff0000"
                                       else
                                           rectangle1.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }



                   }
               }

               Rectangle {
                   id: vline2
                   x: 120
                   y: 74
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area26
                       x: 128
                       y: 79
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][1][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline2.color = "#ff0000";
                                   vline2.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline2.color = "#af12fe";
                                   vline2.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,2,2,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle2.color="#ff0000"
                                           else
                                               rectangle2.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle2.color="#af12fe"
                                           else
                                               rectangle2.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle1.color="#ff0000"
                                           else
                                               rectangle1.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle1.color="#af12fe"
                                           else
                                               rectangle1.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,2,2,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle2.color="#ff0000"
                                       else
                                           rectangle2.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle1.color="#ff0000"
                                       else
                                           rectangle1.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);




                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: vline3
                   x: 212
                   y: 74
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area27
                       x: 212
                       y: 74
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][2][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline3.color = "#ff0000";
                                   vline3.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline3.color = "#af12fe";
                                   vline3.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,3,2,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle3.color="#ff0000"
                                           else
                                               rectangle3.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle3.color="#af12fe"
                                           else
                                               rectangle3.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle2.color="#ff0000"
                                           else
                                               rectangle2.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle2.color="#af12fe"
                                           else
                                               rectangle2.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,3,2,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle3.color="#ff0000"
                                       else
                                           rectangle3.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle2.color="#ff0000"
                                       else
                                           rectangle2.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: vline4
                   x: 245
                   y: -137
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area28
                       x: 245
                       y: -50
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][3][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline4.color = "#ff0000";
                                   vline4.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline4.color = "#af12fe";
                                   vline4.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   console.log("playermode 1")
                                   D.dotsCaller(1,4,2,4)
                                   console.log("dots caller called and returned")
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       console.log("dfhfh1")
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle4.color="#ff0000"
                                           else
                                               rectangle4.color="#ff0000"
                                           console.log("dfhfh")
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           console.log("dfhfh2")
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle4.color="#af12fe"
                                           else
                                               rectangle4.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle3.color="#ff0000"
                                           else
                                               rectangle3.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle3.color="#af12fe"
                                           else
                                               rectangle3.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,4,2,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle4.color="#ff0000"
                                       else
                                           rectangle4.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle3.color="#ff0000"
                                       else
                                           rectangle3.color="#ff0000"
                                       //console.log("dfhfh")
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }
               Rectangle {
                   id: vline5
                   x: 339
                   y: 75
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area29
                       x: 335
                       y: -49
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][4][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline5.color = "#ff0000";
                                   vline5.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline5.color = "#af12fe";
                                   vline5.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,5,2,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle5.color="#ff0000"
                                           else
                                               rectangle5.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle5.color="#af12fe"
                                           else
                                               rectangle5.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle4.color="#ff0000"
                                           else
                                               rectangle4.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle4.color="#af12fe"
                                           else
                                               rectangle4.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,5,2,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle5.color="#ff0000"
                                       else
                                           rectangle5.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle4.color="#ff0000"
                                       else
                                           rectangle4.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: vline6
                   x: 487
                   y: 74
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area30
                       x: 487
                       y: 74
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][5][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline6.color = "#ff0000";
                                   vline6.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline6.color = "#af12fe";
                                   vline6.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,6,2,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle6.color="#ff0000"
                                           else
                                               rectangle6.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle6.color="#af12fe"
                                           else
                                               rectangle6.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle5.color="#ff0000"
                                           else
                                               rectangle5.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle5.color="#af12fe"
                                           else
                                               rectangle5.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,6,2,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle6.color="#ff0000"
                                       else
                                           rectangle6.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle5.color="#ff0000"
                                       else
                                           rectangle5.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: vline7
                   x: 516
                   y: -148
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area36
                       x: 577
                       y: 77
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[1][6][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline7.color = "#ff0000";
                                   vline7.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline7.color = "#af12fe";
                                   vline7.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(1,7,2,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle6.color="#ff0000"
                                           else
                                               rectangle6.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle6.color="#af12fe"
                                           else
                                               rectangle6.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle6.color="#ff0000"
                                           else
                                               rectangle6.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle6.color="#af12fe"
                                           else
                                               rectangle6.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(1,7,2,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle6.color="#ff0000"
                                       else
                                           rectangle6.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle6.color="#ff0000"
                                       else
                                           rectangle6.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: vline8
                   x: 34
                   y: 170
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area31
                       x: 28
                       y: 168
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           console.log("8clicked");
                           enabled:false;
                           if(D.count<45 && D.dot[2][1][3]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline8.color = "#ff0000";
                                   vline8.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline8.color = "#af12fe";
                                   vline8.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,1,3,1)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle7.color="#ff0000"
                                           else
                                               rectangle7.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle7.color="#af12fe"
                                           else
                                               rectangle7.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle7.color="#ff0000"
                                           else
                                               rectangle7.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle7.color="#af12fe"
                                           else
                                               rectangle7.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,1,3,1)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle7.color="#ff0000"
                                       else
                                           rectangle7.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle7.color="#ff0000"
                                       else
                                           rectangle7.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: vline9
                   x: 122
                   y: 170
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area32
                       x: 119
                       y: 167
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {

                           enabled:false;
                           if(D.count<45 && D.dot[2][1][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline9.color = "#ff0000";
                                   vline9.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline9.color = "#af12fe";
                                   vline9.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,2,3,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle8.color="#ff0000"
                                           else
                                               rectangle8.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle8.color="#af12fe"
                                           else
                                               rectangle8.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle7.color="#ff0000"
                                           else
                                               rectangle7.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle7.color="#af12fe"
                                           else
                                               rectangle7.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,2,3,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle8.color="#ff0000"
                                       else
                                           rectangle8.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle7.color="#ff0000"
                                       else
                                           rectangle7.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {


                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }


               }

               Rectangle {
                   id: vline10
                   x: 152
                   y: -55
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area33
                       x: 92
                       y: 0
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[2][2][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline10.color = "#ff0000";
                                   vline10.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline10.color = "#af12fe";
                                   vline10.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,3,3,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle9.color="#ff0000"
                                           else
                                               rectangle9.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle9.color="#af12fe"
                                           else
                                               rectangle9.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle8.color="#ff0000"
                                           else
                                               rectangle8.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle8.color="#af12fe"
                                           else
                                               rectangle8.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,3,3,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle9.color="#ff0000"
                                       else
                                           rectangle9.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle8.color="#ff0000"
                                       else
                                           rectangle8.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: vline11
                   x: 303
                   y: 167
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area34
                       x: 303
                       y: 167
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           console.log("vline11 clicked")
                           enabled:false;
                           if(D.count<45 && D.dot[2][3][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline11.color = "#ff0000";
                                   vline11.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline11.color = "#af12fe";
                                   vline11.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,4,3,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle10.color="#ff0000"
                                           else
                                               rectangle10.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle10.color="#af12fe"
                                           else
                                               rectangle10.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle9.color="#ff0000"
                                           else
                                               rectangle9.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle9.color="#af12fe"
                                           else
                                               rectangle9.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,4,3,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle10.color="#ff0000"
                                       else
                                           rectangle10.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle9.color="#ff0000"
                                       else
                                           rectangle9.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: vline12
                   x: 394
                   y: 167
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area35
                       x: 395
                       y: 167
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           console.log("vline12 clicked");
                           enabled:false;
                           if(D.count<45 && D.dot[2][4][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline12.color = "#ff0000";
                                   vline12.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline12.color = "#af12fe";
                                   vline12.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,5,3,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle11.color="#ff0000"
                                           else
                                               rectangle11.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle11.color="#af12fe"
                                           else
                                               rectangle11.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle10.color="#ff0000"
                                           else
                                               rectangle10.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle10.color="#af12fe"
                                           else
                                               rectangle10.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,5,3,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle11.color="#ff0000"
                                       else
                                           rectangle11.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle10.color="#ff0000"
                                       else
                                           rectangle10.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: vline13
                   x: 487
                   y: 167
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area37
                       x: 487
                       y: 167
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[2][5][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline13.color = "#ff0000";
                                   vline13.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline13.color = "#af12fe";
                                   vline13.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,6,3,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle12.color="#ff0000"
                                           else
                                               rectangle12color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle12.color="#af12fe"
                                           else
                                               rectangle12.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle11.color="#ff0000"
                                           else
                                               rectangle11.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle11.color="#af12fe"
                                           else
                                               rectangle11.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,6,3,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle12.color="#ff0000"
                                       else
                                           rectangle12.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle11.color="#ff0000"
                                       else
                                           rectangle11.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }
               Rectangle {
                   id: vline14
                   x: 365
                   y: 0
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area38
                       x: 576
                       y: 167
                       width: 100
                       height: 100
                       opacity: 0


                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[2][6][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline14.color = "#ff0000";
                                   vline14.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline14.color = "#af12fe";
                                   vline14.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(2,7,3,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle12.color="#ff0000"
                                           else
                                               rectangle12.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle12.color="#af12fe"
                                           else
                                               rectangle12.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle12.color="#ff0000"
                                           else
                                               rectangle12.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle12.color="#af12fe"
                                           else
                                               rectangle12.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(2,7,3,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle12.color="#ff0000"
                                       else
                                           rectangle12.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle12.color="#ff0000"
                                       else
                                           rectangle12.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: vline15
                   x: 29
                   y: 260
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area39
                       x: 30
                       y: 253
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[3][1][3]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline15.color = "#ff0000";
                                   vline15.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline15.color = "#af12fe";
                                   vline15.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,1,4,1)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle13.color="#ff0000"
                                           else
                                               rectangle13.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle13.color="#af12fe"
                                           else
                                               rectangle13.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle13.color="#ff0000"
                                           else
                                               rectangle13.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle13.color="#af12fe"
                                           else
                                               rectangle13.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,1,4,1)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle13.color="#ff0000"
                                       else
                                           rectangle13.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle13.color="#ff0000"
                                       else
                                           rectangle13.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }
               Rectangle {
                   id: vline16
                   x: 90
                   y: 0
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area40
                       x: 121
                       y: 258
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[3][1][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline16.color = "#ff0000";
                                   vline16.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline16.color = "#af12fe";
                                   vline16.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,2,4,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle14.color="#ff0000"
                                           else
                                               rectangle14.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle14.color="#af12fe"
                                           else
                                               rectangle14.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle13.color="#ff0000"
                                           else
                                               rectangle13.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle13.color="#af12fe"
                                           else
                                               rectangle13.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,2,4,2)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle14.color="#ff0000"
                                       else
                                           rectangle14.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle13.color="#ff0000"
                                       else
                                           rectangle13.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: vline17
                   x: 214
                   y: 260
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area41
                       x: 212
                       y: 260
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[3][2][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline17.color = "#ff0000";
                                   vline17.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline17.color = "#af12fe";
                                   vline17.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,3,4,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle15.color="#ff0000"
                                           else
                                               rectangle15.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle15.color="#af12fe"
                                           else
                                               rectangle15.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle14.color="#ff0000"
                                           else
                                               rectangle14.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle14.color="#af12fe"
                                           else
                                               rectangle14.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,3,4,3)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle15.color="#ff0000"
                                       else
                                           rectangle15.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle14.color="#ff0000"
                                       else
                                           rectangle14.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: vline18
                   x: 303
                   y: 258
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area42
                       x: 303
                       y: 258
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[3][3][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline18.color = "#ff0000";
                                   ///10000!!!!!!!!
                                   vline18.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline18.color = "#af12fe";
                                   vline18.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,4,4,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle16.color="#ff0000"
                                           else
                                               rectangle16.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle16.color="#af12fe"
                                           else
                                               rectangle16.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle15.color="#ff0000"
                                           else
                                               rectangle15.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle15.color="#af12fe"
                                           else
                                               rectangle15.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,4,4,4)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle16.color="#ff0000"
                                       else
                                           rectangle16.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle15.color="#ff0000"
                                       else
                                           rectangle15.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }

                   }
               }

               Rectangle {
                   id: vline19
                   x: 394
                   y: 260
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area43
                       x: 394
                       y: 260
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[3][4][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline19.color = "#ff0000";
                                   vline19.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline19.color = "#af12fe";
                                   vline19.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,5,4,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle17.color="#ff0000"
                                           else
                                               rectangle17.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle17.color="#af12fe"
                                           else
                                               rectangle17.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle16.color="#ff0000"
                                           else
                                               rectangle16.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle16.color="#af12fe"
                                           else
                                               rectangle16.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,5,4,5)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle17.color="#ff0000"
                                       else
                                           rectangle17.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle16.color="#ff0000"
                                       else
                                           rectangle16.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }


                   }
               }

               Rectangle {
                   id: vline20
                   x: 487
                   y: 258
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area45
                       x: 276
                       y: 1
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[3][5][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline20.color = "#ff0000";
                                   vline20.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline20.color = "#af12fe";
                                   vline20.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,6,4,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle18.color="#ff0000"
                                           else
                                               rectangle18.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle18.color="#af12fe"
                                           else
                                               rectangle18.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle17.color="#ff0000"
                                           else
                                               rectangle17.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle17.color="#af12fe"
                                           else
                                               rectangle17.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,6,4,6)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle18.color="#ff0000"
                                       else
                                           rectangle18.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle17.color="#ff0000"
                                       else
                                           rectangle17.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {

                                           var c1 = {x:0,y:0,a:0,b:0};
                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }
                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;
                       }
                   }
               }

               Rectangle {
                   id: vline21
                   x: 576
                   y: 258
                   width: 200
                   height: 200
                   color: "#ffffff"
                   opacity: 0

                   MouseArea {
                       id: mouse_area46
                       x: 576
                       y: 259
                       width: 100
                       height: 100
                       opacity: 0

                       onClicked: {
                           enabled:false;
                           if(D.count<45 && D.dot[3][6][1]==0)
                           { if(D.tempPlayer==8)
                               {
                                   vline21.color = "#ff0000";
                                   vline21.opacity=1;
                               }

                               else if(D.tempPlayer==9)
                               {
                                   vline21.color = "#af12fe";
                                   vline21.opacity=1;
                               }

                               if(D.playmode==1)//player vs player
                               {
                                   D.dotsCaller(3,7,4,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle18.color="#ff0000"
                                           else
                                               rectangle18.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag1=0;
                                           if(D.dotsMode==1)
                                               rectangle18.color="#af12fe"
                                           else
                                               rectangle18.color="#af12fe"
                                       }
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       if(D.tempPlayer==8)
                                       {D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle18.color="#ff0000"
                                           else
                                               rectangle18.color="#ff0000"
                                       }
                                       else if(D.tempPlayer==9)
                                       {
                                           D.winnerFlag2=0;
                                           if(D.dotsMode==1)
                                               rectangle18.color="#af12fe"
                                           else
                                               rectangle18.color="#af12fe"
                                       }
                                   }



                               }
                               else if(D.playmode==2)//player vs cpu
                               {



                                   D.dotsCaller(3,7,4,7)
                                   D.count++;
                                   if(D.winnerFlag1==1)
                                   {
                                       D.winnerFlag1=0;
                                       if(D.dotsMode==1)
                                           rectangle18.color="#ff0000"
                                       else
                                           rectangle18.color="#ff0000"
                                   }
                                   if(D.winnerFlag2==1)
                                   {
                                       D.winnerFlag2=0;
                                       if(D.dotsMode==1)
                                           rectangle18.color="#ff0000"
                                       else
                                           rectangle18.color="#ff0000"
                                   }
                                   while(D.tempPlayer==9 && D.count<45)
                                   {D.count++;
                                       if(D.dotsMode==1)
                                       {
                                           var c1 = {x:0,y:0,a:0,b:0};

                                           c1=D.AIcoordinateGenerator();
                                           D.dotsCaller(c1.x,c1.y,c1.a,c1.b);

                                           drawLine(c1.x,c1.y,c1.a,c1.b);

                                       }

                                       else if(D.dotsMode==2)
                                       {
                                           var c = {x:0,y:0,a:0,b:0};

                                           c=D.AIcoordinateGeneratorReverse();
                                           D.dotsCaller(c.x,c.y,c.a,c.b);
                                           drawLine(c.x,c.y,c.a,c.b);


                                       }

                                   }

                               }


                           }

                           scoreNumL.text = ""+D.count1;
                           scoreNumR.text = ""+D.count2;

                       }
                   }
               }

        Rectangle {
            id: rectangle1
            x: 35
            y: -97
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle2
            x: 155
            y: 74
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle3
            x: 247
            y: 74
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle4
            x: 218
            y: -94
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle5
            x: 309
            y: -184
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle6
            x: 520
            y: 74
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle7
            x: 35
            y: 0
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle8
            x: 0
            y: 40
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle9
            x: 247
            y: 167
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle10
            x: 339
            y: 167
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle11
            x: 428
            y: 167
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle12
            x: 456
            y: -144
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle13
            x: 65
            y: 258
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle14
            x: 0
            y: 36
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle15
            x: 91
            y: 0
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle16
            x: 339
            y: 258
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle17
            x: 274
            y: 37
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Rectangle {
            id: rectangle18
            x: 366
            y: 0
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 0
        }

        Image {
            id: image1
            x: 24
            y: 37
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image2
            x: 168
            y: 2
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image3
            x: 208
            y: 36
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image4
            x: 243
            y: -98
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image5
            x: 243
            y: -91
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image6
            x: 480
            y: 38
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image7
            x: 359
            y: -31
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image8
            x: 24
            y: 130
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image9
            x: 60
            y: -92
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image10
            x: 146
            y: -1
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image11
            x: 391
            y: 127
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image12
            x: 391
            y: 127
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image13
            x: 327
            y: -39
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image14
            x: 330
            y: -92
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image15
            x: 26
            y: 218
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image16
            x: 115
            y: 219
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image17
            x: -33
            y: 88
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image18
            x: 185
            y: 3
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image19
            x: 58
            y: 0
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image20
            x: 277
            y: 3
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image21
            x: 330
            y: -7
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image22
            x: 27
            y: 308
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image23
            x: -32
            y: -2
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image24
            x: 87
            y: 54
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image25
            x: 231
            y: 49
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image26
            x: 390
            y: 309
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image27
            x: 330
            y: 0
            source: "img/dot.png"
            opacity: 0
        }

        Image {
            id: image28
            x: 541
            y: 57
            source: "img/dot.png"
            opacity: 0
        }




    }

    Image {
        id: getSetGo
        x: 249
        y: 40
        source: "img/getsetgo.png"
        opacity: 0
    }

    Image {
        id: playScore
        x: 0
        y: 0
        source: "img/scorecard.jpg"
        opacity: 0
    }

    Text {
        id: scoreL
        x: -40
        y: 233
        text: qsTr("text")
        font.pixelSize: 12
        opacity: 0
    }

    Text {
        id: scoreR
        x: 604
        y: 5
        text: qsTr("text")
        font.pixelSize: 12
        opacity: 0
    }

    Text {
        id: scoreNumL
        x: -7
        y: 100
        text: qsTr("text")
        font.pixelSize: 12
        opacity: 0
    }

    Text {
        id: scoreNumR
        x: 0
        y: 183
        text: qsTr("text")
        font.pixelSize: 12
        opacity: 0
    }

    Image {
        id: pauseDropCard
        x: 0
        y: -283
        source: "img/pauseDropCard.png"
        opacity: 0

        //NumberAnimation on y {id: pauseCardDown; from: -354; to: 0; duration: 1500; running: false; easing.type: Easing.InOutQuad; }
        //NumberAnimation on y {id: pauseCardUp; from: 0; to: -354; duration: 1500; running: false; easing.type: Easing.InOutQuad; }

         NumberAnimation on y { id:pauseCardDown; running: false;  from: -354; to: 0; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }
         NumberAnimation on y { id:pauseCardUp; running: false;  from: 0; to: -354; duration: UI.menuDuration; easing.type: Easing.InOutQuad; }

        MouseArea {
            id: maPause
            x: 263
            y: 324
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                if(UI.down == 0)
                {
                    pauseCardDown.running = true;
                    UI.down = 1;
                }
                else if(UI.down == 1)
                {
                    pauseCardUp.running = true;
                    UI.down = 0;
                }
            }
        }

        Image {
            id: pauseMainMenu
            x: 178
            y: 181
            source: "img/pauseMainMenu.png"
            opacity: 0

            MouseArea {
                id: maPauseMainMenu
                x: 0
                y: -106
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    common();
                    //reset the pause menu to normal
                    UI.down = 0;


                    console.log("pauseMainMenu Clicked!.. reset all the game variables if necessary!...");
                    //jump to main menu (logo animation is over)
                    rect.state = "mainmenu";
                    playmoveR.running = true;    //running the playCard movement
                    ///////////sdotsopacity.running = true;    //running the play smartdots opacity
                    ///////////rdotsopacity.running = true;    //running the play reversedots opacity
                    //deactivate play ma
                    maPlay.opacity = 0;
                    //activate all other ma
                    maHelp.opacity = 1;
                    maAbout.opacity = 1;
                    maHighscores.opacity = 1;
                    maExit.opacity = 1;

                    //everything's else contents fadeout
                    aysfadeout.running = true;
                    yesfadeout.running = true;
                    nofadeout.running = true;
                    helpsdotsfadeout.running = true;
                    helprdotsfadeout.running = true;
                    //if any fadeout for highscores

                    hsbeginnerfadeout.running = true;
                    hsintermediatefadeout.running = true;
                    hsexpertfadeout.running = true;
                    abouttextfadeout.running = true;


                    //play's content fadein
                    playsdotsfadein.running = true;
                    playrdotsfadein.running = true;

                }
            }
        }

        Image {
            id: pauseHelp
            x: 178
            y: 75
            source: "img/pauseHelp.png"
            opacity: 0

            MouseArea {
                id: maPauseHelp
                x: 0
                y: 0
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    console.log("pauseHelp clicked... show the appropriate help based on the current game!");
                    if(D.dotsMode == 1)    //check if they are playing smartdots
                    {

                            pauseHelpsdots.z = 35;
                            helpListView.opacity = 1;
                            helpListView.z = 40;
                            helpListView.x = 0;
                            helpListView.y = 0;

                            helpListView.width = 640;
                            helpListView.height = 270;



                    }
                    else if(D.dotsMode == 2)   //check if they are playing reversedots
                    {
                        pauseHelprdots.z = 35;
                        helpRListView.opacity = 1;
                        helpRListView.z = 40;

                        helpRListView.x = 0;
                        helpRListView.y = 0;

                        helpRListView.width = 640;
                        helpRListView.height = 270;
                    }
                }
            }
        }
    }

    Image {
        id: pauseHelpsdots
        x: 0
        y: 0
        source: "img/grid.jpg"
        opacity: 0

        Image {
            id: pauseHelpsdotsback
            x: 11
            y: 280
            source: "img/back.png"
            opacity: 0

            MouseArea {
                id: maPHsdb
                x: 17
                y: 0
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    pauseHelpsdots.z = -5;
                    helpListView.opacity = 0;
                    helpListView.z = 0;
                }
            }
        }
    }

    Image {
        id: pauseHelprdots
        x: 0
        y: 0
        source: "img/grid.jpg"
        opacity: 0

        Image {
            id: pauseHelprdotsback
            x: 6
            y: 280
            source: "img/back.png"
            opacity: 0

            MouseArea {
                id: maPHrdb
                x: 28
                y: 0
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    pauseHelprdots.z = -5;
                    helpRListView.opacity = 0;
                    helpRListView.z = 0;
                }
            }
        }
    }

    Image {
        id: endDropCard
        x: 1
        y: -384
        source: "img/endDropCard.png"
        opacity: 0
        NumberAnimation on y { id:endCardDown; running: false;  from: -384; to: -30; duration: UI.menuDuration; easing.type: Easing.InOutQuad;  }

        Image {
            id: endMainMenu
            x: 422
            y: 465
            source: "img/ENDMainMenu.png"
            opacity: 0

            MouseArea {
                id: maEndMainMenu
                x: -365
                y: 60
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    highscore(1);
                    common();
                    console.log("end main menu clicked, goto main menu and bring play effects also reset all play variables");

                    //reset the pause menu to normal
                    UI.down = 0;


                    console.log("pauseMainMenu Clicked!.. reset all the game variables if necessary!...");
                    //jump to main menu (logo animation is over)
                    rect.state = "mainmenu";
                    playmoveR.running = true;    //running the playCard movement
                    ///////////sdotsopacity.running = true;    //running the play smartdots opacity
                    ///////////rdotsopacity.running = true;    //running the play reversedots opacity
                    //deactivate play ma
                    maPlay.opacity = 0;
                    //activate all other ma
                    maHelp.opacity = 1;
                    maAbout.opacity = 1;
                    maHighscores.opacity = 1;
                    maExit.opacity = 1;

                    //everything's else contents fadeout
                    aysfadeout.running = true;
                    yesfadeout.running = true;
                    nofadeout.running = true;
                    helpsdotsfadeout.running = true;
                    helprdotsfadeout.running = true;
                    //if any fadeout for highscores

                    hsbeginnerfadeout.running = true;
                    hsintermediatefadeout.running = true;
                    hsexpertfadeout.running = true;
                    abouttextfadeout.running = true;


                    //play's content fadein
                    playsdotsfadein.running = true;
                    playrdotsfadein.running = true;
                }
            }
        }

        Image {
            id: endPlayAgain
            x: 37
            y: 281
            source: "img/ENDPlayAgain.png"
            opacity: 0

            MouseArea {
                id: maEndPlayAgain
                x: 8
                y: 3
                width: 100
                height: 100
                opacity: 0
                onClicked: {
                    common();
                    console.log("end play again clicked.. goto palyArea and reset all the game variables!");
                    if(D.playmode == 1)
                    {
                        scoreL.text = ""+"PLAYER 1";
                        scoreR.text = ""+"PLAYER 2";
                    }
                    else
                    {
                        scoreL.text = ""+"PLAYER";
                        scoreR.text = ""+"PHONE";
                    }

                    rect.state = "playArea";
                }
            }
        }

        Image {
            id: win
            x: 40
            y: 11
            source: "img/win.png"
            opacity: 0
        }

        Image {
            id: lose
            x: 39
            y: 12
            source: "img/lose.png"
            opacity: 0
        }

        Image {
            id: highwin
            x: 39
            y: 12
            source: "img/highwin.png"
            opacity: 0
        }

        Image {
            id: p1win
            x: 39
            y: 11
            source: "img/p1win.png"
            opacity: 0
        }

        Image {
            id: p2win
            x: 39
            y: 12
            source: "img/p2win.png"
            opacity: 0
        }

        Image {
            id: draw
            x: 132
            y: 678
            source: "img/draw.png"
            opacity: 0
        }

    }

    Image {
        id: mainsdotsBack
        x: 6
        y: 280
        source: "img/back.png"
        opacity: 0

        MouseArea {
            id: maMainSdotsBack
            x: 0
            y: 0
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                //rect.state = "mainmenu"
                /*//usual hoopla
                if(exitCard.x == 0)
                {
                    //current view is exit
                    //exit's fadeout
                    exitmoveL.running = true;
                    aboutmoveL.running = true;
                    highscoremoveL.running = true;
                    //help's fadein

                    //exit's content fadeout
                    aysfadeout.running = true;
                    yesfadeout.running = true;
                    nofadeout.running = true;
                }
                else if(aboutCard.x == 0)
                {
                    //current view is about
                    //about's fadeout
                    aboutmoveL.running = true;
                    highscoremoveL.running = true;
                    //help's fadein

                    //about's content fadeout
                    abouttextfadeout.running = true;
                }
                else if(highscoreCard.x == 0)
                {
                    //current view is highscore
                    //highscore's fadeout
                    highscoremoveL.running = true;
                    //helps's fadein


                    //highscore's content fadeout SHOULD BE IMPLMENTED HERE (!important)
                }
                else if(playCard.x == 0)
                {
                    //current view is play
                    //play's fadeout
                    helpmoveR.running = true;
                    //help's fadein

                    //play's content fadeout
                    playsdotsfadeout.running = true;
                    playrdotsfadeout.running = true;
                }


                //Handling mas'
                maAbout.opacity = 1;
                maExit.opacity = 1;
                maHighscores.opacity = 1;
                //turning off help's opacity
                maHelp.opacity = 0;
                maPlay.opacity = 1;

                //now the help contents should appear
                helpsdotsfadein.running = true;
                helprdotsfadein.running = true;
                ///////*/

                rect.state = "mainmenu";
                playmoveR.running = true;    //running the playCard movement
                ///////////sdotsopacity.running = true;    //running the play smartdots opacity
                ///////////rdotsopacity.running = true;    //running the play reversedots opacity
                //deactivate play ma
                helpmoveR.running = true;
                maPlay.opacity = 1;

                //activate all other ma
                maHelp.opacity = 0;
                maAbout.opacity = 1;
                maHighscores.opacity = 1;
                maExit.opacity = 1;

                //everything's else contents fadeout
                aysfadeout.running = true;
                yesfadeout.running = true;
                nofadeout.running = true;
                helpsdotsfadein.running = true;
                helprdotsfadein.running = true;
                //if any fadeout for highscores

                hsbeginnerfadeout.running = true;
                hsintermediatefadeout.running = true;
                hsexpertfadeout.running = true;
                abouttextfadeout.running = true;
                playsdotsfadeout.running = true;
                playrdotsfadeout.running = true;
            }
        }
    }

    Image {
        id: mainrdotsBack
        x: 6
        y: 280
        source: "img/back.png"
        opacity: 0

        MouseArea {
            id: maMainRdotsBack
            x: 0
            y: 0
            width: 100
            height: 100
            opacity: 0
            onClicked: {
                //rect.state = "mainmenu"
                //usual hoopla
                /*if(exitCard.x == 0)
                {
                    //current view is exit
                    //exit's fadeout
                    exitmoveL.running = true;
                    aboutmoveL.running = true;
                    highscoremoveL.running = true;
                    //help's fadein

                    //exit's content fadeout
                    aysfadeout.running = true;
                    yesfadeout.running = true;
                    nofadeout.running = true;
                }
                else if(aboutCard.x == 0)
                {
                    //current view is about
                    //about's fadeout
                    aboutmoveL.running = true;
                    highscoremoveL.running = true;
                    //help's fadein

                    //about's content fadeout
                    abouttextfadeout.running = true;
                }
                else if(highscoreCard.x == 0)
                {
                    //current view is highscore
                    //highscore's fadeout
                    highscoremoveL.running = true;
                    //helps's fadein


                    //highscore's content fadeout SHOULD BE IMPLMENTED HERE (!important)
                }
                else if(playCard.x == 0)
                {
                    //current view is play
                    //play's fadeout
                    helpmoveR.running = true;
                    //help's fadein

                    //play's content fadeout
                    playsdotsfadeout.running = true;
                    playrdotsfadeout.running = true;
                }


                //Handling mas'
                maAbout.opacity = 1;
                maExit.opacity = 1;
                maHighscores.opacity = 1;
                //turning off help's opacity
                maHelp.opacity = 0;
                maPlay.opacity = 1;

                //now the help contents should appear
                helpsdotsfadein.running = true;
                helprdotsfadein.running = true;
                ///////*/

                rect.state = "mainmenu";
                playmoveR.running = true;    //running the playCard movement
                ///////////sdotsopacity.running = true;    //running the play smartdots opacity
                ///////////rdotsopacity.running = true;    //running the play reversedots opacity
                //deactivate play ma
                helpmoveR.running = true;
                maPlay.opacity = 1;

                //activate all other ma
                maHelp.opacity = 0;
                maAbout.opacity = 1;
                maHighscores.opacity = 1;
                maExit.opacity = 1;

                //everything's else contents fadeout
                aysfadeout.running = true;
                yesfadeout.running = true;
                nofadeout.running = true;
                helpsdotsfadein.running = true;
                helprdotsfadein.running = true;
                //if any fadeout for highscores

                hsbeginnerfadeout.running = true;
                hsintermediatefadeout.running = true;
                hsexpertfadeout.running = true;
                abouttextfadeout.running = true;
                playsdotsfadeout.running = true;
                playrdotsfadeout.running = true;


                //play's content fadein

            }
        }
    }






}
