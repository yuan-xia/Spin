/* Peterson's solution to the mutual exclusion problem - 1981 */

bool turn, flag[2];
byte ncrit;

active [2] proctype user()
{
	assert(_pid == 0 || _pid == 1);
again:
	flag[_pid] = 1;
	turn = _pid;
	(flag[1 - _pid] == 0 || turn == 1 - _pid);

	ncrit = 2;
	assert(ncrit == 1);	/* critical section */
	ncrit--;

	flag[_pid] = 0;
	goto again
}

/*
ltl invariant { [] ((ncrit == 0 ) || ((ncrit == 1) && (((flag[0]==1) && ((flag[1]==1) || (turn==0))) || ((flag[0]==0) && (flag[1]==1) && (turn==1))))) } 
*/

ltl invariant { [] ((ncrit==0) || (ncrit==1)) }
