#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM invariant */
	case 3: // STATE 1 - _spin_nvr.tmp:3 - [(!(((ncrit==0)||(ncrit==1))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[1][1] = 1;
		if (!( !(((((int)now.ncrit)==0)||(((int)now.ncrit)==1)))))
			continue;
		/* merge: assert(!(!(((ncrit==0)||(ncrit==1)))))(0, 2, 6) */
		reached[1][2] = 1;
		spin_assert( !( !(((((int)now.ncrit)==0)||(((int)now.ncrit)==1)))), " !( !(((ncrit==0)||(ncrit==1))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[1][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 10 - _spin_nvr.tmp:8 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[1][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC user */
	case 5: // STATE 1 - peterson.pml:8 - [assert(((_pid==0)||(_pid==1)))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		spin_assert(((((int)((P0 *)_this)->_pid)==0)||(((int)((P0 *)_this)->_pid)==1)), "((_pid==0)||(_pid==1))", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 2 - peterson.pml:10 - [flag[_pid] = 1] (0:0:1 - 3)
		IfNotBlocked
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((int)now.flag[ Index(((int)((P0 *)_this)->_pid), 2) ]);
		now.flag[ Index(((P0 *)_this)->_pid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("flag[_pid]", ((int)now.flag[ Index(((int)((P0 *)_this)->_pid), 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 3 - peterson.pml:11 - [turn = _pid] (0:0:1 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		(trpt+1)->bup.oval = ((int)now.turn);
		now.turn = ((int)((P0 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("turn", ((int)now.turn));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 4 - peterson.pml:12 - [(((flag[(1-_pid)]==0)||(turn==(1-_pid))))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		if (!(((((int)now.flag[ Index((1-((int)((P0 *)_this)->_pid)), 2) ])==0)||(((int)now.turn)==(1-((int)((P0 *)_this)->_pid))))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 5 - peterson.pml:14 - [ncrit = 2] (0:0:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.ncrit);
		now.ncrit = 2;
#ifdef VAR_RANGES
		logval("ncrit", ((int)now.ncrit));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 6 - peterson.pml:15 - [assert((ncrit==1))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		spin_assert((((int)now.ncrit)==1), "(ncrit==1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 7 - peterson.pml:16 - [ncrit = (ncrit-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		(trpt+1)->bup.oval = ((int)now.ncrit);
		now.ncrit = (((int)now.ncrit)-1);
#ifdef VAR_RANGES
		logval("ncrit", ((int)now.ncrit));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 8 - peterson.pml:18 - [flag[_pid] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		(trpt+1)->bup.oval = ((int)now.flag[ Index(((int)((P0 *)_this)->_pid), 2) ]);
		now.flag[ Index(((P0 *)_this)->_pid, 2) ] = 0;
#ifdef VAR_RANGES
		logval("flag[_pid]", ((int)now.flag[ Index(((int)((P0 *)_this)->_pid), 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

