Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E786C79F94
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 17:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uaP-0005Kq-As; Sat, 05 Sep 2026 13:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaM-0005HT-2k; Sat, 05 Sep 2026 13:53:50 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaJ-0008KO-0S; Sat, 05 Sep 2026 13:53:49 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B1C044798;
 Sat,  5 Sep 2026 17:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96271F00ADB;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788630812;
 bh=Z/gyrlvZHOgQPdhVvahEbxM2gbYFirwvQo092awQNlI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BiNyPbKUYmvyceFDPuwcBNwaZVnC3Eyeagf4IFT2Zu4XQjlMfjGJN0Mvqe6J3uCFW
 Vpp7i5ME6jN844OirwzKFCmroGSKX3wqBuwId+51TFu5wk2Njw1lH2bTfJ3BJ1xxsx
 vYNhOex5AQuchndxJUSOAGbrRd7u6BPQHzWV7tJEniUpsJCaIiFjOEpkS8x6JMG9ta
 BWdKkVYEdQfdJi5qGqeedgu+Oli7m9smmmkWX3f+MNdgGzx7TaTl5UNKfIZ+EXiGMj
 cZ7hJDuILPX7AORpTDNqItRk/miHUp50NHy40NwR3RKeaaZJlLocOkAwdrp2XQ9EnP
 0FN5L5g9hJGIg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.5)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2ua2-0000000Bkrx-3ILq; Sat, 05 Sep 2026 19:53:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 5/8] tests/acpi: virt: add x86 DSDT and HEST tables
Date: Sat,  5 Sep 2026 19:53:25 +0200
Message-ID: <fd8720055fdad2b1498c6f69580e6306278a6c26.1788630333.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788630333.git.mchehab+huawei@kernel.org>
References: <cover.1788630333.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following DSDT changes affect both:

    -"tests/data/acpi/x86/pc/DSDT.ras",
    -"tests/data/acpi/x86/q35/DSDT.ras",

    --- /tmp/DSDT_old.dsl
    +++ /tmp/DSDT.dsl
    @@
    +        Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
    +        {
    +            If ((SizeOf (Arg3) < 0x08))
    +            {
    +                Return (Buffer (0x08) { 0x02, 0x00, 0x00, 0x00,
    +                    0x00, 0x00, 0x00, 0x00 })
    +            }
    +
    +            CreateDWordField (Arg3, Zero, CDW1)
    +            CreateDWordField (Arg3, 0x04, CDW2)
    +            If ((Arg0 != ToUUID ("0811b06e-4a27-44f9-8d60-3cbbc22e7b48")))
    +            {
    +                CDW1 |= 0x04
    +                Return (Arg3)
    +            }
    +            If ((Arg1 != One))
    +            {
    +                CDW1 |= 0x08
    +                Return (Arg3)
    +            }
    +            If ((Arg2 != 0x02))
    +            {
    +                CDW1 |= 0x02
    +                Return (Arg3)
    +            }
    +
    +            Local0 = (CDW2 & 0xFFFFFFFF)
    +            If ((CDW2 != Local0))
    +            {
    +                CDW1 |= 0x10
    +            }
    +            CDW2 = Local0
    +            Return (Arg3)
    +        }
    +
    +        Device (GEDD)
    +        {
    +            Name (_HID, "PNP0C33" /* Error Device */)
    +            Name (_UID, Zero)
    +        }
    +    }
    +
    +    Scope (_GPE)
    +    {
    +        Method (_E07, 0, NotSerialized)
    +        {
    +            Notify (\_SB.GEDD, 0x80) // Status Change
    +        }
    +    }

