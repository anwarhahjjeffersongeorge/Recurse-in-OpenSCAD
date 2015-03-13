/*

   What:  |
   ________

   Here follows some utility codes for Openscad procedural generation of sets in ordered dimensions.
   I hope they are pleasing to your sight and in your employ, however, I apologize in advance because they are butt.

   How: |
   ______

   By using these codes selectively and storing their values in arrays, recursion calls may be held to a minimum,
   but know that all employ some form of recursion, with calls generally increasing in direct proportion to the
   number of elements in the array parameters passed to the functions.

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
//20150222 Given a scalar 's' and a scalar 'n', create a new unidimensional vector 'v'
//such that v[m] is congruent to s for any 0 < m < n and undefined for all others
function dummy(s, n, v=[], index=0) = (index < n) ? dummy(s,n,concat(v, s), index+1)
                                                  : v;

/*
//USAGE EXAMPLE 20150222
echo(str("dummy(1.618, 5): ", dummy(1.618, 5))); //20150222 ECHO: "dummy(1.618, 5): [1.618, 1.618, 1.618, 1.618, 1.618]"
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150222 Given an example vector 'v' in one dimension, and a scalar 'n', create a new vector 'w' whoes elements are all congruent to v
function fill(v, n, w=[], index=0) = (index<n) ? fill(v, n, concat(w, [v]), index+1)
                                               : w;
/*
//USAGE EXAMPLE 20150222
testfillvec = [0,1,2,3,4,5];
echo(str("testfillvec: ", testfillvec, ", fill(testfillvec, 4):", fill(testfillvec, 4) )); //20150522 ECHO: "testfillvec: [0, 1, 2, 3, 4, 5], fill(testfillvec, 4):[[0, 1, 2, 3, 4, 5], [0, 1, 2, 3, 4, 5], [0, 1, 2, 3, 4, 5], [0, 1, 2, 3, 4, 5]]"
*/


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// Vector Manipulation 20150210
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150222 Given two unidimensional vectors, 'v0' and 'v1', create 'w' in one dimension corresponding to [ [v0_0, v1_0], [v0_1, v1_1],  [v0_2, v1_2] ]
function points_from_vecs(v0, v1, ww=[], index=0) = (index<len(v0)) ? points_from_vecs(v0,v1, concat(ww, [[v0[index],v1[index]]]), index+1)
                                                                    : ww;

/*
//USAGE EXAMPLE 20150222
testv0 = [1,2,3,4,5];
testv1 = [6,7,8,9,10];
echo(str("testv0: ", testv0, ", testv1: ", testv1, ", points_from_vecs(testv0, testv1):", points_from_vecs(testv0, testv1) )); //20150522 ECHO: "testv0: [1, 2, 3, 4, 5], testv1: [6, 7, 8, 9, 10], points_from_vecs(testv0, testv1):[[1, 6], [2, 7], [3, 8], [4, 9], [5, 10]]"
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150213 Given vector 'vv' in 1 dimensions whose elements are vectors,
//               scalar 's' and
//               dimension target 'dim',
//               return new vvector = [ [ vv0[0], vv0[1], ... , vv0[dim]*s, ..., vv0[n] ], [ vv1[0], vv1[1], ... , vv1[dim]*s, ..., vv1[n] ], ...]]
// change 'dim' parameter to change the dimension of the element sets that gets multiplied

function scalar_dim_mult(vv, s, dim=0, modvv=[], index=0) = (index<len(vv)) ? scalar_dim_mult(vv, s, dim, concat(modvv, [scalar_ele_mult(vv[index],s=s, ele=dim)] ), index+1 )
                                                                            : modvv;
/*
//USAGE EXAMPLE 20150213
testscalvec = [[0,0],[1,1],[2,2],[3,3,3]];
//echo(len(unpackElement(testscalvec,0)));
//echo(len(testscalvec));
echo(str("testscalvec ", testscalvec, " scalar_dim_mult(testscalvec, 3.1): ",scalar_dim_mult(testscalvec, 3.1))); //20150213 ECHO: "testscalvec [[0, 0], [1, 1], [2, 2], [3, 3, 3]] scalar_dim_mult(testscalvec, 2, 1): [[0, 0], [3.1, 1], [6.2, 2], [9.3, 3, 3]]"
testscalvec2 = [[0,0,0],[1,1,1],[2,2,2],[3],[4,4,4]];
echo(str("testscalvec2 ", testscalvec2, " scalar_dim_mult(testscalvec2, 4.2, 1): ",scalar_dim_mult(testscalvec2, 4.2, 1))); //20150213 ECHO: "testscalvec2 [[0, 0, 0], [1, 1, 1], [2, 2, 2], [3], [4, 4, 4]] scalar_dim_mult(testscalvec2, 4.2, 1): [[0, 0, 0], [1, 4.2, 1], [2, 8.4, 2], [3], [4, 16.8, 4]]"
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150213 multiply a single element 'ele' of a 1d vector 'v' by a scalar 's'
// change 'ele' parameter to change which element in the vector gets multiplied
// if given a ele > len(v), this will just return original vector v
function scalar_ele_mult(v, s=1, ele=0, modv=[], index=0) = (index<len(v))? scalar_ele_mult(v,s,ele, concat(modv, (index==ele)? unpackElement(v,index)*s /*we're at the right element and at an index inside the bounds of v so change it w/ concat*/
                                                                                                                              : unpackElement(v,index)), index+1)
                                                                        : modv;//we're beyond the bounds of v, so release the new vector
