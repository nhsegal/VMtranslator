// Sys.vm for Ne<html>
<head>
	
// Sys.init()
//
// Calls Sys.main() and stores return value in temp 1.
// Does not return.  (Enters infinite loop.)

function Sys.init 0
push constant 4000	// test THIS and THAT context save
pop pointer 0
push constant 5000
pop pointer 1
call Sys.main 0
pop temp 1
label LOOP
goto LOOP

// Sys.main()
//
// Sets locals 1, 2 and 3, leaving locals 0 and 4 unchanged to test
// default local initialization to 0.  (RAM set to -1 by test setup.)
// Calls Sys.add12(123) and stores return value (135) in temp 0.
// Returns local 0 + local 1 + local 2 + local 3 + local 4 (456) to confirm
// that locals were not mangled by function call.

function Sys.main 5
push constant 4001
pop pointer 0
push constant 5001
pop pointer 1
push constant 200
pop local 1
push constant 40
pop local 2
push constant 6
pop local 3
push constant 123
call Sys.add12 1
pop temp 0
push local 0
push local 1
push local 2
push local 3
push local 4
add
add
add
add
return

// Sys.add12(int n)
//
// Returns n+12.

function Sys.add12 0
push constant 4002
pop pointer 0
push constant 5002
pop pointer 1
push argument 0
push constant 12
add
return
-1,
set RAM[297] -1,
set RAM[298] -1,
set RAM[299] -1,

set sp 261,
set local 261,
set argument 256,
set this 3000,
set that 4000;

repeat 50 {
  vmstep;
}
output;
d {border-left:2px solid;}
	.stack .bframe td:first-child + td + td {border-right:2px solid;}
	.stack .bframet {border-left:1px solid; border-right:1px solid;}
	.stack .bframet td:first-child + td {border-left:2px solid;border-top:2px solid;}
	.stack .bframet td:first-child + td + td {border-right:2px solid;border-top:2px solid;}
	.stack .bframeb {border-left:1px solid; border-right:1px solid;}
	.stack .bframeb td:first-child + td {border-left:2px solid;border-bottom:2px solid;}
	.stack .bframeb td:first-child + td + td {border-right:2px solid;border-bottom:2px solid;}
	.stack .note td {padding-left:.5em;padding-right:.5em;white-space:normal;text-align:justify;}
	.stack .fid {font-style:italic}
	.master {width: 10%;}
	.master td {vertical-align:top;padding-right:.5em; }
	</style>
