#define N 5
mtype = { msg0, msg1, ack0, ack1 };

chan sender[N] = [1] of { mtype };
chan receiver[N] = [1] of { mtype };

inline phase(msg, good_ack, bad_ack)
{
	do
	:: sender[_pid]?good_ack -> break
	:: sender[_pid]?bad_ack
	:: timeout ->
		if
		:: receiver[_pid]!msg;
		:: skip	/* lose message */
		fi;
	od
}

inline recv(cur_msg, cur_ack, lst_msg, lst_ack)
{
	do
	:: receiver[_pid]?cur_msg -> sender[_pid]!cur_ack; break /* accept */
	:: receiver[_pid]?lst_msg -> sender[_pid]!lst_ack
	od;
}

active [N] proctype Sender()
{
	do
	:: phase(msg1, ack1, ack0);
	   phase(msg0, ack0, ack1)
	od
}

active [N] proctype Receiver()
{
	do
	:: recv(msg1, ack1, msg0, ack0);
	   recv(msg0, ack0, msg1, ack1)
	od
}
