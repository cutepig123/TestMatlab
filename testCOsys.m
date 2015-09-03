function testCOsys
testCOsys2()

function testCOsys2
sys1.rcoCenter=[50;50];
sys1.rOrientation=0;
sys2.rcoCenter=[150;150];
sys2.rOrientation=0;

trans=DS_SetTransPar(sys1, sys2);
pd=DS_TransformPt([100;100], trans)

function testCOsys1
sys1.rcoCenter=[100;200];
sys1.rOrientation=90;
sys2.rcoCenter=[100;200];
sys2.rOrientation=0;

trans=DS_SetTransPar(sys1, sys2);
pd=DS_TransformPt([0;0], trans)

function ori=DS_GetSysOrient(sys)
ori=sys.rOrientation;

function ori=DS_GetSysOrigin(sys)
ori=sys.rcoCenter;

function trans=DS_SetTransPar(sys1, sys2)
rcoSCenter=DS_GetSysOrigin(sys1);
rcoDCenter=DS_GetSysOrigin(sys2);

rSOrient=DS_GetSysOrient(sys1 );
rDOrient=DS_GetSysOrient(sys2);
    
trans.rcoRefPt = rcoSCenter;
trans.rRotate  = rDOrient - rSOrient;
trans.rcoTranslate =rcoDCenter-rcoSCenter;

function pd=DS_RotPt(pt, rRotation)
RAD_PER_DEGREE=pi/180;
m_rCosTheta =cos( rRotation * RAD_PER_DEGREE );
m_rSinTheta =sin( rRotation * RAD_PER_DEGREE );
pd= [pt(1) * m_rCosTheta - pt(2)  * m_rSinTheta;
 pt(2)* m_rCosTheta + pt(1)  * m_rSinTheta];

function pd=DS_TransformPt(pt, Para)
pd =DS_RotPt(pt-Para.rcoRefPt, Para.rRotate) +Para.rcoTranslate + Para.rcoRefPt;