</head>
<body>
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<table class="master">
<tr>
  <td>
	<table class="stack">
	<tr><th colspan="4">Bootstrap init</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>256</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>-1</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>-2</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>-3</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>-4</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="tos"><td>256</td><td>???</td><td></td><td>&larr;SP</td></tr>
	<tr class="note"><td colspan="4"><br>
		This is how my boot&shy;strap code initial&shy;izes the pointers before calling Sys.init().
		<p>
		Setting the LCL, ARG, THIS and THAT point&shy;ers to known illegal values helps identify 
		when a pointer is used before it is initial&shy;ized.
		<p>
		(If you are running the NestedCall test with&shy;out boot&shy;strap code, you will not see this state.)</td></tr>
	</table>
  </td><td>
	<table class="stack">
	<tr><th colspan="4">Entry to Sys.init()</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>261</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>261</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>256</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>-3</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>-4</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="bframet"><td>256</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>
	<tr class="bframe"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>
	<tr class="bframe"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>
	<tr class="bframe"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="bframeb"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>
	<tr class="tos"><td>261</td><td>???</td><td></td><td>&larr;LCL, SP</td></tr>
	<tr class="note"><td colspan="4"><br>
		This is how NestedCall.tst initial&shy;izes the pointers and stack.  This is what RAM looks 
		like after my boot&shy;strap calls Sys.init().
		<p>
		(If your VM trans&shy;lation includes the boot&shy;strap, the -1 through -4 values may be 
		different if your boot&shy;strap initial&shy;izes them.)</td></tr>
	</table>
  </td><td>
	<table class="stack">
	<tr><th colspan="4">Entry to Sys.main()</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>266</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>266</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>261</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>4000</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>5000</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>
	<tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>
	<tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>
	<tr class="bframet"><td>261</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>
	<tr class="bframe"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>
	<tr class="bframe"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>
	<tr class="bframe"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="bframeb"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>
	<tr class="tos"><td>266</td><td>???</td><td></td><td>&larr;LCL, SP</td></tr>
	</table>
  </td><td>
	<table class="stack">
	<tr><th colspan="4">After Sys.main() prologue</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>271</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>266</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>261</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>4000</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>5000</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>
	<tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>
	<tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>
	<tr class="bframet"><td>261</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>
	<tr class="bframe"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>
	<tr class="bframe"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>
	<tr class="bframe"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="bframe"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>
	<tr class="bframe"><td>266</td><td>0</td><td>local 0</td><td>&larr;LCL</td></tr>
	<tr class="bframe"><td>267</td><td>0</td><td>local 1</td><td></td></tr>
	<tr class="bframe"><td>268</td><td>0</td><td>local 2</td><td></td></tr>
	<tr class="bframe"><td>269</td><td>0</td><td>local 3</td><td></td></tr>
	<tr class="bframeb"><td>270</td><td>0</td><td>local 4</td><td></td></tr>
	<tr class="tos"><td>271</td><td>???</td><td></td><td>&larr;SP</td></tr>
	<tr class="note"><td colspan="4"><br>
		The <i>function prologue</i> is the assembly language code generated for the 
		"function" VM command.
	</table>
  </td><td>
	<table class="stack">
	<tr><th colspan="4">Entry to Sys.add12(123)</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>277</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>277</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>271</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>4001</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>5001</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>
	<tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>
	<tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>
	<tr class="framet"><td>261</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="frame"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>
	<tr class="frame"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>
	<tr class="frame"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="frame"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>
	<tr class="frame"><td>266</td><td>0</td><td>local 0</td><td></td></tr>
	<tr class="frame"><td>267</td><td>200</td><td>local 1</td><td></td></tr>
	<tr class="frame"><td>268</td><td>40</td><td>local 2</td><td></td></tr>
	<tr class="frame"><td>269</td><td>6</td><td>local 3</td><td></td></tr>
	<tr class="frame"><td>270</td><td>0</td><td>local 4</td><td></td></tr>
	<tr class="bframet"><td>271</td><td>123</td><td>argument 0</td><td>&larr;ARG</td></tr>
	<tr class="bframe"><td>272</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="bframe"><td>273</td><td>266</td><td>Saved LCL</td><td class="fid">Sys.add12</html>
r>
	<tr class="bframe"><td>274</td><td>261</td><td>Saved ARG</td><td class="fid">&ensp;frame</td></tr>
	<tr class="bframe"><td>275</td><td>4001</td><td>Saved THIS</td><td></td></tr>
	<tr class="bframeb"><td>276</td><td>5001</td><td>Saved THAT</td><td></td></tr>
	<tr class="tos"><td>277</td><td>???</td><td></td><td>&larr;LCL, SP</td></tr>
	</table>
  </td>
</tr></table>

<p>

