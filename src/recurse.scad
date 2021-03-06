/*

   What:  |
   ________

   Here follows some utility codes for Openscad procedural generation of sets in ordered dimensions.
   I hope they are pleasing to your sight and in your employ, however, I apologize in advance because they are butt.

   How: |
   ______

   By using these codes selectively and storing their values in arrays, recursion calls may be held to a minimum,
   but know that all employ some form of recursion, with calls generally increasing in direct proportion to the
   number of elements in the array parameters passed to the functions, or in the case of codes in the vector
   creation section the size of the desired vector.

   Some codes have default parameters. Be careful when tweaking these because it can change the recursive behavior,
   but please have fun experimenting.

   Please see comments above each code for notes.
   Please see comments below each code for usage examples.

   Why:  |
   _______

   deluded by the memory of A long lost perception,
   the mind strives, not onLy to survive, but to take flight,
   and as the its consciousness alIghtS to make right
   of the mighty disorder it perceives to be strange,
   to rearrange the causaL nAture of the local waveform,
   to propagate a new norm
   to overtake the very state
   which allowed Its eyes to self realize
   and therefore, Self create,
   tHe ego is born in its wake.

   When :|
   _______

   v0 2015 0208 - 2015 0217 0450:19-0500
   Anwar Hahj Jefferson-George
   anwarhahjjeffersongeorge (at) gmail (dot) com

*/

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// Vector Creation 20150222
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150222 Given a scalar 's' and a scalar 'n',
create a new vector 'v' such that:
v[m] is congruent to s for any 0 < m < n and undefined for all others
*/
function dummy(s, n) = [for(m = [0 : n-1]) s];
/*
//USAGE EXAMPLE 20150317
echo(str("dummy(1.618, 5): ", dummy(1.618, 5))); //20150317 ECHO: "dummy(1.618, 5): [1.618, 1.618, 1.618, 1.618, 1.618]"
echo(str("dummy([1,2,3],5) -> ", dummy([1,2,3],5))); //20150317 ECHO: "dummy([1,2,3],5) -> [[1, 2, 3], [1, 2, 3], [1, 2, 3], [1, 2, 3], [1, 2, 3]]"
*/
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150314 Given a scalar 's', a scalar 'i', and a scalar 'n'
 return a vector representing an arithmetic progression, 'v' with n items such that:

 v[m] = s + (i*m) for all  m < n

 the default values of s, i, n are just there for ease of use,

this is pretty much what you might do with a for loop such as for(i = [0:n]),
but it just reveals a vector should you require one
*/
function arithmetic(s=0, i=-1, n=8) = [for(m=[0 : n-1]) s+(i*m)];


/*
//USAGE EXAMPLE 20150317
echo(str("arithmetic() ->  ", arithmetic())); //20150317 ECHO: "arithmetic() ->  [0, -1, -2, -3, -4, -5, -6, -7]"
echo(str("arithmetic(10.5, 1.8, 6) ->  ", arithmetic(10.5, 1.8, 6))); //20150317 ECHO: "arithmetic(10.5, 1.8, 6) ->[10.5, 12.3, 14.1, 15.9, 17.7, 19.5]"
*/



///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
  20150314 Given a scalar 's', a scalar 'i', and a scalar 'n'
  return a geometric progression, 'v' with n items such that:
   v[m] = s*i^m for all m < n
*/
function geometric(s=1, i=2, n=8) = [ for(m = [0:n-1]) s*pow(i, m)];

/*
//USAGE EXAMPLES 20150317
echo(str("geometric() ->  ", geometric())); //20150317 ECHO: "geometric() ->  [1, 2, 4, 8, 16, 32, 64, 128]"
echo(str("geometric(1, .5) -> ", geometric(1,.5))); //20150317 ECHO: "geometric(1, .5) -> [1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125]"
echo(str("geometric(1, 1.618, 5) ->  ", geometric(1, 1.618, 5))); //20150317 ECHO: "geometric(1, 1.618, 5) ->  [1, 1.618, 2.61792, 4.2358, 6.85353]"
*/



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// Vector Manipulation 20150210
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150222 Given two unidimensional vectors, 'v0' and 'v1',
create 'w' in one dimension corresponding to [ [v0_0, v1_0], [v0_1, v1_1],  [v0_2, v1_2] ]
*/

