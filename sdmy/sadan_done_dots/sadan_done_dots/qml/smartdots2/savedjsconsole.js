function f()
{
    dot = create3DArray(5,8,6);
    UImatrix = create2DArray(4,7);
    tempPlayer = 8;
    tempSum1 = 0;
    tempSum2 = 0;
    namcount = 0;
    internalFlag = 0;
    tempSum = 0;
    count = 0;
    count1=0;
    count2=0;
    greater = 0;
    s=0;
    highScoreValue = 0;
    level;//getlevel();//level
    playmode;//getplayermode();//cpu-2 player 1
    dotsMode;//getdotsmode();//sdots 1 rdots 2
    mainmenucount;//To check if it is coming from bounce.qml and lose.qml and win.qml


    winnerFlag1=0;
    winnerFlag2=0;

}

function print()
{
    console.log(level);
    console.log(playmode);
    console.log(dotsMode);
}

//--- to generate 3d arrays
function create3DArray(d1, d2, d3) {


    var x3d = new Array(d1);

    for (var i=0; i < d1; i++) {
        x3d[i] = new Array(d2);
    }

    for (var i=0; i < d1; i++) {
        for (var j=0; j < d2; j++) {
            x3d[i][j] = new Array(d3);
        }
    }

    // By uncommenting the next lines you can set the array cells
    // to a preliminary value (to zero below)
    // Otherwise the cells are left to the undefined value
    for (var i=0; i < d1; i++) {
        for (var j=0; j < d2; j++) {
            for (var k=0; k < d3; k++) {
                x3d[i][j][k] = 0;
            }
        }
    }

    return x3d;
}

//--- to create 2d arrays
function create2DArray(d1, d2) {


    var x2d = new Array(d1);

    for (var i=0; i < d1; i++) {
        x2d[i] = new Array(d2);
    }



    // By uncommenting the next lines you can set the array cells
    // to a preliminary value (to zero below)
    // Otherwise the cells are left to the undefined value
    for (var i=0; i < d1; i++) {
        for (var j=0; j < d2; j++) {
            x2d[i][j] = 0;
        }
    }

    return x2d;
}

//---- CREATING RCL

//-----------------




// Create a new array variant for your use
var dot = new Array();

// Below you create an array of chosen 'dimensions'
dot = create3DArray(5,8,6); // creates a 3 x 3 x 4 array

var UImatrix = new Array();
UImatrix = create2DArray(4,7);

var tempPlayer = 8;
var tempSum1 = 0;
var tempSum2 = 0;
var namcount = 0;
var internalFlag = 0;
var tempSum = 0;
var count = 0;
var count1=0;
var count2=0;
var s;
var level;//getlevel();//level
var playmode;//getplayermode();//cpu-2 player 1
var dotsMode;//getdotsmode();//sdots 1 rdots 2
var mainmenucount;//To check if it is coming from bounce.qml and lose.qml and win.qml
var getTwoflag=0;
var getThreeflag=0;
var highScoreValue = 0;

var forrow;
var forcol;
var forline;
var greater = 0;
var winnerFlag1=0;
var winnerFlag2=0;
// main()
//------- toggle func defn
function toggle()
{
    if(tempPlayer == 8)
    {
        tempPlayer = 9;
    }
    else if(tempPlayer == 9)
    {
        tempPlayer = 8;
    }
}
//------------------------


function printUImatrix()
{
    for( forrow = 1 ; forrow < 4; forrow++)
    {
        for( forcol = 1; forcol < 7; forcol++)
        {

            console.log(UImatrix[forrow][forcol]);


            console.log("<br>");

        }

        console.log("<br>");

    }
}

//---- print whole DS
function printWholeDataStructure()
{
    console.log("<br>Whole DS is " );


    for( forrow = 1 ; forrow < 4; forrow++)
    {
        for( forcol = 1; forcol < 7; forcol++)
        {
            for( forline = 0; forline<5; forline++)
                console.log(dot[forrow][forcol][forline]);


            console.log("<br>");

        }

        console.log("<br>");

    }
}
//------------------------


