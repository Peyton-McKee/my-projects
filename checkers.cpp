#include <iostream>
#include <iomanip>

using namespace std;


int main()
{
    string board[8][8];
    int keeper;
    int x;
    int y;
    string move;
    int player;
    char answer = 'y';



    for (int i=0; i<8; i++)
 		{
   	   		for (int j=0; j <8; j+=2)
       		{
           		keeper = j;
           		if (i %2 == 0)
           		{
           		   j++;
          	  }
           		board[i][j] = "⬛";
           		if (i <=2 && board[i][j] == "⬛")
           		{
           		    board[i][j] = "🔴";
          		}
           		if (i>=5 && board[i][j] == "⬛")
           		{
              		board[i][j] = "🔵";
           		}
           		j = keeper;
       		}
    	}

    for (int i=0; i<8; i++)
 		{
   	   		for (int j=1; j <8; j+=2)
       		{
           		keeper = j;
           		if (i % 2 == 0)
           		{
              		j -= 1;
           		}
           		board[i][j] = "⬜";
           		j = keeper;
       		}
    }


    for (int i=0; i<8; i++)
 		{
   	   		for (int j=0; j <8; j++)
       		{
           		cout << board[i][j];
       		}
       		cout << endl;
    }


    while (answer == 'y')
    {
        cout << "Which Player Are You? (1/2)" << endl;
        cin >> player;

    	  cout << "Select what piece you would like to move: (coordinates)" << endl;
    	  cin >> x >> y;


    		cout << "Select which way you would like to move: (L/R)" << endl;
    		cin >> move;

       	if (move == "L" && player == 1 && board[y][x-2] == "⬛" && board[x-1][y-1] != "⭑")
       	{
          		board[y][x-2] = "🔴";
          		board[y-1][x-1] = "⬛";
       	}
       	else if (move == "R" && player == 1 && board[y][x] == "⬛" && board[x-1][y-1]!= "⭑")
       	{
          		board[y][x] = "🔴";
          		board[y-1][x-1] = "⬛";
       	}
       	else if (move == "L" && player == 2 && board[y-2][x]== "⬛" && board[x-1][y-1] != "☆")
       	{
          		board[y-2][x-2] = "🔵";
          		board[y-1][x-1] = "⬛";
       	}
       	else if (move == "R" && player == 2 && board[y-2][x] == "⬛" && board[x-1][y-1] != "☆")
       	{
         	    board[y-2][x] = "🔵";
          		board[y-1][x-1] = "⬛";
       	}
        else if (move == "L" && player == 1 && board[y+1][x-3] == "⬛" && board[y][x-2] == "🔵")
        {
              board[y + 1][x - 3] = "🔴";
              board[y - 1][x - 1] = "⬛";
              board[y][x-2] = "⬛";
        }
        else if(move == "R" && player == 1 && board[y+1][x+1] == "⬛" && board[y][x] == "🔵")
        {
              board[y + 1][x + 1] = "🔴";
              board[y - 1][x - 1] = "⬛";
              board[y][x] = "⬛";
        }
        else if(move == "R" && player == 2 && board[y-3][x+1] == "⬛" && board[y-2][x] == "🔴")
        {
              board[y - 3][x + 1] = "🔵";
              board[y - 1][x - 1] = "⬛";
              board[y - 2][x] = "⬛";
        }
        else if (move == "L" && player == 2 && board[y-3][x-3] == "⬛" && board[y-2][x-2] == "🔴")
        {
            board[y - 2][x - 2] = "🔵";
            board[y - 1][x - 1] = "⬛";
            board[y - 2][x - 2] = "⬛";
        }
        else
        {
            cout << "Error. Either you cannot move there because it is blocked or incorrect inputs. Repeat steps to move." << endl;
        }
        if (move == "L" && player == 1 && board[y][x-2] == "⬛" && board[x-1][y-1] == "⭑")
        {
            board[y][x-2] = "⭑";
            board[y-1][x-1] = "⬛";
        }
        else if (move == "R" && player == 1 && board[y][x] == "⬛" && board[x-1][y-1] == "⭑")
        {
            board[y][x] = "⭑";
            board[y-1][x-1] = "⬛";
        }
        else if (move == "BL" && player == 1 && board[x-1][y-1] == "⭑")
        {

        }
        else if(move == "BR" && player == 1 && board[x-1][y-1] == "⭑")
        {

        }
        else if (move == "L" && player == 2 && board[y-2][x+1] == "⬛" && board[x-1][y-1]== "☆")
        {
            board[y-2][x+1] = "☆";
            board[y-1][x-1] = "⬛";
        }
        else if (move == "R" && player == 2 && board[y-2][x] == "⬛" && board[x-1][y-1]== "☆")
        {
            board[y-2][x] = "☆";
            board[y-1][x-1] = "⬛";
        }
        else if(move == "BL" && player == 2 && board[x-1][y-1]== "☆")
        {

        }
        else if(move == "BR" && player == 2 && board[x-1][y-1]== "☆")
        {

        }
        else if (move == "L" && player == 1 && board[x-1][y-1] == "⭑")
        {
            board[y + 1][x - 3] = "⭑";
          	board[y - 1][x - 1] = "⬛";
            board[y][x-2] = "⬛";
        }
        else if(move == "R" && player == 1 && board[x-1][y-1]== "⭑")
        {
            board[y + 1][x + 1] = "⭑";
            board[y - 1][x - 1] = "⬛";
            board[y][x] = "⬛";
        }
        else if(move == "R" && player == 2 && board[x-1][y-1]== "☆")
        {
            board[y - 3][x + 1] = "☆";
            board[y - 1][x - 1] = "⬛";
            board[y - 2][x] = "⬛";
        }
        else if (move == "L" && player == 2 && board[x-1][y-1]== "☆")
        {
            board[y - 2][x - 2] = "☆";
            board[y - 1][x - 1] = "⬛";
            board[y - 2][x - 2] = "⬛";
        }


    	if (board[0][1] == "🔵")
    	{
    	   board[0][1] = "☆";
    	}
    	else if(board[0][3] == "🔵")
    	{
    	   board[0][3] = "☆";
    	}
    	else if(board[0][5] == "🔵")
    	{
    	   board[0][5] = "☆";
    	}
    	else if(board[0][7] == "🔵")
    	{
    	    board[0][7] = "☆";
      }
      else if(board[7][0] == "🔴")
      {
          board[7][0] = "⭑";
      }
    	else if (board[7][2] == "🔴")
    	{
    	   board[7][2] = "⭑";
    	}
    	else if (board[7][4] == "🔴")
    	{
    	   board[7][4] = "⭑";
    	}
    	else if (board[7][6] == "🔴")
    	{
    	   board[7][6] = "⭑";
    	}

      for (int i=0; i<8; i++)
 	    {
   	   		for (int j=0; j <8; j++)
       		{
           		cout << setw(100) << board[i][j];
       		}
       		cout << endl;

    	}
    	cout << "Would you like to continue?(y/n)" << endl;
        cin >> answer;
    }
   return 0;
}