function points_from_vecs(v0, v1) = [ for(m = [0 : len(v0)-1]) [v0[m], v1[m]] ];

/*
//USAGE EXAMPLE 20150317
testv0 = [1,2,3,4,5];
testv1 = [6,7,8,9,10];
echo(str("testv0: ", testv0, ", testv1: ", testv1, ", points_from_vecs(testv0, testv1) -> ", points_from_vecs(testv0, testv1) )); //20150317 ECHO: "testv0: [1, 2, 3, 4, 5], testv1: [6, 7, 8, 9, 10], points_from_vecs(testv0, testv1) -> [[1, 6], [2, 7], [3, 8], [4, 9], [5, 10]]"
*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
  20150213 Given vector 'vv' in n dimensions whose elements are vectors,
           a scalar 's', and
           a targe dimension 'dim',
           Return a new vector = [ [ vv0[0], vv0[1], ... , vv0[dim]*s, ..., vv0[n] ], [ vv1[0], vv1[1], ... , vv1[dim]*s, ..., vv1[n] ], ...]]
           or whose subelements at the target dimension have been multipled by s

           You should change the 'dim' parameter to change the dimension of the element sets that gets multiplied
           If the dim given exceeds the length of a vector element in vv, the original element will remain unchanged
*/
function scalar_dim_mult(vv, s, dim=0) = [ for( m = [0 : len(vv)-1]) scalar_ele_mult(vv[m], s=s, dim=dim)];

/*
//USAGE EXAMPLE 20150317
testscalvec = [[0,0],[1,1],[2,2],[3,3,3]];
//echo(len(unpackElement(testscalvec,0)));
//echo(len(testscalvec));
echo(str("testscalvec ", testscalvec, " scalar_dim_mult(testscalvec, 3.1) -> ",scalar_dim_mult(testscalvec, 3.1))); //20150317 ECHO: "testscalvec [[0, 0], [1, 1], [2, 2], [3, 3, 3]] scalar_dim_mult(testscalvec, 3.1) -> [[0, 0], [3.1, 1], [6.2, 2], [9.3, 3, 3]]"
testscalvec2 = [[0,0,0],[1,1,1],[2,2,2],[3],[4,4,4]];
echo(str("testscalvec2 ", testscalvec2, " scalar_dim_mult(testscalvec2, 4.2, 1) -> ",scalar_dim_mult(testscalvec2, 4.2, 1))); //20150317 ECHO: "testscalvec2 [[0, 0, 0], [1, 1, 1], [2, 2, 2], [3], [4, 4, 4]] scalar_dim_mult(testscalvec2, 4.2, 1) -> [[0, 0, 0], [1, 4.2, 1], [2, 8.4, 2], [3], [4, 16.8, 4]]"
*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150213 Given a vector 'v' in n dimensions,
         a scalar 's', and
         a target dimension 'dim'
         return a vector congruent to v with the exception of the
         the element at index dim, which should equal v[dim]*s

         You can change 'dim' parameter to change which element in the vector gets multiplied
         If given a dim > len(v), this will just return original vector v
*/
function scalar_ele_mult(v, s=1, dim=0) = [for(m = [0 : len(v)-1]) (m==dim) ? v[m]*s
                                                                            : v[m]
                                          ];

