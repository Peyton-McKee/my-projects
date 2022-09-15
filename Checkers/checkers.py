# creates a class called boardsquare with two attributes a call to itself and a function that builds a square from its x and y coordinates
class BoardSquare():
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __getitem__(self):
        return self

    def buildSquare(self):
        return square(self.x, self.y, 50)

# creates a class called piece that has three attributes a call to itself and the ability to either build a regular piece or a king piece


class Piece():
    def __init__(self, name, x, y):
        self.name = name
        self.x = x
        self.y = y

    def __getitem__(self):
        return self

    def buildPiece(self):
        strokeWeight(3)
        ellipse(self.x, self.y, 25, 25)

    def buildKing(self):
        strokeWeight(3)
        ellipse(self.x, self.y, 25, 25)
        fill(255, 215, 0)
        noStroke()
        ellipse(self.x, self.y, 10, 10)


# global variable that tracks whether a piece is currently selected
didSelectPiece = False
player = 1  # global variable that tracks the current player
redPieces = []  # a global list that tracks all of the red pieces
greenPieces = []  # a global list that tracks all of the green piece
numGreen = 12  # a global variable that tracks the number of green pieces
numRed = 12  # a global varibale that tracks the number of red pieces
# a global instance that tracks the square that a piece attempts to go to
destinationSquare = []
board = []  # a global list of all of the board pieces
selectedPiece = []  # a global instance that tracks the selected piece
index = 0  # a global variable that tracks the index of one of the pieces lists
moveMade = False  # a global variable that tracks whether a move was made


def setup():
    size(600, 400)  # sets the size of the screen
    frameRate(1000)  # sets number of times draw is called in a second
    makeBoard()  # calls the makeBoard function


def draw():
    global numRed
    global numGreen
    global player
    f = loadFont('TimesNewRomanPSMT-48.vlw')  # loads the times new roman font
    textFont(f)
    textSize(25)
    fill(255, 255, 255)
    stroke(0)
    # creates a white background for the score side of the interface
    rect(400, 0, 200, 400)
    fill(0, 0, 0)
    # creates text showing how many reds are left
    redsLeft = "Reds Left: " + str(numRed)
    # creates text showing how many greens are left
    greensLeft = "Greens Left: " + str(numGreen)
    text(redsLeft, 410, 50)
    text(greensLeft, 410, 70)
    if(player == 1):  # checks what player is up and tells the user whos turn it is
        text("Red's Turn", 410, 100)
    else:
        text("Green's Turn", 410, 100)
    endGame()  # calls the endgame function to see if the game should end


def mouseClicked():
    global didSelectPiece  # accesses all the global variables this function needs
    global selectedPiece
    global board
    global redPieces
    global greenPieces
    global index
    global player
    global moveMade
    if(player == 1):
        for i in range(0, numRed, 1):  # This function checks that if the
            # mouse clicks on a piece for whoevers turn it is, it selects that piece,
            # dehighlights the previosly selected piece and highlights the newly selected piece
            if(correctSelectionOfPiece(redPieces[i])):
                didSelectPiece = True
                dehighlightSelectedPiece(selectedPiece)
                fill(255, 0, 0)
                selectedPiece = redPieces[i]
                index = i
                highlightSelectedPiece(selectedPiece)

    else:
        # does the same thing as the previous loop except for player two
        for i in range(0, numGreen, 1):
            if(correctSelectionOfPiece(greenPieces[i])):
                didSelectPiece = True
                dehighlightSelectedPiece(selectedPiece)
                selectedPiece = greenPieces[i]
                fill(0, 255, 0)
                index = i
                highlightSelectedPiece(selectedPiece)

    if(didSelectPiece):  # checks that if a piece is already selected whether or not the player
        # can make whatever move they want to make based off of where they click
        print(didSelectPiece)
        if(player == 1):
            for i in range(8):
                for j in range(8):
                    if(moveMade):  # ends the inner for loop if the move is made
                        break
                    else:
                        # checks to see if the move can be made for the current square
                        makeMove(i, j)
                        # on the board being tracked by i and j
                if(moveMade):  # ends the outer for loop if the move is made and makes move made false
                    moveMade = False
                    break
        elif(player == 2):
            for i in range(8):
                for j in range(8):
                    if(moveMade):  # ends the inner for loop if the move is made
                        break
                    else:
                        # checks whether or not the move can be made for the current i,j board square
                        makeMove(i, j)
                if(moveMade):
                    moveMade = False  # ends the outer for loop if the move is made
                    break


