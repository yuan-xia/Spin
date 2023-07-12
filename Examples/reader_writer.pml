#define N 2 // Number of readers

byte readers = 0;
bool writer = false;
bool writing = false;
bool reading = false;
bool waiting = false;

active [N] proctype Reader()
{
    do
    :: true ->
        atomic {
            if
            :: waiting ->
                skip; // Reader waits for writer
            :: writing || waiting ->
                waiting = true;
                skip; // Reader waits for turn
            :: else ->
                reading = true;
                readers++;
            fi;
        }

        // Reading data...
        printf("Reader %d is reading.\n", _pid);

        atomic {
            readers--;
            if
            :: readers == 0 ->
                reading = false;
                waiting = false;
                printf("All readers finished reading.\n");
            :: else ->
                skip; // Other readers still reading
            fi;
        }

        // Continue with other tasks...
        printf("Reader %d continues with other tasks.\n", _pid);
    od
}

active proctype Writer()
{
    do
    :: true ->
        atomic {
            if
            :: readers > 0 || writer ->
                waiting = true;
                skip; // Writer waits for turn
            :: else ->
                writer = true;
                writing = true;
            fi;
        }

        // Writing data...
        printf("Writer is writing.\n");

        atomic {
            writing = false;
            writer = false;
            waiting = false;
            printf("Writer finished writing.\n");
        }

        // Continue with other tasks...
        printf("Writer continues with other tasks.\n");
    od
}