// -- set winner flag if 4
function setWinnerFlagIf4(row,col)
{//changed from var row to row


    if(internalFlag == 0)
    {
        tempSum=0;
        for( forline = 0; forline < 4; forline++)
        {//console.log("internal flag =0 and inside for")
            tempSum+= dot[row][col][forline];


        }
        //console.log("temp sum="+tempSum)

        if(tempSum == 4)
        {//console.log("temp sum4="+tempSum)

            dot[row][col][4] = tempPlayer;
            winnerFlag1=1;
            if(tempPlayer==8)
            {
                if(dotsMode==1)
                {
                    count1++;
                }
                else if(dotsMode==2)
                {
                    count1++;
                }
            }


            else if(tempPlayer==9)
            {
                if(dotsMode==1)
                {
                    count2++;
                }
                else if(dotsMode==2)
                {
                    count2++;
                }
            }
            //console.log("tempPlayer="+tempPlayer)

        }
        else
        {
            toggle();
            //              console.log("toggle")
        }






    }
    else if(internalFlag == 1)
    {
        //         console.log("internalFlag == 1")
        namcount++;
        if(namcount == 1)
        {// console.log("namcount == 1")
            tempSum1=0;
            for( forline = 0; forline < 4; forline++)
            {
                tempSum1+= dot[row][col][forline];
            }
            //console.log("tempsum1 = " + tempSum1)


            if(tempSum1 == 4)
            {
                //  console.log("tempsum1 = " + tempSum1)
                dot[row][col][4] = tempPlayer;
                winnerFlag1=1;
                if(tempPlayer==8)
                {
                    if(dotsMode==1)
                    {
                        count1++;
                    }
                    else if(dotsMode==2)
                    {
                        count1++;
                    }
                }


                else if(tempPlayer==9)
                {
                    if(dotsMode==1)
                    {
                        count2++;
                    }
                    else if(dotsMode==2)
                    {
                        count2++;
                    }
                }
                //console.log("tempplayer = " + tempPlayer)

            }








        }
        else if(namcount == 2)
        {
            //console.log("namcount == 2")
            internalFlag = 0;
            tempSum2=0;
            for( forline = 0; forline < 4; forline++)
            {
                tempSum2+= dot[row][col][forline];
            }
            //console.log("tempsum2 = " + tempSum2)




            if(tempSum2 == 4)
            {
                //  console.log("tempsum2 = " + tempSum2)
                dot[row][col][4] = tempPlayer;
                //console.log("tempPlayer = " + tempPlayer)
                winnerFlag2=1;
                if(tempPlayer==8)
                {
                    if(dotsMode==1)
                    {
                        count1++;
                    }
                    else if(dotsMode==2)
                    {
                        count1++;
                    }
                }


                else if(tempPlayer==9)
                {
                    if(dotsMode==1)
                    {
                        count2++;
                    }
                    else if(dotsMode==2)
                    {
                        count2++;
                    }
                }
            }


            if(tempSum1 != 4 && tempSum2 != 4)
            {
                // console.log("tempsum1 = " + tempSum1 + "tempsum2 = " + tempSum2)
                toggle();
            }
        }
        console.log("//////--------------------------")

    }
    console.log("//////--------------------------")
    //printWholeDataStructure();
    //      printUImatrix();

}
//-------------------------

//------- set val
function setValue(row,col,line)
{
    dot[row][col][line] = 1;
    UImatrix[row][col]++;  //to update for UImatrix (only fo CPU implementation!)
    setWinnerFlagIf4(row,col);
}
//----------------------

//------ print winner matrix
/*function printWinnerMatrix()
      {
                     console.log("print winning matrix");


         for( forrow = 1; forrow < 4; forrow++)
         {
            for( forcol = 1; forcol < 4; forcol++)
                       console.log(dot[forrow][forcol][4]);

            console.log("<br>");
         }


      }*/