def makeBoard():  # loops through and creates a board that is an 8x8 array with alternating colors of blue and white
    global board
    x = 0
    y = 0
    for i in range(8):
        x = 0
        for j in range(8):
            # alternates the colors in a checkered pattern
            if(i % 2 == 0 and j % 2 == 0 or (i % 2 == 1 and j % 2 == 1)):
                fill(255, 255, 255)
            else:
                fill(0, 0, 255)
            # creates a new instance of type boardsquare with the specified x and y coordinates
            boardSquare = BoardSquare(x, y)
            boardSquare.buildSquare()
            # appends the boardsquare to the array of boardsquares that makeup the board
            board.append(boardSquare)
            # calls the set up pieces function to lay out and create all of the pieces
            setUpPieces(i, j, x, y)
            x += 50
        y += 50


def setUpPieces(i, j, x, y):
    global redPieces
    global greenPieces
    global selectedPiece
    if(i < 3 and ((j % 2 == 0 and i % 2 == 0) or (j % 2 == 1 and i % 2 == 1))):
        fill(255, 0, 0)
        # creates a new instance of type piece,
        piece = Piece("checker", 25 + x, 25 + y)
        # calls its build piece function and then appends it to the array of red pieces
        piece.buildPiece()
        redPieces.append(piece)
    elif(i > 4 and ((j % 2 == 0 and i % 2 == 0) or (j % 2 == 1 and i % 2 == 1))):
        fill(0, 255, 0)
        # creates a new instance of type piece,
        piece = Piece("checker", 25 + x, 25 + y)
        # calls its buildPiece function and then appends it to the array of green pieces
        piece.buildPiece()
        greenPieces.append(piece)
    selectedPiece = redPieces[0]


def endGame():  # checks whether there are zero pieces left for either team and displays text accordingly
    textSize(32)
    if(numRed == 0):
        text("Green Wins!", 410, 150)
    elif(numGreen == 0):
        text("Red Wins!", 410, 150)


# returns whether or not a mouse is clicked on a correct piece
def correctSelectionOfPiece(piece):
    x = getattr(piece, 'x')
    y = getattr(piece, 'y')
    return ((mouseX >= x - 25 and mouseX <= x + 25) and
            (mouseY >= y - 25 and mouseY <= y + 25))


# highlights the selected piece by rebuilding it with a gold stroke
def highlightSelectedPiece(piece):
    x = getattr(piece, 'x')
    y = getattr(piece, 'y')
    name = getattr(piece, 'name')
    stroke(255, 215, 0)
    if(name == "king"):  # checks to see whether or not it should build a king or a checker
        piece.buildKing()
    else:
        piece.buildPiece()