/*
testscalelevec = [0,1,1,1,1,1,6];
for(n=[0:len(testscalelevec)]){
  echo(str("testscalelevec ", testscalelevec, "scalar_ele_mult(testscalelevec, 2, 1): ",scalar_ele_mult(testscalelevec, 2, n)));
}
*/

/*
20150213 test:
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1): [0, 1, 1, 1, 1, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1): [0, 2, 1, 1, 1, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1): [0, 1, 2, 1, 1, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1): [0, 1, 1, 2, 1, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1): [0, 1, 1, 1, 2, 1, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1): [0, 1, 1, 1, 1, 2, 6]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1): [0, 1, 1, 1, 1, 1, 12]"
ECHO: "testscalelevec [0, 1, 1, 1, 1, 1, 6]scalar_ele_mult(testscalelevec, 2, 1): [0, 1, 1, 1, 1, 1, 6]"
*/
/*
function ff(x) = gg(x)*2;
function gg(x) = x*2;
echo(ff(2));
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150225 given a unidimensional vector 'v', and angle 'theta' and a scalar 'n' < len(v),
//return a vector 'w' whose element n is congruent to corresponding element of v[n] *sin(theta),
//and elements at indices =/= n congruent to v[n]
function sin_dim(v, theta=0, n=0, w=[], index=0) = (index<len(v)) ? sin_dim(v, theta, n, (index==n) ? concat(w, [v[index]*sin(theta)])
                                                                                                    : concat(w, [v[index]]), index+1)
                                                                  : w;
/*
//20150225 test:
sin_dim_test_vec=[101, 202, 303, 1.165];
echo(str("sin_dim_test_vec: ", sin_dim_test_vec, "sin_dim(sin_dim_test_vec, 45, 2): ", sin_dim(sin_dim_test_vec, 45, 2))); //20150225 ECHO: "sin_dim_test_vec: [101, 202, 303, 1.165]sin_dim(sin_dim_test_vec, 45, 2): [101, 202, 214.253, 1.165]"
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150210 return the value in vector 'v' whose index corresponds to len(v) - 'n+1', so 0 neg index is the last value in a vector
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
//20150211 return a vector the same as input 'v' but with values from 'index' to len(v)-index in reverse sequence...sweep through half of the values,
//concatenating reversed first and last values of center-index-aligned subsets of original vector set
//like a tasty sandwich with a filler of the next smallest set of the same
//20150213 updated for multidimensional arrays using unpackElement(v,n)
function reverse(v, index=0, subv=[]) = (index < (len(v)/2-1)) ? concat( (index==0)?unpackElement(firstLastSwap(v),0) /*CONCAT -> if this is the first element of v, replace it with the last element of v using first-last swap result*/
                                                                                   :unpackElement(firstLastSwap(subv),0) , reverse(v, index+1, (index==0) ? chopEnds(v) /*if not first element of v, use last element of subset, then CONCAT-> reverse subset recursively, using original v on first (index==0) step */
                                                                                                                                                          :chopEnds(subv)) ,  (index==0) ? negInd(firstLastSwap(v),0) /*use original on first step */
                                                                                                                                                                                         : negInd(firstLastSwap(subv),0) )/*use subset on successive steps*/
                                                               : firstLastSwap(subv) /*on the last step, we've gotten to the middle of the original vector's length, so we just swap the remaining 1 or 2 elements*/;