/*
testscalelevec = [0,1,1,1,1,1,6];
for(n=[0:len(testscalelevec)]){
  echo(str("testscalelevec ", testscalelevec, "scalar_ele_mult(testscalelevec, 2, 1) -> ",scalar_ele_mult(testscalelevec, 2, n)));
}
*/
/*
20150317 test:
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1) -> [0, 1, 1, 1, 1, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1) -> [0, 2, 1, 1, 1, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1) -> [0, 1, 2, 1, 1, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1) -> [0, 1, 1, 2, 1, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1) -> [0, 1, 1, 1, 2, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1) -> [0, 1, 1, 1, 1, 2, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1) -> [0, 1, 1, 1, 1, 1, 12]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1) -> [0, 1, 1, 1, 1, 1, 6]"
*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150225 given a vector 'v',
         an angle 'theta', and
         a scalar 'dim' ,
         return a vector whose element at index n is congruent to v[n] *sin(theta),
and elements at indices =/= n congruent to v[n]
*/
function sin_dim(v, theta=0, dim=0) = [scalar_ele_mult(v, sin(theta), dim=dim)];
/*
//20150225 test:
sin_dim_test_vec=[101, 202, 303, 1.165];
echo(str("sin_dim_test_vec: ", sin_dim_test_vec, " sin_dim(sin_dim_test_vec, 45, 2) -> ", sin_dim(sin_dim_test_vec, 45, 2)));
//^^^ 20150317 ECHO: "sin_dim_test_vec: [101, 202, 303, 1.165] sin_dim(sin_dim_test_vec, 45, 2) -> [[101, 202, 214.253, 1.165]]"
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150317 given a vector 'v',
         an angle 'theta', and
         a scalar 'dim' ,
         return a vector whose element at index n is congruent to v[n] *cos(theta),
and elements at indices =/= n congruent to v[n]
*/
function cos_dim(v, theta=0, dim=0) = [scalar_ele_mult(v, cos(theta), dim=dim)];
/*
//20150317 test:
cos_dim_test_vec=[101, 202, 303, 1.165];
echo(str("cos_dim_test_vec: ", cos_dim_test_vec, " cos_dim(cos_dim_test_vec, 45, 2) -> ", cos_dim(cos_dim_test_vec, 30, 3)));
ECHO: "cos_dim_test_vec: [101, 202, 303, 1.165] cos_dim(cos_dim_test_vec, 45, 2) -> [[101, 202, 303, 1.00892]]"
*/




///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
 20150210 return the value in vector 'v'
 whose index corresponds to len(v) - 'n+1',
 so 0 neg index is the last value in a vector
*/

function negInd(v, n) = ( (abs(n)<len(v)) && (len(v)>0)) ? unpackElement(v,len(v)-abs(n+1))
                                                         : "ERROR negInd(v, n) : vector parameter 'v' should contain at least one item / AND   (abs(n)) < len(v)"; //return value at len-n index, accepts negative or positive n

/*
//USAGE EXAMPLE 20150210...Retested 20150213 with unpackElement(v, n)
testvec = [0,1,2,3,4,5];
echo(str( "test vector: ", testvec, " --> negInd(testvec,2): ", negInd(testvec, 2)));   //20150210  ECHO: "test vector: [0, 1, 2, 3, 4, 5] --> negInd(testvec,2): 3"
echo(str( "test vector: ", testvec, " --> negInd(testvec,-3): ", negInd(testvec, -3))); //20150210  ECHO: "test vector: [0, 1, 2, 3, 4, 5] --> negInd(testvec,-3): 4"
echo(str( "test vector: ", testvec, " --> negInd(testvec,5): ", negInd(testvec, 5)));   //20150210  ECHO: "test vector: [0, 1, 2, 3, 4, 5] --> negInd(testvec,5): 0"
echo(str( "test vector: ", testvec, " --> negInd(testvec,6): ", negInd(testvec, 6)));   //20150210  ECHO: "test vector: [0, 1, 2, 3, 4, 5] --> negInd(testvec,6): ERROR negInd(v, n) : vector parameter 'v' should contain at least oen item, |'n'| (abs(n)) should be < len(v)"
*/
/*
testvec2d = [[1,1],[2,2,],[3,3],[5,5],[8,8]];
echo(str( "2d test vector: ", testvec2d, " --> negInd(testvec2d,2): ", negInd(testvec2d, 0)));
echo(str( "2d test vector: ", testvec2d, " --> reverse(testvec2d): ", reverse(testvec2d)));
echo(str( "2d test vector: ", testvec2d, " --> chopEnds(testvec2d): ", chopEnds(testvec2d)));
echo(str( "2d test vector: ", testvec2d, " --> firstLastSwap(testvec2d): ", firstLastSwap(testvec2d)));
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150211 given a vector v,
        return a vector whose elements correspond to v's but in
        reversed order
*/

function reverse(v) = (len(v) < 2) ? v
                                   : [for(m = [1 : len(v)]) v[len(v)-m]];

