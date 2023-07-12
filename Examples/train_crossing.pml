#define N 5

mtype = { ENTER, LEAVE };

chan bridge[N] = [1] of { mtype };
chan barrier[N] = [1] of { mtype };

int count = 0;

proctype train(int my_id) {
    do
        :: true -> {
            barrier!ENTER;
            barrier?LEAVE;
            bridge[my_id]!ENTER;
            bridge[my_id]!LEAVE;
        }
    od
}

proctype car(int my_id) {
    do
        :: true -> {
            bridge[my_id]!ENTER;
            count++;
            if
            :: count == N ->
                barrier!LEAVE;
                count = 0;
            fi
            bridge[my_id]!LEAVE;
        }
    od
}

init {
    atomic {
        run car(0);

        run train(0);
        run train(1);
        run train(2);
        run train(3);
        run train(4);
    }
}