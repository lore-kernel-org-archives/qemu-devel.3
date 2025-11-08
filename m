Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22950CCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 19:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHoka-0003Y6-R4; Sat, 08 Nov 2025 14:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vHokY-0003XM-B9; Sat, 08 Nov 2025 14:37:26 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vHokU-0005Hb-L2; Sat, 08 Nov 2025 14:37:24 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E4C38597306;
 Sat, 08 Nov 2025 20:37:19 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id buoBWsD7YWdI; Sat,  8 Nov 2025 20:37:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DADA9597302; Sat, 08 Nov 2025 20:37:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] pc-bios/dtb/pegasos*.dtb: Fix compiled dtb blobs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yogesh Vyas <yvyas1991@gmail.com>
Message-Id: <20251108193717.DADA9597302@zero.eik.bme.hu>
Date: Sat, 08 Nov 2025 20:37:17 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When adding these files somehow an incomplete version was committed.
Regenerate and update these dtb files to match the dts which fixes
problems caused by missing nodes in the dtb.

Fixes: 9099b430a4 (hw/ppc/pegasos2: Change device tree generation)
Fixes: 3c21f9dfcf (hw/ppc/pegasos2: Add VOF support for pegasos1)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: updated commit message to mention the two commits fixed here

 pc-bios/dtb/pegasos1.dtb | Bin 857 -> 1975 bytes
 pc-bios/dtb/pegasos2.dtb | Bin 1701 -> 2963 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/pc-bios/dtb/pegasos1.dtb b/pc-bios/dtb/pegasos1.dtb