/*
//USAGE EXAMPLE 20150317
echo(str("geometric -> ", geometric(), " reverse(geometric()) -> ", reverse(geometric()))); //20150317 ECHO: "geometric -> [1, 2, 4, 8, 16, 32, 64, 128] reverse(geometric()) -> [128, 64, 32, 16, 8, 4, 2, 1]"
echo(str("reverse([[1,1],[2,2,],[3,3],[5,5],[8,8]]) -> ", reverse([[1,1],[2,2,],[3,3],[5,5],[8,8]]))); //20150317 ECHO: "reverse([[1,1],[2,2,],[3,3],[5,5],[8,8]]) -> [[8, 8], [5, 5], [3, 3], [2, 2], [1, 1]]"
testRevVec = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]; //even dimensionality
echo(str( "test vector: ", testRevVec, " --> reverse(testRevVec): ", reverse(testRevVec) )); //20150317 ECHO: "test vector: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] --> reverse(testRevVec): [19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]"
testRevVec2 = [2,4,6,8,120,20];
echo(str("does double reverse of test vector result in original? i.e. testRevVec2 == reverse(reverse(testRevVec2)))) = ",testRevVec2 == reverse(reverse(testRevVec2)))); //20150317 ECHO: "true"
testRevVec3 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]; // odd dimensionality
echo(str( "test vector: ", testRevVec3, " --> reverse(testRevVec3): ", reverse(testRevVec3) )); //20150317 ECHO: "test vector: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] --> reverse(testRevVec): [19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]"
*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150226 Given a vector 'v' with vector elements,
         return new vector 'w' whose vector elements are congruent
         to the reverse-ordered result of the corresponding
         element in the original v,
*/
function reverseElem(v) = [for(m = [0:len(v)-1]) reverse(v[m]) ];

/*
//USAGE EXAMPLE 20150317
reverse_ele_vec=[[0,1,2],[1,2,3],[2,3,4],[3,4,5],[4,5,6,7]];
//echo(unpackElement(reverse_ele_vec, 1));
echo(str("reverse_ele_vec = ",reverse_ele_vec, " reverseElem(reverse_ele_vec) -> ", reverseElem(reverse_ele_vec)));
//^ 20150317 ECHO: "reverse_ele_vec = [[0, 1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6, 7]] reverseElem(reverse_ele_vec) -> [[2, 1, 0], [3, 2, 1], [4, 3, 2], [5, 4, 3], [7, 6, 5, 4]]"
*/



///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150211 return a vector composed of the original input vector 'v'
concatenated with a vector corresponding to v reversed (reverse(v))
*/
function reflectvec(v) = concat(v, reverse(v));

/*
//USAGE EXAMPLE 20150211
testReflectVec= [0,1,2,3,4,5,6];
echo(str( "test vector: ", testReflectVec, " --> refletvec(testRefletvecVec): ", reflectvec(testReflectVec) )); //20150317 ECHO: "test vector: [0, 1, 2, 3, 4, 5, 6] --> refletvec(testRefletvecVec): [0, 1, 2, 3, 4, 5, 6, 6, 5, 4, 3, 2, 1, 0]"
*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150222 given vector 'vv'
        return vv with reverse of vv times scalar multiplier
*/
function reflectvec_scalar_dim_mult(vv, s, dim) = concat(vv, reverse(scalar_dim_mult(vv,s,dim)) );

/*
//USAGE EXAMPLE 20150317
testReflectVecscalarmult= [[0,0], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6]];
echo(str( "test vector: ", testReflectVecscalarmult, " --> reflectvec_scalar_dim_mult(testReflectVecscalarmult, -2, 0): ", reflectvec_scalar_dim_mult(testReflectVecscalarmult, -2, 0) ));
//20150317 ECHO: "test vector: [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]] --> reflectvec_scalar_dim_mult(testReflectVecscalarmult, -2, 0): [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [-12, 6], [-10, 5], [-8, 4], [-6, 3], [-4, 2], [-2, 1], [0, 0]]"
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150211 given a vector 'v',
         return a vector corresponding to values of v in original sequence
         except for the omission of values
         at index 0 and len(v)-1 (the first and last)
*/
/*
function chopEnds(v, modv=[], index=1) = (len(v)<3) ? "ERROR  chopEnds(v, modv=[], index=1) : vector parameter 'v' should contain at least three items, i.e. len(v)>=3"
                                                    : (index<len(v)-1) ? chopEnds(v, concat(modv, unpackElement(v,index)), index+1)
                                                                       : modv;
*/
function chopEnds(v) = (len(v) < 3) ? v
                                    : [for( m=[1 : len(v)-2]) v[m]];