///////////////////////////////////////////////////////////////////
//20150226 Given a unidimensional vector 'v' with vector elements, return new vector 'w'
//whose vector elements are congruent to the reverse-ordered result of the corresponding
//element in the original v
function reverseElem(v, index=0, w=[]) = (index<len(v)) ? reverseElem(v, index+1, concat(w, [reverse(unpackElement(v, index)[0])]))
                                                     : w;

/*
reverse_ele_vec=[[0,1,2],[1,2,3],[2,3,4],[3,4,5],[4,5,6,7]];
echo(unpackElement(reverse_ele_vec, 1));
echo(str("reverse_ele_vec = ",reverse_ele_vec, "reverseElem(reverse_ele_vec) ->", reverseElem(reverse_ele_vec)));
//^ 20150226 ECHO: "reverse_ele_vec = [[0, 1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6, 7]]reverseElem(reverse_ele_vec) ->[[2, 1, 0], [3, 2, 1], [4, 3, 2], [5, 4, 3], [7, 6, 5, 4]]"
*/

/*
//USAGE EXAMPLE 20150211 retested 20150213 with unpackElement(v, n)
testRevVec = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]; //even dimensionality
echo(str( "test vector: ", testRevVec, " --> reverse(testRevVec): ", reverse(testRevVec) )); //20150211 ECHO: "test vector: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] --> reverse(testRevVec): [19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]"
testRevVec2 = [2,4,6,8,120,20];
echo(str("does double reverse of test vector result in original? i.e. testRevVec2 == reverse(reverse(testRevVec2)))) = ",testRevVec2 == reverse(reverse(testRevVec2)))); //20150211 ECHO: "true"
testRevVec3 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]; // odd dimensionality
echo(str( "test vector: ", testRevVec3, " --> reverse(testRevVec3): ", reverse(testRevVec3) )); //20150211 ECHO: "test vector: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] --> reverse(testRevVec): [19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]"

*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150211 return a vector composed of the original input vector 'v' concatenated with a vector corresponding to v reversed (reverse(v))
function reflectvec(v) = concat(v, reverse(v));

/*
//USAGE EXAMPLE 20150211
testReflectVec= [0,1,2,3,4,5,6];
echo(str( "test vector: ", testReflectVec, " --> refletvec(testRefletvecVec): ", reflectvec(testReflectVec) )); //20150211 ECHO: "test vector: [0, 1, 2, 3, 4, 5, 6] --> refletvec(testRefletvecVec): [0, 1, 2, 3, 4, 5, 6, 6, 5, 4, 3, 2, 1, 0]"
*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150222 return a vector corresponding to the original input vector 'vv' concatenated with reverse of vv times scalar multiplier
function reflectvec_scalar_dim_mult(vv, s, dim) = concat(vv, reverse(scalar_dim_mult(vv,s,dim)) );

/*
//USAGE EXAMPLE 20150211
testReflectVecscalarmult= [[0,0], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6]];
//echo(str( "test vector: ", testReflectVecscalarmult, " --> reflectvec_scalar_dim_mult(testReflectVecscalarmult, -2, 0): ", reflectvec_scalar_dim_mult(testReflectVecscalarmult, -2, 0) )); //20150222 CHO: "test vector: [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]] --> reflectvec_scalar_dim_mult(testReflectVecscalarmult, -2, 0): [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [-12, 6], [-10, 5], [-8, 4], [-6, 3], [-4, 2], [-2, 1], [0, 0]]"
*/


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150211 return a vector corresponding to values of 'v' in original sequence except for the omission of values at index 0 and len(v)-1 (the first and last)
//20150212 does not work with multidimensional vector
//20150313 updated to work with multidimensional vector using unpackElement(v,n)
function chopEnds(v, modv=[], index=1) = (len(v)<3) ? "ERROR  chopEnds(v, modv=[], index=1) : vector parameter 'v' should contain at least three items, i.e. len(v)>=3"
                                                    : (index<len(v)-1) ? chopEnds(v, concat(modv, unpackElement(v,index)), index+1)
                                                                       : modv;