index 3b863b25288a59bcede9459ff42afad713dde741..b776861602055ed068cac103ad8b2e9faad1e6e5 100644
GIT binary patch
literal 1975
zcmZuyO=}ZD7@lplwWzFuUaE&kE=9W9q^(VFE48#BXiz-$&~A1o>5~1*%%&xRwE8<d
z2%bHA@!}5<Jo*Pb3O#sG(Bk{d&Lr!$FT6AF^US<oGn38NtEWF0oBhZbYcVzx(Y!!<
zo%9+hiS?NHmBRjSv^1Kg`GU5=0beAw{e6*X9^56;TW#L+WGX>}gWhR81XT8An(ub9
z$V+Nlac6tX!*{*ndz-i|&DA!xpS5f4^pK18M(z1X<~)Y8m1aE2M5+K`<U?Pkj>V;W
zjZUMvOca|Uwfy~5@&vHJF^^L*a+efS_|KAU7rbIkZ##MqrXp50RE-kG9-PrGDa2sd
z=FG6(*I4;?y)cqqmtzwNd{l19Md;zCbe_x)-PTeeik-x_X$@34A8dnB4{{kiu>QPz
zQNpiJPY4z3xPzTz8jeUw;DZ}_YaRl~Qw)&fBCs|AmAs-62_b*A!qzbm6M5c)(_)3v
zbJq%B>ij@YbcQH{>HWTGl<;S=anEM`3!70H4F1O0{Lj+*_u|Q`{WplGyQH7PSuy@L
z)r3`pVVBPl=Zb`8{Wms{7(8G{3pXd&!reox;%?or*;V<mzk283u8`urQI4r!G~>*`
z(`?z=rm2(<sHo9uEv+=&@Im=aqgMDqD)HGKarixhN1X#w2r&6s^9oJY0n5GPEFjw7
zx=%LF3TpNFsFQjksMIq@YqnV<8v_4Q-)xVtsmt_@ybu*z<h~oOsWx?PW)p|?YOGBA
zfH$#lrV!&>?wh_-mK(^%a%<JmA&Z=O7<1u<EBbKZi+5@(9?{O`c8No-Y97@?H=rJt
zyXCvW9oWRvRPAH>gg6t+^nv`4bK^%@PVqY`SZR+<yzwcW`Sd3utMTzZA?L+6_l$Y2
z?gfG1QaV15BFO@N5c+&KA7z}yX}}{Uh>>BMu#KmWHn%pPEFSPANW~bcmoi2Hm%a$I
z91eo_SY3uMxsF};@$L1a)bBf8!3RU0_#@V8uC6;_l5-)3S?+j#KS>WG9`ra9Uee=|
zb%xSWCM!}qVW8`TW$J_NM;<z%x|tkyr25AJKLL{noW2&0jM7{(j85Xklxti_$)tcu
XF48FCg4M?xbW?sBXI>t5BF_E++M@cs

delta 53
zcmdnaf0Iq)0`I@K3=GVX3=9kw3=B+bfV2h>3j(nK5QD&4pm@nfjcTUJ$!yyIEp7@-

diff --git a/pc-bios/dtb/pegasos2.dtb b/pc-bios/dtb/pegasos2.dtb
index 29c35216ec2d77e4083a3ef618ca185925fb5d61..a6935a8c23d85e0251e7f424cf59c8fe54fe593a 100644
GIT binary patch
literal 2963
zcmb_ezmFU>6!z>v$dN?L@k2t8V$o5A=my<Sa;aDmP8X#JClI1Yk$64c-Qi|uCid)I
z79<E%bSY?&prW8dqNGS9{s0g)5*?yIA`%6WAmaNx_U_z5l!hmH=6%o4?|b&MJ@fsk
z`@acs;!`2Swh)WY;(Z2f3GE3qNb7wej{oe`qmRhL1-u{eI&H*{qP5k~l-^F;BHHtN
zdLV6K*Bf^By|Dh8vrs>QcD7e$GVkn;dKag5jz9k&<4?oB>+PKj7vJ3L>=lRF>|N-*
zHL;Z*F+fz5IxkJ(05Ew@p-uByS$la6n9@Rv)UdERpW%@n6=u?1b(VVkW6;~R-B}s)
zINBA5>PH=`99wUr57+AI93~8F$Nqhf-FQ>U`SI81{67GG8ZE^C1Ue<)&uTcuU(ez1
z=I{@|&3t|WW-cM#uU-%M9x(IvIAX1iH86AIdWHTMp>wSQ-h|FE0q;P6yn)|=&V3R3
zHT0zhE}%czz=zPEYT%EcGY7YxeVJxf_8Ei1n68#qn^b1b=KM;PcDGk+an>onXrqrN
zpO5RM9x&_MSg+_-^w$?}`+n@9=yNV^ko!S_k%K5VeWTvxV;Vd9@~$}fjmK`k-2~{O
zK|FtSr-ly0C;HK2zM|C1uBr{eAN5^o*6SA`K3;=M=)Vh{_d&pai(_sE9=E{p+#j?4
z)-!c^oIlqcXW|-O{}Ml5w2>1#1E$_sKX+b882DbI1H|L#miX`tI0J5Nx?aq+u4y-2
z@8f!_`{!%T7$?zqZo$#|6YsD$@ov2eOdraO?{p_%?90}rGB5Wo@2zaDa@FeGqwUqr
z^=|q~^UmNL+Rmen)!-G^VCTI#<ER~paTZ#ac%QB?=*-T1xvwaGoYNa?HGkK%-h~I(
zmMz-XlU^ZBGM6XMVmtIfr!fA5@(t@mUJ8Ai>$0)B;p~pnRH~bvbITHPZo?MFH91Nc
z!#)TctPRDFMeS>uawc|dV|y$1A?tZo=}4Pyy6KBSU+(v|v(Lsixw|lv>w!GJ=4-2U
zP&c=Jg1K$<Jxv%Z+OU&_u^Jo;zXJ!3FhAx+c^L1xCT~_&;O#k**;vtrJ;ZAAehcF~
zFV6+#VZ56SUe4Lgn|G!9pYF<qd)=>m9$3etcO?&}6YhMk-o~4a(s55W2hQ)xZ9F<?
zkT9=1&@npr9Jw3Ad={5wk{E4mtaO%Hk?4a|>8sVG)M8X5IuiyKn-;ma@W$&qyE~Ux
z4s@OrW(wV@nxaHoWzw?Z0HX(D*{1JlAA4Ex|9~I)_&^&M(*e5F<|MWF9h$^-7PU=-
zuZpdbd2D3m9knrqiL+u5kK_#y*-DxU2Lb;N`GJw6xUVZU^t!DIqs2g1F%Lmp^y5TM
zgq_1P9-)R>?Z^6tR$(GCiBb4i6?s1$h(nWBx@ib`tD!VfRob}dX`ZA?f?SmRPXlpZ
z*s;YAS|WyNPn(?cvF_h3Ho8|7l~7p$>b}v}$2wONVPrngR&1|tosZKTk<GZQVyX7?
z;xN<6Knv#8Gbz+KACC}K^u`uTg>j-TRh%ZiuGB(3sjEz~@~ATs>-kJzpMhBfjW1Vh
nv!b$s&p4MOBsR^-3RR3sS*5*9&#YXr$`o0Kw3es7en0#J=mwZO

delta 54
zcmbO%zLZzv0`I@K3=C{b85kHW7#LVi0BH>%76f7eAO-@)yFl>?8#PWdZ+7O`!~_68
C$qNtw

-- 
2.41.3