//------------------------

//----- set winner value
function setWinnerValue(row2, col2)
{
    dot[row2][col2][4] = tempPlayer;
}
//-------------------------

//-----dots caller
function dotsCaller(x, y, a, b)
{
    // BOUNDARY CONDITIONS
    // VERTICAL
    if(y == 1 && b == 1)
    {


        if(x<a)
        {
            setValue(x,1,3);
        }
        else
        {
            setValue(a,1,3);
        }
    }


    // VERTICAL2
    else if(y == 7 && b == 7)
    {


        if(x<a)
        {
            setValue(x,6,1);
        }
        else
        {
            setValue(a,6,1);
        }
    }


    // HORIZONTAL
    else if(x==1 && a==1)
    {


        if(y<b)
        {
            setValue(1,y,0);
        }
        else
        {
            setValue(1,b,0);
        }
    }


    // HORIZONTAL2
    else if(x==4 && a==4)
    {




        if(y<b)
        {
            setValue(3,y,2);
        }
        else
        {
            setValue(3,b,2);
        }
    }


    else if(y<b || b<y )
    {
        namcount = 0;
        internalFlag = 1;
        // INTERNAL HORIZONTAL
        if(y<b)
        {


            setValue(x-1,y,2);
            setValue(x,y,0);
        }
        else
        {


            setValue(x-1,b,2);
            setValue(x,b,0);
        }
    }


    else
    {


        namcount = 0;
        internalFlag = 1;
        // INTERNAL VERTICAL
        if(x<a)
        {
            setValue(x,y,3);
            setValue(x,y-1,1);
        }
        else
        {


            setValue(a,y,3);
            setValue(a,y-1,1);
        }
    }




}
//-------------------------