# dehighlights the selected piece when called
def dehighlightSelectedPiece(selectedPiece):
    global redPieces
    global greenPieces
    pieceX = getattr(selectedPiece, 'x')
    pieceY = getattr(selectedPiece, 'y')
    name = getattr(selectedPiece, 'name')
    if(name == "king"):  # checks to see if the piece is a king and then loops through each array of pieces to see
        # if the piece is red or green to determine what color it should be set to
        for piece in redPieces:
            x = getattr(piece, 'x')
            y = getattr(piece, 'y')
            if(pieceX == x and pieceY == y):
                fill(255, 0, 0)
                stroke(0, 0, 0)
                piece.buildKing()
                return  # if the piece is found it ends the function
        for piece in greenPieces:
            x = getattr(piece, 'x')
            y = getattr(piece, 'y')
            if(pieceX == x and pieceY == y):
                fill(0, 255, 0)
                stroke(0, 0, 0)
                piece.buildKing()
                return  # if the piece is found it ends the function
    else:  # checks for checkers in both the arrays to determine the color
        for piece in redPieces:
            x = getattr(piece, 'x')
            y = getattr(piece, 'y')
            if(pieceX == x and pieceY == y):
                fill(255, 0, 0)
                stroke(0, 0, 0)
                piece.buildPiece()
                return  # ends the function if found
        for piece in greenPieces:
            x = getattr(piece, 'x')
            y = getattr(piece, 'y')
            if(pieceX == x and pieceY == y):
                fill(0, 255, 0)
                stroke(0, 0, 0)
                piece.buildPiece()
                return  # ends the function if found


def makeMove(i, j):  # checks if the player's mouse is a valid square and moves the piece accordingly
    global board
    global selectedPiece
    global didSelectPiece
    global redPieces
    global greenPieces
    global index
    global player
    global moveMade
    if(player == 1):
        mySquare = i * 8 + j
        boardSquare = board[mySquare]
        x = getattr(boardSquare, 'x')
        y = getattr(boardSquare, 'y')
        if(isValidDestination(x, y, selectedPiece, player)):  # if the square is a valid
            # destination it updates the selected pieces tile adds the new location to
            # the red pieces array and removes the old location from it
            updateTile(selectedPiece)
            fill(255, 0, 0)
            # checks if its a king or its becoming a king
            if(getattr(selectedPiece, 'name') == "king" or y == 350):
                redPieces.insert(index, Piece("king", x + 25, y + 25))
                redPieces.remove(selectedPiece)
                redPieces[index].buildKing()
            else:
                redPieces.insert(index, Piece("checker", x + 25, y + 25))
                redPieces.remove(selectedPiece)
                redPieces[index].buildPiece()
            # updates all of the global variables that are tracking information
            selectedPiece = redPieces[index]
            didSelectPiece = False
            player = 2
            moveMade = True
        elif(isCorrectSquare(x, y) and canTakePiece(x, y, selectedPiece, player)):  # checks if it
            # can take a piece based off of where it wants to go and updates the information accordingly
            updateTile(selectedPiece)
            fill(255, 0, 0)
            # checks if its a king or becoming a king
            if(getattr(selectedPiece, 'name') == "king" or y == 350):
                redPieces.insert(index, Piece("king", x + 25, y + 25))
                redPieces.remove(selectedPiece)
                redPieces[index].buildKing()
            else:
                redPieces.insert(index, Piece("checker", x + 25, y + 25))
                redPieces.remove(selectedPiece)
                redPieces[index].buildPiece()
            # updates global variables tracking information
            selectedPiece = redPieces[index]
            didSelectPiece = False
            player = 2
            moveMade = True
    else:  # does the same thing as above except for player 2
        mySquare = i*8 + j
        boardSquare = board[mySquare]
        x = getattr(boardSquare, 'x')
        y = getattr(boardSquare, 'y')
        if(isValidDestination(x, y, selectedPiece, player)):
            updateTile(selectedPiece)
            fill(0, 255, 0)
            if(getattr(selectedPiece, 'name') == "king" or y == 0):
                greenPieces.insert(index, Piece("king", x + 25, y + 25))
                greenPieces.remove(selectedPiece)
                greenPieces[index].buildKing()
            else:
                greenPieces.insert(index, Piece("checker", x + 25, y + 25))
                greenPieces.remove(selectedPiece)
                greenPieces[index].buildPiece()
            selectedPiece = greenPieces[index]
            didSelectPiece = False
            player = 1
            moveMade = True
        elif(isCorrectSquare(x, y) and canTakePiece(x, y, selectedPiece, player)):
            updateTile(selectedPiece)
            fill(0, 255, 0)
            if(getattr(selectedPiece, 'name') == "king" or y == 0):
                greenPieces.insert(index, Piece("king", x + 25, y + 25))
                greenPieces.remove(selectedPiece)
                greenPieces[index].buildKing()
            else:
                greenPieces.insert(index, Piece("checker", x + 25, y + 25))
                greenPieces.remove(selectedPiece)
                greenPieces[index].buildPiece()
            selectedPiece = greenPieces[index]
            didSelectPiece = False
            player = 1
            moveMade = True