/*
//USAGE EXAMPLE 20150211 Retested 20150213 with unpackElement(v,n)
testChopVec = [0,1];
echo(str( "test vector: ", testChopVec, " --> chopEnds(testChopVec): ", chopEnds(testChopVec)));   //20150211 ECHO: "test vector: [0, 1] --> chopEnds(testChopVec): ERROR  chopEnds(v, modv=[], index=1) : vector parameter 'v' should contain at least three items, i.e. len(v)>=3"
testChopVec2 = [0,1,1];
echo(str( "test vector: ", testChopVec2, " --> chopEnds(testChopVec2): ", chopEnds(testChopVec2)));   //20150211 ECHO: "test vector: [0, 1, 1] --> chopEnds(testChopVec2): [1]"
testChopVec3 = [0,1,1,2,3,5];
echo(str( "test vector: ", testChopVec3, " --> chopEnds(testChopVec3): ", chopEnds(testChopVec3)));   //20150211 ECHO: "test vector: [0, 1, 1, 2, 3, 5] --> chopEnds(testChopVec3): [1, 1, 2, 3]"
*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//20150211 return vector with swapped first and last values....IF THERE ARE LESS THAN TWO values in 'v' then return v, else pick the first value, replace it with the last value, sweep through all values and place the original first value last
//20150513 updated to work with vector that might have 2d  elements using unpackElement
function firstLastSwap(v, modv=[], index=0, first="") = (len(v)<=1) ? v
                                                                    : (index<(len(v)-1)) ? firstLastSwap(v, concat(modv, (index==0) ? negInd(v,0)
                                                                                                                                    :  unpackElement(v,index)), index+1, (index==0) ? unpackElement(v,index)
                                                                                                                                                                                    : first)
                                                                                         : concat(modv, first);
/*
//USAGE EXAMPLE 20150211 Retested 20150213 with unpackElement(v, n)
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
//20151213 can we unpack a multidimensional array element without losing its internal brackets?
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
// Element Manipulation 20150225
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// 20150225  This is a TEMPLATE function, which means you should copypasta it
//           and redefine as needed. For this to work properly, please be certain
//           to be careful with what you name the copies so you avoid conflicts
//           When using with a vector comprised of vector elements, take care to
//           adapt the function called by the template appropriately
//
//           REMEMBER TO CHANGE the funcTemplate name in BOTH PLACES and to change the
//                              func name in BOTH PLACES
//           You can also inline the func within the funcTemplate
//
//Given a unidimensional vector 'v', a scalar 'n' within the indices of v,
// and a SEPARATELY DEFINED function 'func', return a vector 'w' whose elements
// satisfy the following: w[m] = func(v[m]),  m=n
//                        w[m] = v[m],        m=/=n
//
//

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

//function rot_ij(element, angle) = element *

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///Fibonacci Sequence 20150208
///////////////////////////////////////////////////////////////////
function f(ab,n) = (n>1) ? f(concat(ab, sumfinalpair(ab)), n-1 )
                         : concat(ab, sumfinalpair(ab)); // additive fibonacci sequence: given an m-dimensional vector "ab", return an extension of ab into "n" additional dimensions using values satisfying the rule ( _ = subscript): x_{n} = x_{n-1} + x_{n-2}
function sumfinalpair(v) = len(v)>=2 ? negInd(v,0) + negInd(v,1)
                                     : "ERROR sumfinalpair(v) : vector parameter 'v' must contain at least two items"; //return sum of last two values of a vector "v"
/*
//USAGE EXAMPLE - 20150209
result = f([1.1,2],17);
echo(result);
*/

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//Generate Degenerate (Rectangular) Spiral
//function f_corners(radii, n=0, corners=[], rotation=90) = (n < len(radii)) ? f_corners(radii, ++n, concat(corners, [[ radii[n]*cos(rotation*(n-2)), radii[n]*sin(rotation*(n-2)) ]] ), rotation) : corners;
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
















