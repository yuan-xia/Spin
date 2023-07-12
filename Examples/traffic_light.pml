#define RED 0
#define YELLOW 1
#define GREEN 2
#define NUM_LIGHTS 10

byte colors[NUM_LIGHTS];
byte turn = 0;

proctype Light(byte myId) {
    colors[myId] = RED; // start with a red light

    do
    :: (turn == myId && colors[myId] == RED) ->
        colors[myId] = GREEN;
        //printf("Light %d changed to %d\n", myId, colors[myId]);
    :: (turn == myId && colors[myId] == YELLOW) ->
        atomic {
            colors[myId] = RED;
            turn = (turn + 1) % NUM_LIGHTS; // switch turn to the next light
            //printf("Light %d changed to %d\n", myId, colors[myId]);
        }
    :: (turn == myId && colors[myId] == GREEN) ->
        colors[myId] = YELLOW;
        //printf("Light %d changed to %d\n", myId, colors[myId]);
    od
}

init {
    byte i;
    for (i : 0 .. NUM_LIGHTS-1) {
        run Light(i);
    }
}