# checks to see whether or not the mouse is clicked on a tile and the pice can move left or right
def isValidDestination(x, y, selectedPiece, player):
    return ((isCorrectSquare(x, y)) and (canMoveLeftOrRight(x, y, selectedPiece, player)))


# checks to see if the mouse x and y coordinates are within a board square
def isCorrectSquare(x, y):
    return ((mouseX >= x and mouseX <= x + 50) and (mouseY >= y and mouseY <= y + 50))


def canMoveLeftOrRight(x, y, selectedPiece, player):  # checks to see whether or
    # not the selected selected piece is allowed to move to the selected boardSquare either
    # to the left or right and up or down
    global greenPieces
    global redPieces
    pieceX = getattr(selectedPiece, 'x')
    pieceY = getattr(selectedPiece, 'y')
    name = getattr(selectedPiece, 'name')
    if (player == 1):
        if (name == "king"):  # checks if the piece is a king and adds the locations that
            # only a king can move to otherwise just the regular moves
            # for the location and checks to see if any of the locations are occupied by other pieces
            return (((x == pieceX - 75) or (x == pieceX + 25)) and ((y == pieceY + 25) or (y == pieceY - 75)) and not isSpotOccupied(x, y, greenPieces))
        else:
            return (((x == pieceX - 75) or (x == pieceX + 25)) and (y == pieceY + 25) and not isSpotOccupied(x, y, greenPieces))
    else:
        if (name == "king"):  # checks if the piece is a king and adds the locations that
            # only a king can move to otherwise just the regular moves
            # for the location and checks to see if any of the locations are occupied by other pieces
            return (((x == pieceX - 75) or (x == pieceX + 25)) and ((y == pieceY + 25) or (y == pieceY - 75)) and not isSpotOccupied(x, y, greenPieces))
        else:
            return (((x == pieceX - 75) or (x == pieceX + 25)) and (y == pieceY - 75) and not isSpotOccupied(x, y, redPieces))


# returns whether or not a spot is occupied by the given pieces array
def isSpotOccupied(x, y, pieces):
    ans = False
    for i in range(len(pieces)):
        pieceX = getattr(pieces[i], 'x')
        pieceY = getattr(pieces[i], 'y')
        if((x == pieceX - 25) and
                y == pieceY - 25):
            ans = True
    return ans


def updateTile(piece):  # updates the tile for the given piece instance
    global board
    x = getattr(piece, 'x')
    y = getattr(piece, 'y')
    i = y/50
    j = x/50
    if(i % 2 == 0 and j % 2 == 0 or (i % 2 == 1 and j % 2 == 1)):
        fill(255, 255, 255)
    else:
        fill(0, 0, 255)
    mySquare = i*8 + j
    boardSquare = board[mySquare]
    stroke(0, 0, 0)
    boardSquare.buildSquare()