//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////   bad shit    ////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
/////////////////////////   Mark Ye Well, O' Most Adored Sun in My Skies,
                          Moon Betwixt My Firmaments,
                        Lightfooted Love of My Long Lost Lagrange Loci,
                        for Here Follows a Veritable Litany of Misdeed:
*/



/*
///////////////////////////////////////////////////////////////////
//20150225 given a unidimensional vector 'v' and a unidimensional PARAMETERIZED function 'func'
//return a vector 'w' whose nth elements correspond to w[n] = func[n](v[n])
// EDIT because OpenSCAD vector elements are only numerical,
// this does not function with a parameterized function vector as intended
// REVISE TO: given a unidimensional vector 'v' a function 'func' and an index
//'n' within the indices of v, return a vector 'w' whose element w[n] congruent to func(v[n])
//and whose elements w[=/=n] congruent to v[n]
//function dummyfunc(v)
//EDIT This doesn't work either, as it seems OpenSCAD can't pass a function as a function parameter :(
function func_dim(v, func, n, w=[], index=0) = (index<len(v)) ? func_dim(v, func, n, concat(w, (index==n) ? func(v[index])
                                                                                                          : v[index]), index+1)
                                                              : w;

///20150225 usage test:
test_func_dim_vec=[1,2,3,4];
function ff(x) = x/.618;
echo(len(test_func_dim_vec));
echo(str("test_func_dim_vec = ", test_func_dim_vec), "func_dim(test_func_dim_vec, ff, 3) = ", func_dim(test_func_dim_vec, ff(), n=0));
*/


//function rot_ij(v, theta=40, index=0, w=[]) = unp;
//echo(str("rot_ij(template_test_vec2[1])", rot_ij(template_test_vec2[1]) ));
//^20150225 ECHO: "rot_ij(template_test_vec2[1])[0.766044, 0.642788, 0]"


//function f(ab,n) = concat(ab, ab[1]);
//function f(ab,n) = (n>1) ? ab+ f(ab,n-1) : ab;
//echo([5,6]+[0,0,4]); //ECHO: [0,5]  doesnt work: result size defined by first operand
//echo([5,6]+[0,4,0]); //same as above: ECHO:
//echo(([5,6,[5]));
//echo(len([1,2,2]) );

////= len(radii) > 2 ? concat : "ERROR f_corners(radii) : vector 'radii' must contain at least two items"; //return corners of a degenerate spiral


//(len(vv)==undef) ? str("scalar_dim_mult(vv, s, dim, modv, index): vv should be a vector") /*is vv a vector*/
//                                                                                                                           : ( (len(unpackElement(vv,index))==undef) || (len(unpackElement(vv,index))<dim)) ? str("scalar_dim_mult(vv,s,dim, modv, index) vv should have elements that are vectors whose lengths are at least dim") /*make sure there are enough elements in the current element of v*/
//                                                                                                                                                                                                            : concat(modvv, (index<len(vv)) ? scalar_ele_mult(unpackElement(vv,index), s, dim) /*we know the element is long enough, do CONCAT operations based on index*/
//                                                                                                                                                                                                                                            : "w")