//---- ai coor genertor
function AIcoordinateGenerator()
{
    /*
           1. search the uiGrid[][]
           2. if any three's or two's or one's
           3. depending on priority get the apporopriate row - col
           4. go to that row col in DS and get line no. which has 0
           5. mark that with 1 and increment appropriate value in ui grid by 1
           (integration with setValue is needed!)
           */





    if(level == 1)
    {

        var r = {row:0,col:0,line:0};
        var c = {x:0,y:0,a:0,b:0};


        if(count%24 == 0)
        {
            r = getThree();
            if(r.row > 0)    //this should be changed to >= when we make it from 0 to n-1 *****
            {
                r = getExactLine(r);
                c = getCoordinatesFromRcl(r);
                return c;
            }
            else
            {

                r = getTwo();
                if(r.row > 0)
                {
                    r = getExactLine(r);
                    c =getCoordinatesFromRcl(r);
                    return c;
                }
                else
                {
                    r = getZero();
                    if(r.row > 0)
                    {
                        r = getExactLine(r);
                        c = getCoordinatesFromRcl(r);
                        return c;
                    }
                    else
                    {
                        r = getOne();
                        if(r.row > 0)
                        {
                            r = getExactLine(r);
                            c = getCoordinatesFromRcl(r);
                            return c;
                        }
                    }
                }
            }
        }
        else

        {
            r = getThree();
            if(r.row > 0)    //this should be changed to >= when we make it from 0 to n-1 *****
            {
                r = getExactLine(r);
                c = getCoordinatesFromRcl(r);
                return c;
            }
            else
            {

                r = getZero();
                if(r.row > 0)
                {
                    r = getExactLine(r);
                    c =getCoordinatesFromRcl(r);
                    return c;
                }
                else
                {
                    r = getOne();
                    if(r.row > 0)
                    {
                        r = getExactLine(r);
                        c = getCoordinatesFromRcl(r);
                        return c;
                    }
                    else
                    {
                        r = getTwo();
                        if(r.row > 0)
                        {
                            r = getExactLine(r);
                            c = getCoordinatesFromRcl(r);
                            return c;
                        }
                    }
                }
            }
        }
    }

    else if(level == 2)
    {
        r = getThree();
        if(r.row > 0)    //this should be changed to >= when we make it from 0 to n-1 *****
        {
            r = getExactLine(r);
            c = getCoordinatesFromRcl(r);
            return c;
        }
        else
        {

            r = getZero();
            if(r.row > 0)
            {
                r = getExactLine(r);
                c =getCoordinatesFromRcl(r);
                return c;
            }
            else
            {
                r = getOne();
                if(r.row > 0)
                {
                    r = getExactLine(r);
                    c = getCoordinatesFromRcl(r);
                    return c;
                }
                else
                {
                    r = getTwo();
                    if(r.row > 0)
                    {
                        r = getExactLine(r);
                        c = getCoordinatesFromRcl(r);
                        return c;
                    }
                }
            }
        }}

    else if(level == 3)
    {
        var r = {row:0,col:0,line:0};
        var c = {x:0,y:0,a:0,b:0};

        r = getThree();
        if(r.row > 0)    //this should be changed to >= when we make it from 0 to n-1 *****
        {
            r = getExactLine(r);
            c = getCoordinatesFromRcl(r);
            return c;
        }
        else
        {
            r = getZero();
            if(r.row > 0)
            {
                r = getExactLine(r);
                c =getCoordinatesFromRcl(r);
                return c;
            }
            else
            {
                r = getOne();
                if(r.row > 0)
                {
                    r = getExactLine(r);
                    c = getCoordinatesFromRcl(r);
                    return c;
                }
                else
                {
                    r = getTwo();
                    if(r.row > 0)
                    {
                        r = getExactLine(r);
                        c = getCoordinatesFromRcl(r);
                        return c;
                    }
                }
            }
        }

    }





}
//-----------------------
//-----getThree
function getThree()
{
    getThreeflag=1;
    var rclTemp = {row:0,col:0,line:0};


    for( forrow = 1; forrow<4; forrow++)
        for( forcol = 1; forcol < 7; forcol++)
            if(UImatrix[forrow][forcol] == 3)
            {
                rclTemp.row = forrow;
                rclTemp.col = forcol;
                return rclTemp;
            }


        rclTemp.row = rclTemp.col = -1;
    return rclTemp;
}
//-------------------------------
//------getTwo
function getTwo()
{
    getTwoflag=1;

    var  rclTemp = {row:0,col:0,line:0};
    var rowArray = new Array(10);

    var colArray = new Array(10);

    var i = 0;
    var r;


    for( forrow = 1; forrow<4; forrow++)
        for( forcol = 1; forcol < 7; forcol++)
            if(UImatrix[forrow][forcol] == 2)
            {
                rowArray[i] = forrow;
                colArray[i] = forcol;
                i++;
                //return rclTemp;
            }

        if(i>0)
        {
            /*document.write("The selected locations in getZero() are" + "<br>");
for( fortemp = 0; fortemp < i; fortemp++)

  document.write(rclTemp[fortemp].row+" "+rclTemp[fortemp].col+"<br>");*/

            r=Math.floor(Math.random()*10)%i;
            rclTemp.row = rowArray[r];
            rclTemp.col = colArray[r];
            return rclTemp;

        }
        else
        {
            rclTemp.row = rclTemp.col = -1;
            return rclTemp;
        }

}


