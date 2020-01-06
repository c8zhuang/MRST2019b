function [Xq, w, V, vol] = tetrahedronQuadRule_upr(k)
%   Returns quadrature rule for the reference terahedron with vertices V.
%
%   SYNOPSIS:
%       [Xq, w, V, vol] = polyhedronQuadRule(k)
%
%   DESCRIPTION:
%       Returns quadrature rule of precission k, as described in [1]. Usage
%       of the rule is as follows:
%
%           \int_T f \dx = vol\sum_{i = 1}^n w_i*f(Xq_i),
%
%       where T is the reference terahedron with vertices V, f is the
%       funtion to be integrated, vol is the area of T, and w_i and Xq_i is
%       the ith wheight and quadrature point, respectively.
%
%   REQUIRED PARAMETERS:
%       k       - Quadrature rule precision. supported values precisions
%                 are 2,3 and 7.
%
%   RETURNS:
%       Xq      - nq x 3 matrix of quadrature points.
%       w       - nq x 1 vector of quadrature wheights.
%       V       -  4 x 3 matrix of reference tirangle vertices.
%       vol     - Area of reference triangel.
% 
%   REFERENCES:
%       [1]     - http://people.sc.fsu.edu/~jburkardt/m_src/...
%                          tetrahedron_arbq_rule/tetrahedron_arbq_rule.html
%-----------------------------------------------------------------ØSK-2016-

%{
   Copyright (C) 2016 Øystein Strengehagen Klemetsdal. See COPYRIGHT.txt
   for details.
%}


assert( k == 2 | k == 3 | k == 7, ...
       'Only supported quadrature precissions are 2, 3 and 7');

V  = [-1.0, -1.0/sqrt(3.0), -1.0/sqrt(6.0); ...
       0.0,  2.0/sqrt(3.0), -1.0/sqrt(6.0); ...
       1.0, -1.0/sqrt(3.0), -1.0/sqrt(6.0); ...
       0.0,  0.0          ,  3.0/sqrt(6.0)];   

vol = sqrt(sqrt(8.0)/3.0);
    
if k == 2

    xs = [ ...
          -.2677028585910073    , .1510931841533142    , ...
          -.1367699195237390    , .8067449309051964         ];
    ys = [ ...
           .5939017006199488E-01, .4354087732476309    , ...
          -.3280341115590410    ,-.3400977314285288         ];
    zs = [ ...
          -.3969426941142150    , .2151719254306919    , ...
           .2950846519937133    ,-.3430378951002550         ];

    Xq = [xs(:), ys(:), zs(:)];
       
    w  = [ .2918008865477151    , .2706884392356724    , ...
           .3098349601753470    , .9865925745591227E-01     ];
       
elseif k == 3

    xs = [ ...
          -.1685037180276000    , .2783799427534418E-01, ...
          -.3512216177343445    , .4308532463549043    , ...
          -.4676763747967377    , .1492831253848431         ];
    ys = [ ...
           .1910914916271708    ,-.2304932838839657E-01, ...
           .1835144026339993    ,-.2474715823180446    , ...
          -.4235250827264375    , .6397847685164516         ];
    zs = [ ...
          -.3896267314585163    ,0.5481350663241830    , ...
           .5147815330343534E-01,-.1683315641007033    , ...
          -.1586973077889307    ,-.1080219253055393         ];
    
    Xq = [xs(:), ys(:), zs(:)];

    w  = [ ...
           .1287213727402025    , .2179034339695993    , ...
           .1243503792062836    , .2446917182410072    , ...
           .1365439875826512    , .1187726516749031         ];
       
elseif k == 7
    
    xs = [ ...
    -.3082522913562920,0.3230068564765168, ...
    0.1790030943099486E-02,-.1749858562850217, ...
    0.3515818224512229E-01,-.1148912802505062, ...
    0.1080242619580473,0.9960886019209524E-01, ...
    0.2552589657173040,0.3018972093964544, ...
    -.3637995251662868E-01,-.1979748432674351, ...
    0.1705547608587194,0.5382714575357732, ...
    -.5826255951559661,-.6638827484255140E-01, ...
    0.1394865450483365,-.2525448211561483, ...
    -.3364179479356783,0.5088174095091343, ...
    -.3997676771299581,0.2233579208997628, ...
    -.2887689832327979,0.2430056805988458, ...
    -.2402459184668794,-.5737122495168941, ...
    0.5530740586345179,0.7632160871540358, ...
    0.1108323525316276E-02,-.7666589725519221, ...
    0.3314379268437029 ];
    ys = [ ...
    -.1978432879678884,-.1166608144800289, ...
    0.2760223041671345E-02,0.1492553071272583, ...
    0.3222570009831960,0.3598150246997987E-01, ...
    -.2123211082745265,0.3370600346165786, ...
    0.2345931387652712E-01,-.2797440812728529, ...
    0.6784158147792628,-.1099260120706853, ...
    0.5854481149716676E-01,-.3326202438156060, ...
    -.2866394288669600,0.3396643732745171, ...
    -.3078502318368667,-.9687707852320762E-01, ...
    -.4222809305623556,-.4607960014652947E-01, ...
    0.1694117934001565,0.5070263922318456, ...
    -.4320411612241725,0.5262155488082486, ...
    0.4919239659783042,-.7453182334351910E-01, ...
    -.3355026530466742E-02,-.4345394288375978, ...
    0.8835815093231754,-.4540327424996255, ...
    -.5419034033722774 ];
    zs = [ ...
    0.6553771405341420,0.5963217268212818, ...
    0.9191670342435462,0.5162921387398244, ...
    0.5492103599470217,-.3886917653966460, ...
    0.5138214657068572,-.2732502226402171, ...
    -.1289266426427488,-.3368155028155599, ...
    0.4965154590499942E-01,0.3688101367310880, ...
    0.3245398450336227,0.6530998463389483E-01, ...
    0.4050073689194288E-01,0.4339137621154699E-01, ...
    -.8554188228126980E-02,-.1212234343128167, ...
    0.2244936992133664E-01,-.5389155149780182E-01, ...
    -.1331769110761944E-01,-.3996173060097081E-01, ...
    -.3304370757138854,-.3633697548034391, ...
    -.3184670075538235,-.3348000741414298, ...
    -.3507444035401421,-.3120479891575616, ...
    -.3155336884007630,-.3148702231578014, ...
    -.3104410268762152 ];

    Xq = [xs(:), ys(:), zs(:)];

    w = [ ...
    0.7484517057961263E-02,0.1165548467333077E-01, ...
    0.2254313978794985E-01,0.2176106698437745E-01, ...
    0.2261516504544270E-01,0.2653689704536702E-01, ...
    0.2796071748247393E-01,0.4174371077929897E-01, ...
    0.5125012874361469E-01,0.4062452567161350E-01, ...
    0.2011109093086575E-01,0.5855177928202636E-01, ...
    0.6477548431925077E-01,0.3049968783939012E-01, ...
    0.2749125083938057E-01,0.6480294592357103E-01, ...
    0.6232630627722486E-01,0.7994900688083093E-01, ...
    0.2026705321864424E-01,0.2384971520555609E-01, ...
    0.2170019222676944E-01,0.2153672490681497E-01, ...
    0.3586406280991152E-01,0.1621736817489311E-01, ...
    0.3281522904442925E-01,0.2724694235165297E-01, ...
    0.2048072851756261E-01,0.1999288967511468E-01, ...
    0.1864561424137827E-01,0.1753312507928042E-01, ...
    0.1215099239866789E-01 ];

end