The x86 HEST table now contains a GHESv2 source:

    --- /tmp/HEST_old.dsl
    +++ /tmp/HEST.dsl
    @@
    +[024h 0036   4]           Error Source Count : 00000001
    +
    +[028h 0040   2]                Subtable Type : 000A [Generic Hardware Error Source V2]
    +[02Ah 0042   2]                    Source Id : 0001
    +[02Ch 0044   2]            Related Source Id : FFFF
    +[02Eh 0046   1]                     Reserved : 00
    +[02Fh 0047   1]                      Enabled : 01
    +[030h 0048   4]       Records To Preallocate : 00000001
    +[034h 0052   4]      Max Sections Per Record : 00000001
    +[038h 0056   4]          Max Raw Data Length : 00000400
    +
    +[03Ch 0060  12]         Error Status Address : [Generic Address Structure]
    +[03Ch 0060   1]                     Space ID : 00 [SystemMemory]
    +[03Dh 0061   1]                    Bit Width : 40
    +[03Fh 0063   1]         Encoded Access Width : 04 [QWord Access:64]
    +
    +[048h 0072  28]                       Notify : [Hardware Error Notification Structure]

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tests/data/acpi/x86/pc/DSDT.ras             | Bin 0 -> 8818 bytes
 tests/data/acpi/x86/pc/HEST.ras             | Bin 0 -> 132 bytes
 tests/data/acpi/x86/q35/DSDT.ras            | Bin 0 -> 8647 bytes
 tests/data/acpi/x86/q35/HEST.ras            | Bin 0 -> 132 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/x86/pc/DSDT.ras b/tests/data/acpi/x86/pc/DSDT.ras
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ee99b20fd6e9d95ad2690e20573cd8bd5ca0d90f 100644
GIT binary patch
literal 8818
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
F{{Ue1iFp73

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/pc/HEST.ras b/tests/data/acpi/x86/pc/HEST.ras
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..6dfeb1d3704523f5ee7c81f442c4f51bbd10282d 100644
GIT binary patch
literal 132
zcmeZp4Gw8xU|?XhbMklg2v%^42yj+VP*7lGU|;~TK{N<+F)%Xx|Ife(<1?@@FfceU
guzdLapPhk$fq_{DMB)HYwLhS0|NVymkXaxA05bg-0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/DSDT.ras b/tests/data/acpi/x86/q35/DSDT.ras
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..f7626f56ceda77aeb0ca04e8913d76bf57177a45 100644
GIT binary patch
literal 8647
zcmb7~Pi))P9mn6(KT}VXMM?CZ*iNjaExN5kDkp6k>>nzT6h&K77*S3-Fo0+~*_@<U
ziM9sn1_5jZXuSXfmTD<>R0|c@Z9VO>Lxb(G?UvgL?6ku!y$(aOOEvr+$@u+b8K`}r
z$;bD7-}iYW-`D1&?&zJreuohHpn6%WJEiIywpJ>YN|X=+`|w+_64!~lr&rA`&BPMa
z-OuoSy=qn^^#^)&-K4+U_CEH!cR%##hEFy>RUU0_`1cRIO#+p6HhsomM_DU&ood(Z
zSvgy?%2Ky(>2l=>lccT|?8T+-x}_7fG1a~7Xo&}Rh^Aj#8MKo9?R=3bZu6fPzFuB>
z{o`xzRv!Q4A3uL^hb1)q+W7}}n55~~F8HwV?t1KuH&8z6-=g<G&d;q3iXZj)>7Y!3
zGrk8UpU6QGG_^9kqpl?l-DzeA7yGw~pN~`G4HiBMI`HJRzyI5L_5J3<xv!e1{-QO9
z-eBs{EfyPkKHER=2pM{VrT%R;<rk7Mk|myh|KLqRHvEm?q}#isw<{Va&)O}!td&=Y
z)YaNfewi(OI7f&KLk>Tmk4B>}!hL0zD6N@uFnBO<?w+kV9h!M8Gs)do;6SrAYrSM^
zmR@rA9AmXhGk=p=!rjlnfmSUWt0i}@+G@6G=1Cxf1FhOxZ<cIJf1~8mYC~Hi>I=4J
ztj65u;Ak}Rx1ol=OK%Zq!+jBoheUm;V(D*8ss(NNu<^pWo~kpOkEfnG(SVW-A58cF
z-amMglFh-wNB8=hq`xVTMxznAw?Q}VZR}DubvVF-*ZAm<3H?GW1{d++q1xYsE8=I#
zfk(;ElWa??5moNmmPY+;I8u67DU7(HeZ}uqyWO!1Ywzq8GKtJ+L>jF%g9Q7u(ORpK
zf(+#>)@ZGn(Lub?TC0;nHX)Bjlz^u8><CmQDNG0FxUPP92udTY8{<mz*%2tCs<A+6
zgvuD<%E%?ol~E7kTp3l32g+Kgj0eidCBc<Z4-#A%RZRrSsPl<H8M!18XA*HHF=sMR
zMlLDDnL?Z?%$dTRQ;2g4aZX{*Da<J$P6=^Jm{Y=>X~daEoN3IN#+(dsGQ`O+C&Qc>
z#F;^y8O)i%oHF8+5vPnfWz3mHoLR(~#hh8pIgL1{5$81KoW`6v#F;~!In0^EoC@Mp
z5T}AU70j7OoO#5V$DDc0SwNfx#96?c1<YAQoJGW0#GFOUsUl7lajKY8#hf#Ua|UtF
zV9puLIg2=F5$7!CoW-1Th;t5c&SB0u%sG!Z=Mm>T=A6fzr?|2b&YGvVvKmfyrvjyR
zcnI^Y9@bqz$_1ocz{-WdGg2-h<swopV&x)ME+OR-QZ8ZT5>}o@%F{@B8Y@p@<r%Jw
zX5TYh8O`x$0%bJEp9z%F9KVb_myzc(_FRrUAwVlafSQi=EI>`iIt)<Lu?_>&bgamf
z63|4^MhU2*{!zj}7o{R443rUCj4PvPi*aRC6#_J<%99uZRB(xNWz>T>SBe1|ROLzt
z(4a>=?h{-Y^&r8O(cnUW3Y~`l6*!ZKGl@7MKm|?+P=ParI8%rd0#x9H02Mf=5a$%)
zga8#dAwUIA32{n@69QD=ga8#d(}**TI3Yj<P6$welOaxqI3Yj<P6$weGlMuYh!X--
z;Di7bIAz2sBTfiVffE8$;LIY<EaHR!6*wV41<q;2IgL0WKm|?+P=PatICF>-0#x9H
z02MeD#Hk=o2vC6&0#xA4BhEbHga8#dAwUJr0^%$nP6$we69QD=EF#V#;)DPdI3Yj<
zP8D&gh!X--;Di7bIA;*&4B~_U6*wV41<qN-Ig2<UKm|?+P=Rv}an2!52vC6&0#x9f
zN1XGB69QD=ga8#dPjRIXpr&Jq0ctvy7@($OMKQR5lndN5QbK?VN(fLvxrmgDNC^Qd
zC?P-v<q}dZAteN;po9Pwl&6vMG*Uu<3Q7o2L3xHNqdEQzS4ML@1gJ2!5TL@?E+fxn
z<Ou;PctU`3Pj#Vdw>xAY_xV4oL->dElN9`_s733F)1ia(UADJPhAcf~8TA$Giq=j`
zcDr59PqWOgQY6h^F6@#AP{xvWyKVV*w^@$B-Vh4iUSq1!TB}6wX5?J(Mn>w|Z6`m=
ziocpB>3EV5!U!Q5LdY&rb6uxXAw%eb-M&&$^IhF?$UWF+d%PqEuQ;HF*5=1^U8n8P
z2isvEz#hs&_v)BCJ%M{waIbRr>X>`=8275%YXW=lc1Es5>@0Qydrh#{xV<)JuN`Br
zh4%UwJiHV8)?=>=_ByxM$L#fE?Df#z7`IQHz}^t-4Q_9Y*&D~$8=-w|+&*~%`<h^1
z<My>N``R(~wb0%iw@;nG-W2RjZf}m+o5$Fjp?!Vae(D7Fb-}*Q?dxOq^<(VoZm*dz
z9c%olXG&lnO&$t=+=JJZxJ*s)M_x_w=Q?a|{4r*E++2P_b3xg}=8im<1>9U=LUTdc
z#O97XXGPpxaYA!J*~I3KJU1$CPMy$PP&To-BhSGMZf<5mb3xg}=8oLgv$(n03C#s%
z6Pr77pU&at<|Z^3l;P%-rW7m)7*gFfI?>%v!({+>uWommL?-0PHyM&}_Z2uUUNu^J
z$!_c2l6sLRj}IlD4@DdAdra{L^25GI`d(%<8j`{E!~O>O?S@SL_21->3|TI?gY#_q
zgEYKgfAS4UK#nPD*R+G{n5}5GRW6q=62+(nU0h3Fe>on#fw$X+6ZID6h;>WPYW8}m
z{?@zxn>)WKy?yhYw|3s%y7>-qsb)9U!iOfym`T5szm%!GOWZxX4R7(kl$q@Ae-{oa
zq@>wKi)vQOp<26nm1@Rn88$Ua;+odfC3n97HRGCNG)knT>6K2&?Y(~KI$s^o?De2u
zA;3x*oP)KMq?*?{wV%ZXtiMe@(8}fVEw!G~oK7X}K6m})gvbVchL`{2#g5VNVL7Bf
zegb;!vz+I?c;rlDZRn}ZB#@lUh>ka9td=LXuUZS5qqU@CFeI&ITr0#zl4h(n3bBz-
zwtRZy)5|mc8`LK^eCokk1G)KWEAyMaM;~obpLqV(xI1SbFVvd)VD8a)sb1-9ea7!Q
zHtOGGBcI;*%%4<g@cfaHgiG&l9YCKq$j*jOy$O}z)__XJYU3u^x#?4HXA2hIj6|^V
z2I@_+1=o9v`djYGWSk=-Y_*)7O=zf^c(i%bzt0__hFJVtw$g51-PxRcrJ8B&veS`|
zxl)sFxFfyPn!0~$!f^U5HeL!<Z;u!1mCnT8x%V%@V-YO6sWQwh(hwdHB6XXUPCmmV
zA`t?AM61)?%T6Z)Fl77IZFTYbIhZ`UM)^Dm=LvWg;kHzoGr_|dta-v(-)e^a@gPfL
zGPfGRmYVdb{8XmWL6%TC4n<$fgglj>9cM>S@jrZ#ke`RY!AI~$ga5<`T0WFUqtPG2
zQ@=-N9*;&}d=s2`{L=?75fZf)`~V#+uSwx?^aIDc#O-Mb(>8*&TfTx>DPJVP1PJBA
z%qPM4u}m=8@|mxcDy66bjjSf@y4~h8=vX7RW=)tykGAz#ek{}ZU7~#NI-I@GEu<2Z
z64-yGTaXeg#$x>FRX76>%8w2&gWEe-yQT#po4sN**URPd`3WvcQc1#Gt<)B;!~CeU
z7We{eFXNQUU8!5q+r;gC-zi@T4rI7HRH^H%=w!%u&PO{JV8`vPsZQ;%@-n1=)xHvA
z9+MR<!A;!#AHEz18>k6qDg19F+3hP;*l4iPB~r56R}9#%!N!D5U2=P`tX1`Hluhw?
zFmhq!&9fPkdc-4?n)C*_K`1>N<5%_h=H>Ngs$3DNB$hl2OVDobe8cXnL~SR6%T7^U
zg=J0pUi`hdB%R&kEnm<sH=k*el;0{?lV{T=eHwonC(?5YnFpg6+8ym#cQRpm^0s~A
z6Dpl06sqN%S|uF#7>p$pRKtQeStg1M52c#w8s!zDye`8fR9k8Iwm=>fAANX-Nke$5
zW8qC6es2(cRxo%WT=xIv=XvSH)&J?g_I~`QKcBl>N8bw!3S(ay4DZ0V2De!(s1^%8
zE4T|ED)5DCFZ>kY{E<%)&JXXny;G*42Y;LfUkF^d5DYX?PH~!I*C@Y6J_v4RsLS^L
E4{5|Mc>n+a

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/HEST.ras b/tests/data/acpi/x86/q35/HEST.ras
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..6dfeb1d3704523f5ee7c81f442c4f51bbd10282d 100644
GIT binary patch
literal 132
zcmeZp4Gw8xU|?XhbMklg2v%^42yj+VP*7lGU|;~TK{N<+F)%Xx|Ife(<1?@@FfceU
guzdLapPhk$fq_{DMB)HYwLhS0|NVymkXaxA05bg-0RR91

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index b3761468accc..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT.ras",
-"tests/data/acpi/x86/pc/HEST.ras",
-"tests/data/acpi/x86/q35/DSDT.ras",
-"tests/data/acpi/x86/q35/HEST.ras",
-- 
2.55.0