# returns whether or not the square selected
def canTakePiece(x, y, selectedPiece, player):
    # is a diagnol square two away from the selected piece with a opposing teams piece in the way
    # and if it is it removes the piece in the way
    global greenPieces
    global redPieces
    global numRed
    global numGreen
    pieceX = getattr(selectedPiece, 'x')
    pieceY = getattr(selectedPiece, 'y')
    name = getattr(selectedPiece, 'name')
    if(player == 1 and name == "king" and (not isSpotOccupied(x, y, greenPieces)) and ((y == pieceY + 75) or (y == pieceY - 125))):
        # if its a king it can take pieces above and below it
        if(checkDownLeft(x, pieceX, pieceY, greenPieces)):
            # Removes the piece that the selected piece jumps over
            return removeGreenPiece(pieceX - 50, pieceY + 50)
        elif(checkDownRight(x, pieceX, pieceY, greenPieces)):
            return removeGreenPiece(pieceX + 50, pieceY + 50)
        elif(checkUpRight(x, pieceX, pieceY, greenPieces)):
            return removeGreenPiece(pieceX + 50, pieceY - 50)
        elif(checkUpLeft(x, pieceX, pieceY, greenPieces)):
            return removeGreenPiece(pieceX - 50, pieceY - 50)
    elif(player == 2 and name == "king" and (not isSpotOccupied(x, y, greenPieces)) and ((y == pieceY + 75) or (y == pieceY - 125))):
        if(checkDownLeft(x, pieceX, pieceY, redPieces)):
            return removeRedPiece(pieceX - 50, pieceY + 50)
        elif(checkDownRight(x, pieceX, pieceY, redPieces)):
            return removeRedPiece(pieceX + 50, pieceY + 50)
        elif(checkUpRight(x, pieceX, pieceY, redPieces)):
            return removeRedPiece(pieceX + 50, pieceY - 50)
        elif(checkUpLeft(x, pieceX, pieceY, redPieces)):
            return removeRedPiece(pieceX - 50, pieceY - 50)
    elif(player == 1 and (not isSpotOccupied(x, y, greenPieces)) and (y == pieceY + 75)):
        if(checkDownLeft(x, pieceX, pieceY, greenPieces)):
            return removeGreenPiece(pieceX - 50, pieceY + 50)
        elif(checkDownRight(x, pieceX, pieceY, greenPieces)):
            return removeGreenPiece(pieceX + 50, pieceY + 50)
    elif(player == 2 and (not isSpotOccupied(x, y, redPieces)) and (y == pieceY - 125)):
        if(checkUpRight(x, pieceX, pieceY, redPieces)):
            return removeRedPiece(pieceX + 50, pieceY - 50)
        elif(checkUpLeft(x, pieceX, pieceY, redPieces)):
            return removeRedPiece(pieceX - 50, pieceY - 50)
    else:
        return False


# returns whether or not the piece can move two to the right and if the spot up and to the right is occupied
def checkUpRight(x, pieceX, pieceY, pieces):
    return (x == pieceX + 75 and isSpotOccupied(pieceX + 25, pieceY - 75, pieces))


# returns whether or not the piece can move two to the left and if the spot up and to the left is occupied
def checkUpLeft(x, pieceX, pieceY, pieces):
    return (x == pieceX - 125 and isSpotOccupied(pieceX - 75, pieceY - 75, pieces))


# returns whether or not the piece can move two to the right and if the spot below and to the right is occupied
def checkDownRight(x, pieceX, pieceY, pieces):
    return (x == pieceX + 75 and isSpotOccupied(pieceX + 25, pieceY + 25, pieces))


# returns whether or not the piece can move two to the left and if the spot down and to the left is occupied
def checkDownLeft(x, pieceX, pieceY, pieces):
    return (x == pieceX - 125 and isSpotOccupied(pieceX - 75, pieceY + 25, pieces))


def removeGreenPiece(x, y):  # removes the piece with the given x and y attributes from the green pieces array and updates the number of green pieces accordingly
    global greenPieces
    global numGreen
    for piece in greenPieces:
        if (getattr(piece, 'x') == x and getattr(piece, 'y') == y):
            greenPieces.remove(piece)
            numGreen -= 1
            updateTile(piece)
            return True


def removeRedPiece(x, y):  # removes the piece with the given x and y attributes from the red pieces array and updates the number of reds left accordingly
    global redPieces
    global numRed
    for piece in redPieces:
        if (getattr(piece, 'x') == x and getattr(piece, 'y') == y):
            redPieces.remove(piece)
            numRed -= 1
            updateTile(piece)
            return True
