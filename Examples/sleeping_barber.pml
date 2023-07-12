#define N 10

mtype = { ARRIVAL, DEPARTURE };

chan queue = [N] of { mtype };

int waiting = 0;
int served = 0;
bool is_sleeping = true;

active proctype barber() {
    do
    :: waiting > 0 -> {
        is_sleeping = false;
        queue?ARRIVAL;
        served++;
        waiting--;
    }
    :: else -> {
        is_sleeping = true;
    }
    od
}

active proctype customer() {
    do
    :: waiting < N -> {
        queue!ARRIVAL;
        waiting++;
        // wait to be served
    }
    od
}
