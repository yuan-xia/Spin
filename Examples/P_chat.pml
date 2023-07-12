#define N 5
mtype = { Join, Leave, Message };

typedef User {
    mtype status;
};

typedef Server {
    mtype status;
};

typedef Users {
    User machines[N];
};



chan join_chan = [N] of { mtype, int };
chan leave_chan = [N] of { mtype, int };
chan message_chan = [N] of { mtype, int, string };

User users[N];
Server server;
Users chat;

init {
    atomic {
        for (i : 0..N-1) {
            users[i].status = Join;
            run User(i);
            join_chan ! Join, i;
        }

        server.status = Join;
        run Server();

        do
        :: join_chan ? Join, _ -> skip;
        :: leave_chan ? Leave, _ -> skip;
        :: message_chan ? Message, _, _ -> skip;
        od
    }
}

active proctype User(int id) {
    do
    :: join_chan ? Join, id ->
        users[id].status = Join;
    :: leave_chan ? Leave, id ->
        users[id].status = Leave;
    :: message_chan ? Message, id, msg ->
        if
        :: users[id].status == Join ->
            printf("User %d received message: %s\n", id, msg);
        :: else ->
            skip;
        fi;
    od
}

active proctype Server() {
    int joined_count = 0;

    do
    :: join_chan ? Join, id ->
        if
        :: server.status == Join ->
            joined_count++;
            server.status = joined_count;
            printf("User %d joined the chat\n", id);
        :: else ->
            skip;
        fi;
    :: leave_chan ? Leave, id ->
        if
        :: server.status == joined_count ->
            joined_count--;
            server.status = joined_count;
            printf("User %d left the chat\n", id);
        :: else ->
            skip;
        fi;
    :: message_chan ? Message, id, msg ->
        if
        :: server.status == joined_count ->
            printf("Server broadcasting message from User %d: %s\n", id, msg);
            for (i : 0..N-1) {
                if
                :: users[i].status == Join ->
                    message_chan ! Message, id, msg;
                :: else ->
                    skip;
                fi;
            }
        :: else ->
            skip;
        fi;
    od
}

bool message_delivered[N];

proctype Monitor() {
    atomic {
        message_delivered[0] = false;
        message_delivered[1] = false;
        message_delivered[2] = false;
        message_delivered[3] = false;
        message_delivered[4] = false;

        do
        :: message_chan ? Message, id, msg ->
            if
            :: users[id].status == Join ->
                message_delivered[id] = true;
            :: else ->
                skip;
            fi;

            if
            :: message_delivered[0] && message_delivered[1] && message_delivered[2] && message_delivered[3] && message_delivered[4] ->
                printf("All joined users received the message\n");
                break;
            :: else ->
                skip;
            fi;
        od
    }
}