/*
//USAGE EXAMPLE 20150217
testChopVec = [0,1];
echo(str( "test vector: ", testChopVec, " --> chopEnds(testChopVec): ", chopEnds(testChopVec)));   //20150317 ECHO: "test vector: [0, 1] --> chopEnds(testChopVec): ERROR  chopEnds(v, modv=[], index=1) : vector parameter 'v' should contain at least three items, i.e. len(v)>=3"
testChopVec2 = [0,1,1];
echo(str( "test vector: ", testChopVec2, " --> chopEnds(testChopVec2): ", chopEnds(testChopVec2)));   //20150317 ECHO: "test vector: [0, 1, 1] --> chopEnds(testChopVec2): [1]"
testChopVec3 = [0,1,1,2,3,5];
echo(str( "test vector: ", testChopVec3, " --> chopEnds(testChopVec3): ", chopEnds(testChopVec3)));   //20150317 ECHO: "test vector: [0, 1, 1, 2, 3, 5] --> chopEnds(testChopVec3): [1, 1, 2, 3]"
testChopVec4 = [0,1,1,[2,2],3,5];
echo(str( "test vector: ", testChopVec4, " --> chopEnds(testChopVec4): ", chopEnds(testChopVec4)));   //20150317 ECHO: "test vector: [0, 1, 1, [2, 2], 3, 5] --> chopEnds(testChopVec4): [1, 1, [2, 2], 3]"
*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150211 given vector v,
         return v with swapped first [0] and last [len(v)-1] values....
         IF THERE ARE LESS THAN TWO values in 'v', just return v,

*/


function firstLastSwap(v) = [for( m=[0:len(v)-1]) (m == 0) ? v[len(v)-1]
                                                           : (m == len(v)-1) ? v[0]
                                                                             : v[m]];
/*
//USAGE EXAMPLE 20150317
testvec = [0,1,2,3,4,5];
echo(str( "test vector: ", testvec, " --> firstLastSwap(testvec): ", firstLastSwap(testvec)));   //20150211  ECHO: "test vector: [0, 1, 2, 3, 4, 5] --> firstLastSwap(testvec): [5, 1, 2, 3, 4, 0]"
testvec2 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];
echo(str( "test vector: ", testvec2, " --> firstLastSwap(testvec2): ", firstLastSwap(testvec2)));   //20150211 ECHO: "test vector: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] --> firstLastSwap(testvec2): [19, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 0]"
testvec3 = [4];
echo(str( "test vector: ", testvec3, " --> firstLastSwap(testvec3): ", firstLastSwap(testvec3)));   //20150211 ECHO: "test vector: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] --> firstLastSwap(testvec3): [4]"
testvec4 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,[20,20]];
echo(str( "test vector: ", testvec4, " --> firstLastSwap(testvec4): ", firstLastSwap(testvec4)));   //20150213 ECHO: "test vector: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, [20, 20]] --> firstLastSwap(testvec4): [[20, 20], 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 0]"
*/


///////////////////////////////////////////////////////////////////
//20151213 can we unpack a vector subelement of a vector without losing its internal brackets?
function unpackElement(v, index) = (index>=len(v)) ? str(index, " ERROR unpackElement(v, index) : scalar parameter 'index' SHOULD BE LESS THAN length of vector parameter 'v' index < len(v)") /**/
                                                   : (len(v[index])==undef)? v[index]  /*check length of element, returning if it is not a vector*/
                                                                           : [v[index]]/*try to vectorize the element upon returning*/;