<table class="master">
<tr>
  <td>
	<table class="stack">
	<tr><th colspan="4">Before Sys.add12() return</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>278</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>277</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>271</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>4002</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>5002</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>
	<tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>
	<tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>
	<tr class="framet"><td>261</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="frame"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>
	<tr class="frame"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>
	<tr class="frame"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="frame"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>
	<tr class="frame"><td>266</td><td>0</td><td>local 0</td><td></td></tr>
	<tr class="frame"><td>267</td><td>200</td><td>local 1</td><td></td></tr>
	<tr class="frame"><td>268</td><td>40</td><td>local 2</td><td></td></tr>
	<tr class="frame"><td>269</td><td>6</td><td>local 3</td><td></td></tr>
	<tr class="frame"><td>270</td><td>0</td><td>local 4</td><td></td></tr>
	<tr class="bframet"><td>271</td><td>123</td><td>argument 0</td><td>&larr;ARG</td></tr>
	<tr class="bframe"><td>272</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="bframe"><td>273</td><td>266</td><td>Saved LCL</td><td class="fid">Sys.add12</td></tr>
	<tr class="bframe"><td>274</td><td>261</td><td>Saved ARG</td><td class="fid">&ensp;frame</td></tr>
	<tr class="bframe"><td>275</td><td>4001</td><td>Saved THIS</td><td></td></tr>
	<tr class="bframe"><td>276</td><td>5001</td><td>Saved THAT</td><td></td></tr>
	<tr class="bframeb"><td>277</td><td>135</td><td>Return value</td><td>&larr;LCL</td></tr>
	<tr class="tos"><td>278</td><td>???</td><td></td><td>&larr;SP</td></tr>
	</table>
  </td><td>
	<table class="stack">
	<tr><th colspan="4">After Sys.add12() return</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>272</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>266</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>261</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>4001</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>5001</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>
	<tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>
	<tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>
	<tr class="bframet"><td>261</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>
	<tr class="bframe"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>
	<tr class="bframe"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>
	<tr class="bframe"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="bframe"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>
	<tr class="bframe"><td>266</td><td>0</td><td>local 0</td><td>&larr;LCL</td></tr>
	<tr class="bframe"><td>267</td><td>200</td><td>local 1</td><td></td></tr>
	<tr class="bframe"><td>268</td><td>40</td><td>local 2</td><td></td></tr>
	<tr class="bframe"><td>269</td><td>6</td><td>local 3</td><td></td></tr>
	<tr class="bframe"><td>270</td><td>0</td><td>local 4</td><td></td></tr>
	<tr class="bframeb"><td>271</td><td>135</td><td>Return value</td><td></td></tr>
	<tr class="tos"><td>272</td><td>???</td><td></td><td>&larr;SP</td></tr>
	</table>
  </td><td>
	<table class="stack">
	<tr><th colspan="4">Before Sys.main() return</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>272</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>266</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>261</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>4001</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>5001</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>
	<tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>
	<tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>
	<tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>
	<tr class="bframet"><td>261</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>
	<tr class="bframe"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>
	<tr class="bframe"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>
	<tr class="bframe"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="bframe"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>
	<tr class="bframe"><td>266</td><td>0</td><td>local 0</td><td>&larr;LCL</td></tr>
	<tr class="bframe"><td>267</td><td>200</td><td>local 1</td><td></td></tr>
	<tr class="bframe"><td>268</td><td>40</td><td>local 2</td><td></td></tr>
	<tr class="bframe"><td>269</td><td>6</td><td>local 3</td><td></td></tr>
	<tr class="bframe"><td>270</td><td>0</td><td>local 4</td><td></td></tr>
	<tr class="bframeb"><td>271</td><td>246</td><td>Return value</td><td></td></tr>
	<tr class="tos"><td>272</td><td>???</td><td></td><td>&larr;SP</td></tr>
	</table>
  </td><td>
	<table class="stack">
	<tr><th colspan="4">After Sys.main() return</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>262</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>261</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>256</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>4000</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>5000</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="bframet"><td>256</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>
	<tr class="bframe"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>
	<tr class="bframe"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>
	<tr class="bframe"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="bframe"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>
	<tr class="bframeb"><td>261</td><td>246</td><td>Return value</td><td>&larr;LCL</td></tr>
	<tr class="tos"><td>262</td><td>???</td><td></td><td>&larr;SP</td></tr>
	</table>
  </td><td>
	<table class="stack">
	<tr><th colspan="4">In Sys.init() halt loop</th></tr>
	<tr class="reg"><th colspan="4">Pointers</th></tr>
	<tr class="reg"><td>0</td><td>261</td><td>SP</td><td></td></tr>
	<tr class="reg"><td>1</td><td>261</td><td>LCL</td><td></td></tr>
	<tr class="reg"><td>2</td><td>256</td><td>ARG</td><td></td></tr>
	<tr class="reg"><td>3</td><td>4000</td><td>THIS</td><td></td></tr>
	<tr class="reg"><td>4</td><td>5000</td><td>THAT</td><td></td></tr>
	<tr class="stack"><th colspan="4">Stack</th></tr>
	<tr class="bframet"><td>256</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>
	<tr class="bframe"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>
	<tr class="bframe"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>
	<tr class="bframe"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>
	<tr class="bframeb"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>
	<tr class="tos"><td>261</td><td>???</td><td></td><td>&larr;LCL, SP</td></tr>
	</table>
  </td>
</tr></table>

</body>
</html>