//-----------------------------------
//-------getOne
function getOne()
{
    getTwoflag=0;
    getThreeflag=0;
    var  rclTemp = {row:0,col:0,line:0};
    var rowArray = new Array(10);

    var colArray = new Array(10);

    var i = 0;
    var r=-1;
    var ran;
    var elli=new Array(18);


    for( forrow = 1; forrow<4; forrow++)
        for( forcol = 1; forcol < 7; forcol++)
            if(UImatrix[forrow][forcol] == 1)
            {
                rowArray[i] = forrow;
                colArray[i] = forcol;
                i++;
                //return rclTemp;
            }

        if(i>0)
        {
            /*document.write("The selected locations in getZero() are" + "<br>");
           for( fortemp = 0; fortemp < i; fortemp++)

              document.write(rclTemp[fortemp].row+" "+rclTemp[fortemp].col+"<br>");*/
            ran=Math.floor(Math.random()*10)%i;


            if(level==3)
            {
                var bn=0
                var dcou=0
                var whileCount=0;
                do
                {
                    r=Math.floor(Math.random()*10)%i;
                    //r++;
                    whileCount++;

                    if(rowArray[r]>1 && rowArray[r]<3 && colArray[r]>1 && colArray[r]<6 )
                    {
                        if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }

                        else    if((UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }

                        else     if( (UImatrix[rowArray[r]] [colArray[r]+1]!=2) && (dot[rowArray[r]][colArray[r]][1]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else    if(  (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("middle")
                    }

                    else    if((rowArray[r]==1 && colArray[r]>1 && colArray[r]<6))
                    {
                        if(dot[1][colArray[r]][0]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0) )

                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }

                        else   if( ( UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else   if( (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("upper")
                    }

                    else  if(rowArray[r]==3 && colArray[r]>1 && colArray[r]<6)
                    {
                        if(dot[3][colArray[r]][2]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )

                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else   if( (UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0)  )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else     if( (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("lower")
                    }

                    else   if(rowArray[r]>1 && colArray[r]==1 && rowArray[r]<3)
                    {
                        if(dot[2][1][3]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0) )

                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else if(  (UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else   if( (UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        console.log("left")
                    }


                    else   if(rowArray[r]>1 && colArray[r]==6 && rowArray[r]<3)
                    {
                        if(dot[2][6][1]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else  if(  (UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else    if(  (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("right")
                    }


                    else    if(rowArray[r]==1 && colArray[r]==1 )
                    {
                        if(dot[1][1][3]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        else if(dot[1][1][0]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0)   )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else  if((UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        console.log("1,1")
                    }

                    else if(rowArray[r]==3 && colArray[r]==1 )
                    {
                        if(dot[3][1][2]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else if(dot[3][1][3]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0)   )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else  if((UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        console.log("3,1")
                    }

                    else  if(rowArray[r]==1 && colArray[r]==6 )
                    {
                        if(dot[1][6][0]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else if(dot[1][6][1]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0)   )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else   if( (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("1,6")
                    }

                    else  if(rowArray[r]==3 && colArray[r]==6 )
                    {
                        if(dot[3][6][1]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else if(dot[3][6][2]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else   if(   (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("3,6")
                    }



                }while( whileCount<=100);

                rclTemp.row = rclTemp.col = -1;
                return rclTemp;

            }


            rclTemp.row = rowArray[ran];
            rclTemp.col = colArray[ran];
            return rclTemp;
        }
        else
        {
            rclTemp.row = rclTemp.col = -1;
            return rclTemp;
        }

}

//----------------------------
//---------getZero
function getZero()
{
    getTwoflag=0;
    getThreeflag=0;
    var  rclTemp = {row:0,col:0,line:0};
    var rowArray = new Array(10);

    var colArray = new Array(10);

    var i = 0;
    var r=-1;
    var ran;
    var elli=new Array(18);


    for( forrow = 1; forrow<4; forrow++)
        for( forcol = 1; forcol < 7; forcol++)
            if(UImatrix[forrow][forcol] == 0)
            {
                rowArray[i] = forrow;
                colArray[i] = forcol;
                i++;
                //return rclTemp;
            }

        if(i>0)
        {
            /*document.write("The selected locations in getZero() are" + "<br>");
           for( fortemp = 0; fortemp < i; fortemp++)

              document.write(rclTemp[fortemp].row+" "+rclTemp[fortemp].col+"<br>");*/
            ran=Math.floor(Math.random()*10)%i;


            if(level==3)
            {
                var bn=0
                var dcou=0
                var whileCount=0;
                do
                {
                    r=Math.floor(Math.random()*10)%i;
                    //r++;
                    whileCount++;

                    if(rowArray[r]>1 && rowArray[r]<3 && colArray[r]>1 && colArray[r]<6 )
                    {
                        if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }

                        else    if((UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }

                        else     if( (UImatrix[rowArray[r]] [colArray[r]+1]!=2) && (dot[rowArray[r]][colArray[r]][1]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else    if(  (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("middle")
                    }

                    else    if((rowArray[r]==1 && colArray[r]>1 && colArray[r]<6))
                    {
                        if(dot[1][colArray[r]][0]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0) )

                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }

                        else   if( ( UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else   if( (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("upper")
                    }

                    else  if(rowArray[r]==3 && colArray[r]>1 && colArray[r]<6)
                    {
                        if(dot[3][colArray[r]][2]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )

                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else   if( (UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0)  )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else     if( (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("lower")
                    }

                    else   if(rowArray[r]>1 && colArray[r]==1 && rowArray[r]<3)
                    {
                        if(dot[2][1][3]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0) )

                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else if(  (UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else   if( (UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        console.log("left")
                    }


                    else   if(rowArray[r]>1 && colArray[r]==6 && rowArray[r]<3)
                    {
                        if(dot[2][6][1]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else  if(  (UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else    if(  (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("right")
                    }


                    else    if(rowArray[r]==1 && colArray[r]==1 )
                    {
                        if(dot[1][1][3]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        else if(dot[1][1][0]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0)   )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else  if((UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        console.log("1,1")
                    }

                    else if(rowArray[r]==3 && colArray[r]==1 )
                    {
                        if(dot[3][1][2]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else if(dot[3][1][3]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0)   )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else  if((UImatrix[rowArray[r]] [colArray[r]+1]!=2)&& (dot[rowArray[r]][colArray[r]][1]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        console.log("3,1")
                    }

                    else  if(rowArray[r]==1 && colArray[r]==6 )
                    {
                        if(dot[1][6][0]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else if(dot[1][6][1]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]+1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][2]==0)   )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else   if( (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("1,6")
                    }

                    else  if(rowArray[r]==3 && colArray[r]==6 )
                    {
                        if(dot[3][6][1]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=1;
                            return rclTemp;
                        }
                        else if(dot[3][6][2]==0)
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=2;
                            return rclTemp;
                        }
                        else if((UImatrix[rowArray[r]-1] [colArray[r]]!=2)&& (dot[rowArray[r]][colArray[r]][0]==0) )
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=0;
                            return rclTemp;
                        }
                        else   if(   (UImatrix[rowArray[r]] [colArray[r]-1]!=2)&& (dot[rowArray[r]][colArray[r]][3]==0))
                        {
                            rclTemp.row=rowArray[r];
                            rclTemp.col=colArray[r];
                            rclTemp.line=3;
                            return rclTemp;
                        }
                        console.log("3,6")
                    }



                }while( whileCount<=100);

                rclTemp.row = rclTemp.col = -1;
                return rclTemp;

            }


            rclTemp.row = rowArray[ran];
            rclTemp.col = colArray[ran];
            return rclTemp;
        }
        else
        {
            rclTemp.row = rclTemp.col = -1;
            return rclTemp;
        }

}


//---------getCoordinatesFromRcl
function getCoordinatesFromRcl( r)
{
    var c = {x:0,y:0,a:0,b:0};


    if(r.line == 0)
    {
        c.x = r.row;
        c.y = r.col;
        c.a = r.row;
        c.b = r.col + 1;
    }
    else if(r.line == 1)
    {
        c.x = r.row;
        c.y = r.col + 1;
        c.a = r.row + 1;
        c.b = r.col + 1;
    }
    else if(r.line == 2)
    {
        c.x = r.row + 1;
        c.y = r.col;
        c.a = r.row + 1;
        c.b = r.col + 1;
    }
    else if(r.line == 3)
    {
        c.x = r.row + 1;
        c.y = r.col;
        c.a = r.row;
        c.b = r.col;
    }
    var tq
    if(c.y>c.b)
    {
        tq=c.y;
        c.y=c.b;
        c.b=tq;
    }

    else if(c.x>c.a)
    {
        tq=c.x;
        c.x=c.a;
        c.a=tq;
    }

    return c;


}
//-----------------------------
//-------getExactLine
function getExactLine( r)
{
    if(level==3)
    {
        if(getTwoflag==1 || getThreeflag==1)
        { var tempLine = [0,0,0,0];
            var i = 0;
            getTwoflag=0;
            getThreeflag=0;
            for( forline = 0; forline < 4; forline++)
            {
                if(dot[r.row][r.col][forline] == 0)
                {
                    //r.line = line;
                    tempLine[i] = forline;
                    i++;
                    //return r;
                }
            }

            r.line = tempLine[Math.floor(Math.random()*10)%i];
            return r;}

        else
        {
            return r;
        }
    }
    else
    { var tempLine = [0,0,0,0];
        var i = 0;
        getTwoflag=0;
        getThreeflag=0;
        for( forline = 0; forline < 4; forline++)
        {
            if(dot[r.row][r.col][forline] == 0)
            {
                //r.line = line;
                tempLine[i] = forline;
                i++;
                //return r;
            }
        }

        r.line = tempLine[Math.floor(Math.random()*10)%i];
        return r;}

}
//------------------------
//-------printUImatrix
/*function printUImatrix()
      {

document.write("uiMatrix "+"<br>");


         for( forrow = 1; forrow < 4; forrow++)
         {
            for( forcol = 1; forcol < 4; forcol++)

document.write(UImatrix[forrow][forcol]);
document.write("<br>");




         }
      }*/
//--------------------------
//------AIcoordinateGeneratorReverse

function AIcoordinateGeneratorReverse()
{
    /*
           1. search the uiGrid[][]
           2. if any three's or two's or one's
           3. depending on priority get the apporopriate row - col
           4. go to that row col in DS and get line no. which has 0
           5. mark that with 1 and increment appropriate value in ui grid by 1
           (integration with setValue is needed!)
           */





    if(level == 1) //NOT TESTED *IMP*
    {
        var r = {row:0,col:0,line:0};
        var c = {x:0,y:0,a:0,b:0};

        if(count%12 == 0)
        {
            r = getTwo();
            if(r.row > 0)    //this should be changed to >= when we make it from 0 to n-1 *****
            {
                r = getExactLine(r);
                c = getCoordinatesFromRcl(r);
                return c;
            }

            else
            {

                r = getThree();

                if(r.row > 0)
                {
                    r = getExactLine(r);
                    c =getCoordinatesFromRcl(r);
                    return c;
                }
                else
                {
                    r = getOne();
                    if(r.row > 0)
                    {
                        r = getExactLine(r);
                        c = getCoordinatesFromRcl(r);
                        return c;
                    }
                    else
                    {
                        r = getZero();
                        if(r.row > 0)
                        {
                            r = getExactLine(r);
                            c = getCoordinatesFromRcl(r);
                            return c;
                        }
                    }
                }
            }
        }
        else
        {
            r = getTwo();
            if(r.row > 0)    //this should be changed to >= when we make it from 0 to n-1 *****
            {
                r = getExactLine(r);
                c = getCoordinatesFromRcl(r);
                return c;
            }
            else
            {

                r = getOne();
                if(r.row > 0)
                {
                    r = getExactLine(r);
                    c =getCoordinatesFromRcl(r);
                    return c;
                }
                else
                {
                    r = getZero();
                    if(r.row > 0)
                    {
                        r = getExactLine(r);
                        c = getCoordinatesFromRcl(r);
                        return c;
                    }
                    else
                    {
                        r = getThree();
                        if(r.row > 0)
                        {
                            r = getExactLine(r);
                            c = getCoordinatesFromRcl(r);
                            return c;
                        }
                    }
                }
            }
        }
    }
    else if(level == 2) //NOT TESTED *IMP*
    {
        var r = {row:0,col:0,line:0};
        var c = {x:0,y:0,a:0,b:0};

        if(count%24 == 0)
        {
            r = getTwo();
            if(r.row > 0)    //this should be changed to >= when we make it from 0 to n-1 *****
            {
                r = getExactLine(r);
                c = getCoordinatesFromRcl(r);
                return c;
            }
            else
            {

                r = getThree();
                if(r.row > 0)
                {
                    r = getExactLine(r);
                    c =getCoordinatesFromRcl(r);
                    return c;
                }
                else
                {
                    r = getOne();
                    if(r.row > 0)
                    {
                        r = getExactLine(r);
                        c = getCoordinatesFromRcl(r);
                        return c;
                    }
                    else
                    {
                        r = getZero();
                        if(r.row > 0)
                        {
                            r = getExactLine(r);
                            c = getCoordinatesFromRcl(r);
                            return c;
                        }
                    }
                }
            }
        }
        else
        {
            r = getTwo();
            if(r.row > 0)    //this should be changed to >= when we make it from 0 to n-1 *****
            {
                r = getExactLine(r);
                c = getCoordinatesFromRcl(r);
                return c;
            }
            else
            {

                r = getOne();
                if(r.row > 0)
                {
                    r = getExactLine(r);
                    c =getCoordinatesFromRcl(r);
                    return c;
                }
                else
                {
                    r = getZero();
                    if(r.row > 0)
                    {
                        r = getExactLine(r);
                        c = getCoordinatesFromRcl(r);
                        return c;
                    }
                    else
                    {
                        r = getThree();
                        if(r.row > 0)
                        {
                            r = getExactLine(r);
                            c = getCoordinatesFromRcl(r);
                            return c;
                        }
                    }
                }
            }
        }


    }
    else if(level == 3)    //MODIFIED AS 2 0 1 3 (TEMP, CHANGE IT FOR OTHERS!)
    { var r = {row:0,col:0,line:0};
        var c = {x:0,y:0,a:0,b:0};

        r = getTwo();
        if(r.row > 0)    //this should be changed to >= when we make it from 0 to n-1 *****
        {
            r = getExactLine(r);
            c = getCoordinatesFromRcl(r);
            return c;
        }
        else
        {
            r = getZero();
            if(r.row > 0)
            {
                r = getExactLine(r);
                c =getCoordinatesFromRcl(r);
                return c;
            }
            else
            {
                r = getOne();
                if(r.row > 0)
                {
                    r = getExactLine(r);
                    c = getCoordinatesFromRcl(r);
                    return c;
                }
                else
                {
                    r = getThree();
                    if(r.row > 0)
                    {
                        r = getExactLine(r);
                        c = getCoordinatesFromRcl(r);
                        return c;
                    }
                }
            }
        }



    }



}
//----------------------------------------------
//----------MAIN

/*
function main()
{
        //level = prompt("level kodroo: ","0");
        while(count < 24)
        {
                //pausecomp(5000);
                count++;
                if(tempPlayer == 8)
                {

        var x = prompt("Enter x: ","0");
                var y = prompt("Enter y: ","0");
                var a = prompt("Enter a: ","0");
                var b = prompt("Enter b: ","0");
                  dotsCaller(x,y,a,b);


            printWholeDataStructure();
            printUImatrix();
                }

                 else if(tempPlayer == 9)
         {
             var c = {x:0,y:0,a:0,b:0};


            //c = d.AIcoordinateGenerator();
            c = AIcoordinateGeneratorReverse();
            dotsCaller(c.x, c.y, c.a, c.b);
            printWholeDataStructure();
            printUImatrix();
         }

        document.write("<br>End of loop with count= " + count);



        //setInterval("document.write('<br>delay finished<br>')",5000);


        }


         printWinnerMatrix();




}

function pausecomp(millis)
{
var date = new Date();
var curDate = null;

do { curDate = new Date(); }
while(curDate-date < millis);
}




function putLine ()
{
    return 1;
}
*/