/*
v = [0,[1,1],2,[3,3]];
echo(str("Vector 'v':", v, " length of v len(v) ", (len(v)), " length of elements in v follows: "));
for(n = [0:len(v)-1]){
  //echo(str("v[n]: ",v[n]," len(v[n]): ", len(v[n]) ));
  echo(str("unpackElement(v,n): ", unpackElement(v, n)));
  echo(str("v: ", v, "firstLastSwap(v)",  firstLastSwap(v)));

}
*/

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Circular Access 20150316
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150316 given vector 'v' and scalar 'n' corresponding to an index in v
return element of v with index n-1
*/
function prev(v, n) = (n%len(v)==0) ? negInd(v,0)
                                    : v[n%len(v)-1];

/*
// USAGE EXAMPLE 20150316
testvec23=arithmetic(0,1,8);
echo("testvec23 = ", testvec23);
//echo(str("testvec23 = ", testvec23, " prev(testvec23,len(testvec23)-1) -> ", prev(testvec23,len(testvec23)-1)));
echo(str("testvec23 = ", testvec23, " prev(testvec23,0) -> ", prev(testvec23,0))); //20150316 ECHO: "testvec23 = [0, 1, 2, 3, 4, 5, 6, 7] prev(testvec23,0) -> 7"
testvec23d = [[1,1],[2,2,],[3,3],[5,5],[8,8]];
echo(str("testvec23d ", testvec23d, " prev(testvec23d,4) -> ", prev(testvec23d,4) )); //20150316 ECHO: "testvec23d [[1, 1], [2, 2], [3, 3], [5, 5], [8, 8]] prev(testvec23d,4) -> [5, 5]"
echo(str("prev([[1,1],[2,2,],[3,3],[5,5],[8,8]], 0) -> ", prev([[1,1],[2,2,],[3,3],[5,5],[8,8]], 0))); //20150316 ECHO: "prev([[1,1],[2,2,],[3,3],[5,5],[8,8]], 0) -> [[8, 8]]"
*/

/*
20150316 given vector 'v' and scalar 'n' corresponding to an index in v
return element of v with index n+1
*/
function next(v, n) = (n % len(v) == len(v)-1) ? v[0]
                                               : v[n%len(v)+1];
/*
echo(str("next([[1,1],[2,2,],[3,3],[5,5],[8,8]], 0) -> ", next([[1,1],[2,2,],[3,3],[5,5],[8,8]], 0))); //20150316 ECHO: "next([[1,1],[2,2,],[3,3],[5,5],[8,8]], 0) -> [2, 2]"
echo(str("arithmetic() -> ", arithmetic(),  " next(arithmetic(), 7) -> ", next(arithmetic(), 7))); //20150316 ECHO: "arithmetic() -> [0, -1, -2, -3, -4, -5, -6, -7] next(arithmetic(), 7) -> 0"
*/


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Element Manipulation 20150225
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
20150225   This is a TEMPLATE function, which means you should copypasta it
           and redefine as needed. For this to work properly, please be certain
           to be careful with what you name the copies so you avoid conflicts
           When using with a vector comprised of vector elements, take care to
           adapt the function called by the template appropriately

           REMEMBER TO CHANGE the funcTemplate name in BOTH PLACES and to change the
                              func name in BOTH PLACES
           You can also inline the func within the funcTemplate

Given a vector 'v', a scalar 'n' within the indices of v,
 and a SEPARATELY DEFINED function 'func', return a vector 'w' whose elements
 satisfy the following: w[m] = func(v[m]),  m=n
                        w[m] = v[m],        m=/=n

*/


function func(element) = element/.618; //random
function funcTemplate(v, n, index=0, w=[]) = (index<len(v)) ? funcTemplate(v, n, index+1, (index==n) ? concat(w, func(unpackElement(v,index)))
                                                                                                     : concat(w, unpackElement(v, index)))
                                                            : w;
/*
// USAGE EXAMPLE 20150225
template_test_vec = [0, 1,2,3,4,5,6,7,8];
echo(str("template_test_vec = ", template_test_vec, " funcTemplate(template_test_vec, 5) -->", funcTemplate(template_test_vec, 5)));
//^ 20150225 ECHO: "template_test_vec = [0, 1, 2, 3, 4, 5, 6, 7, 8] funcTemplate(template_test_vec, 5) -->[0, 1, 2, 3, 4, 8.09061, 6, 7, 8]"
template_test_vec2 = [[0,0,0], [1,1,1], [2,2,2],[3,3,3],[4,4,4]];
echo(str("template_test_vec2 = ", template_test_vec2, " funcTemplate(template_test_vec2, 3) -->", funcTemplate(template_test_vec2, 3)));
//^ ECHO: "template_test_vec2 = [[0, 0, 0], [1, 1, 1], [2, 2, 2], [3, 3, 3], [4, 4, 4]] funcTemplate(template_test_vec2, 3) -->[[0, 0, 0], [1, 1, 1], [2, 2, 2], [4.85437, 4.85437, 4.85437], [4, 4, 4]]"
*/

