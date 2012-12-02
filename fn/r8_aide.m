function value = r8_aide ( x )

%*****************************************************************************80
%
%% R8_AIDE: exponentially scaled derivative, Airy function Ai of an R8 argument.
%
%  Discussion:
%
%    if X <= 0,
%      R8_AIDE ( X ) = R8_AID ( X )
%    else
%      R8_AIDE ( X ) = R8_AID ( X ) * exp ( 2/3 * X^(3/2) )
%
%    Thanks to Aleksandra Piper for pointing out a correction involving 
%    the computation of Z in the last two cases, 02 February 2012.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 February 2012
%
%  Author:
%
%    Original FORTRAN77 version by Wayne Fullerton.
%    MATLAB version by John Burkardt.
%
%  Reference:
%
%    Wayne Fullerton,
%    Portable Special Function Routines,
%    in Portability of Numerical Software,
%    edited by Wayne Cowell,
%    Lecture Notes in Computer Science, Volume 57,
%    Springer 1977,
%    ISBN: 978-3-540-08446-4,
%    LC: QA297.W65.
%
%  Parameters:
%
%    Input, real X, the argument.
%
%    Output, real VALUE, the exponentially scaled derivative of
%    the Airy function Ai of X.
%
  persistent aifcs
  persistent aigcs
  persistent aip1cs
  persistent aip2cs
  persistent naif
  persistent naig
  persistent naip1
  persistent naip2
  persistent x2sml
  persistent x32sml
  persistent x3sml
  persistent xbig

  if ( isempty ( naif ) )
    aifcs = [ ...
       0.105274612265314088088970057325134114, ...
        0.011836136281529978442889292583980840, ...
        0.000123281041732256643051689242469164, ...
        0.000000622612256381399016825658693579, ...
        0.000000001852988878441452950548140821, ...
        0.000000000003633288725904357915995625, ...
        0.000000000000005046217040440664768330, ...
        0.000000000000000005223816555471480985, ...
        0.000000000000000000004185745090748989, ...
        0.000000000000000000000002672887324883, ...
        0.000000000000000000000000001392128006, ...
        0.000000000000000000000000000000602653, ...
        0.000000000000000000000000000000000220 ]';
    aigcs = [ ...
        0.0212338781509186668523122276848937, ...
        0.0863159303352144067524942809461604, ...
        0.0017975947203832313578033963225230, ...
        0.0000142654998755506932526620687495, ...
        0.0000000594379952836832010488787064, ...
        0.0000000001524033664794478945214786, ...
        0.0000000000002645876603490435305100, ...
        0.0000000000000003315624296815020591, ...
        0.0000000000000000003139789757594792, ...
        0.0000000000000000000002325767379040, ...
        0.0000000000000000000000001384384231, ...
        0.0000000000000000000000000000676629, ...
        0.0000000000000000000000000000000276 ]';
    aip1cs = [ ...
       0.0358865097808301537956710489261688, ...
       0.0114668575627764898572700883121766, ...
      -0.0007592073583861400301335647601603, ...
       0.0000869517610893841271948619434021, ...
      -0.0000128237294298591691789607600486, ...
       0.0000022062695681038336934376250420, ...
      -0.0000004222295185920749486945988432, ...
       0.0000000874686415726348479356130376, ...
      -0.0000000192773588418365388625693417, ...
       0.0000000044668460054492719699777137, ...
      -0.0000000010790108051948168015747466, ...
       0.0000000002700029446696248083071434, ...
      -0.0000000000696480108007915257318929, ...
       0.0000000000184489907003246687076806, ...
      -0.0000000000050027817358071698301149, ...
       0.0000000000013852243366012168297298, ...
      -0.0000000000003908218466657048253473, ...
       0.0000000000001121536072524563451273, ...
      -0.0000000000000326861522579502522443, ...
       0.0000000000000096619179010090805752, ...
      -0.0000000000000028934767442698434271, ...
       0.0000000000000008770086661150897069, ...
      -0.0000000000000002688046261195853754, ...
       0.0000000000000000832498823872342992, ...
      -0.0000000000000000260343254786947057, ...
       0.0000000000000000082159528142686287, ...
      -0.0000000000000000026150406704984940, ...
       0.0000000000000000008390563463261051, ...
      -0.0000000000000000002712685618629660, ...
       0.0000000000000000000883333375271942, ...
      -0.0000000000000000000289603206822333, ...
       0.0000000000000000000095562185928676, ...
      -0.0000000000000000000031727463569051, ...
       0.0000000000000000000010595576960768, ...
      -0.0000000000000000000003558253765402, ...
       0.0000000000000000000001201334680517, ...
      -0.0000000000000000000000407666883800, ...
       0.0000000000000000000000139016944446, ...
      -0.0000000000000000000000047628165730, ...
       0.0000000000000000000000016391265551, ...
      -0.0000000000000000000000005665491354, ...
       0.0000000000000000000000001966381969, ...
      -0.0000000000000000000000000685230229, ...
       0.0000000000000000000000000239706939, ...
      -0.0000000000000000000000000084166831, ...
       0.0000000000000000000000000029659364, ...
      -0.0000000000000000000000000010487947, ...
       0.0000000000000000000000000003721150, ...
      -0.0000000000000000000000000001324570, ...
       0.0000000000000000000000000000472976, ...
      -0.0000000000000000000000000000169405, ...
       0.0000000000000000000000000000060855, ...
      -0.0000000000000000000000000000021924, ...
       0.0000000000000000000000000000007920, ...
      -0.0000000000000000000000000000002869, ...
       0.0000000000000000000000000000001042, ...
      -0.0000000000000000000000000000000379 ]';
    aip2cs = [ ...
       0.0065457691989713756794276979067064, ...
       0.0023833724120774591992772552886923, ...
      -0.0000430700770220585862775012110584, ...
       0.0000015629125858629202330785369063, ...
      -0.0000000815417186162706965112501015, ...
       0.0000000054103738056935918208008783, ...
      -0.0000000004284130882614696528766222, ...
       0.0000000000389497962832286424862198, ...
      -0.0000000000039623161264979257658071, ...
       0.0000000000004428184214405989602353, ...
      -0.0000000000000536296527150689675318, ...
       0.0000000000000069649872139936028200, ...
      -0.0000000000000009619636286095319210, ...
       0.0000000000000001403454967784808032, ...
      -0.0000000000000000215097136525875715, ...
       0.0000000000000000034471230632678283, ...
      -0.0000000000000000005753907621819442, ...
       0.0000000000000000000997001165824168, ...
      -0.0000000000000000000178811436021458, ...
       0.0000000000000000000033110307923551, ...
      -0.0000000000000000000006315885529506, ...
       0.0000000000000000000001238666952364, ...
      -0.0000000000000000000000249324053394, ...
       0.0000000000000000000000051426030999, ...
      -0.0000000000000000000000010854236402, ...
       0.0000000000000000000000002341316852, ...
      -0.0000000000000000000000000515542099, ...
       0.0000000000000000000000000115758841, ...
      -0.0000000000000000000000000026479669, ...
       0.0000000000000000000000000006165328, ...
      -0.0000000000000000000000000001459931, ...
       0.0000000000000000000000000000351331, ...
      -0.0000000000000000000000000000085863, ...
       0.0000000000000000000000000000021297, ...
      -0.0000000000000000000000000000005358, ...
       0.0000000000000000000000000000001367, ...
      -0.0000000000000000000000000000000353 ]';
    eta = 0.1 * r8_mach ( 3 );
    naif = r8_inits ( aifcs, 13, eta );
    naig = r8_inits ( aigcs, 13, eta );
    naip1 = r8_inits ( aip1cs, 57, eta );
    naip2 = r8_inits ( aip2cs, 37, eta );
    x2sml = sqrt ( eta );
    x3sml = eta^0.3333;
    x32sml = 1.3104 * x3sml * x3sml;
    xbig = r8_mach ( 2 )^0.6666;
  end

  if ( x < - 1.0 )
    [ xn, phi ] = r8_admp ( x );
    value = xn * cos ( phi );
  elseif ( abs ( x ) < x2sml )
    x2 = 0.0;
    x3 = 0.0;
    value = ( x2 * ( 0.125 + r8_csevl ( x3, aifcs, naif ) ) ...
      - r8_csevl ( x3, aigcs, naig ) ) - 0.25;
    if ( x32sml < x )
      value = value * exp ( 2.0 * x * sqrt ( x ) / 3.0 );
    end
  elseif ( abs ( x ) < x3sml )
    x2 = x * x;
    x3 = 0.0;
    value = ( x2 * ( 0.125 + r8_csevl ( x3, aifcs, naif ) ) ...
      - r8_csevl ( x3, aigcs, naig ) ) - 0.25;
    if ( x32sml < x )
      value = value * exp ( 2.0 * x * sqrt ( x ) / 3.0 );
    end
  elseif ( x <= 1.0 )
    x2 = x * x;
    x3 = x * x;
    value = ( x2 * ( 0.125 + r8_csevl ( x3, aifcs, naif ) ) ...
      - r8_csevl ( x3, aigcs, naig ) ) - 0.25;
    if ( x32sml < x )
      value = value * exp ( 2.0 * x * sqrt ( x ) / 3.0 );
    end
  elseif ( x <= 4.0 )
    sqrtx = sqrt ( x );
    z = ( 16.0  / ( x * sqrtx ) - 9.0 ) / 7.0;
    value = ( - 0.28125 - r8_csevl ( z, aip1cs, naip1 ) ) * sqrt ( sqrtx );
  elseif ( x < xbig )
    sqrtx = sqrt ( x );
    z = 16.0  / ( x * sqrtx ) - 1.0;
    value = ( - 0.28125 - r8_csevl ( z, aip2cs, naip2 ) ) * sqrt ( sqrtx );
  else
    sqrtx = sqrt ( x );
    z = - 1.0;
    value = ( - 0.28125 - r8_csevl ( z, aip2cs, naip2 ) ) * sqrt ( sqrtx );
  end

  return
end