//funcTemplate inline adaptation
function i_j_Rot(v, n, theta=72, index=0, w=[]) = (index<len(v)) ? i_j_Rot(v, n, theta, index+1, (index==n) ? concat(w, [[v[index][0]*cos(theta), v[index][0]*sin(theta), v[index][2]]])
                                                                                                            : concat(w, unpackElement(v, index)))
                                                                 : w;

function i_j_Rot_All(v, theta=72, index=0, w=[]) = (index<len(v)) ? i_j_Rot_All(v, theta, index+1, concat(w, [[v[index][0]*cos(theta), v[index][0]*sin(theta), v[index][2]]]))
                                                                  : w;
/*
template_test_vec3 = [[0,0,0], [1,1,1], [2,2,2],[3,3,3],[4,4,4]];
echo(str("template_test_vec3 = ", template_test_vec3, len(template_test_vec3), " i_j_Rot(template_test_vec3, 2) -->", i_j_Rot(template_test_vec3,2)));
//^ 20150225 ECHO: "template_test_vec3 = [[0, 0, 0], [1, 1, 1], [2, 2, 2], [3, 3, 3], [4, 4, 4]]5 i_j_Rot(template_test_vec3, 2) -->[[0, 0, 0], [1, 1, 1], [0.618034, 1.90211, 2], [3, 3, 3], [4, 4, 4]]"
*/



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//Fibonacci Sequence 20150208
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
  20150208 Given vector 'ab', and
           scalar 'n'
           return vector f corresponding to an extension of ab into an additional
           n dimensions, with the elements at additional dimensions corresponding
           to f[m] = f[m-1] + f[m-2]
           If ab only provides one starting value, it will be duplicated to create a second
*/
function f(ab,n) = (n>1) ? f(concat(ab, sumfinalpair(ab)), n-1 )
                         : concat(ab, sumfinalpair(ab));

/*
//USAGE EXAMPLE - 20150209
result = f([1.1,2],17);
echo(result);
echo(str(f([0,1], 3)));
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/*
  20150208 Given a vector 'v'
           return the sum of the last two elements of v,
           or if v has only one element, return that element times two
*/
function sumfinalpair(v) = len(v)>=2 ? negInd(v,0) + negInd(v,1)
                                     : v[0]*2;
/*
//USAGE EXAMPLE 20150317
echo(sumfinalpair([6])); //20150317 ECHO: 12
*/
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//Generate Degenerate (Rectangular) Spiral
function f_corners(radii, start=270, rotation=-90, n=3, corners=[[0,0],[0,0],[0,0]]) = (n < len(radii)) ? f_corners(radii, start+rotation, rotation, n+1, concat(corners, [newcorner(corners[n-1], radii[n-2], start)])) : corners;
function newcorner(vv, r, theta) = len(vv)>=2? [ vv[0] + r*cos(theta), vv[1] + r*sin(theta)] : "ERROR newcorner(vv,r,theta) : vector parameter 'vv'  should be ordered pair in 2 dimensions ";
/*
//USAGE EXAMPLES 20150210
f_result = f([0,1],6);
echo("f result ",f_result); //20150210 ECHO: "f result ", [0, 1, 1, 2, 3, 5, 8. 13]
f_corners_result  = f_corners(f_result);
echo("f_corners result", f_corners_result);//20150210 ECHO: "f_corners result", [[0, 0], [0, 0], [0, 0], [0, -1], [-1, -1], [-1, 1], [2, 1], [2, -4]]

newcorner_result = newcorner([0,0], 1, 250);
echo(str("newcorner result ", newcorner_result)); //20150210 ECHO: "newcorner result [-0.34202, -0.939693]"
*/
