Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47BDC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 17:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHrM-0001r9-92; Mon, 30 Jun 2025 13:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andi@complang.tuwien.ac.at>)
 id 1uWHN5-00084j-NA
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:28:45 -0400
Received: from secgw2.intern.tuwien.ac.at ([2001:629:1005:30::72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andi@complang.tuwien.ac.at>)
 id 1uWHMy-00073k-77
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:28:43 -0400
Received: from Kiteworks (kwmta2.intern.tuwien.ac.at [128.130.30.92])
 by secgw2.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 55UGSPpa005482;
 Mon, 30 Jun 2025 18:28:25 +0200
Received: from secgw2.intern.tuwien.ac.at ([128.130.30.72])
 by totemomail.intern.tuwien.ac.at (Totemo SMTP Server) with SMTP ID 982;
 Mon, 30 Jun 2025 16:28:24 +0000 (GMT)
Received: from edge19a.intern.tuwien.ac.at (edge19a.intern.tuwien.ac.at
 [IPv6:2001:629:1005:30::45])
 by secgw2.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 55UGSOBS005467
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Mon, 30 Jun 2025 18:28:24 +0200
Received: from mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) by
 edge19a.intern.tuwien.ac.at (2001:629:1005:30::45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 18:28:24 +0200
Received: from smtpclient.apple (2001:4bc9:80b:6944:48da:4807:fb25:a8f9) by
 mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 18:28:23 +0200
From: Andreas Krall <andi@complang.tuwien.ac.at>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_F1A87DAE-AFC8-4DEE-8868-E22A1AD0F3D4"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: [ANNOUNCE] OpenVADL 0.2.0
Message-ID: <3728A3AB-1D9A-4D0C-8778-70AE2B01A0D1@complang.tuwien.ac.at>
Date: Mon, 30 Jun 2025 18:28:23 +0200
CC: "Zottele, Johannes" <e11911133@student.tuwien.ac.at>
To: <qemu-devel@nongnu.org>
X-ClientProxiedBy: mbx19a.intern.tuwien.ac.at (2001:629:1005:30::81) To
 mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82)
Received-SPF: pass client-ip=2001:629:1005:30::72;
 envelope-from=andi@complang.tuwien.ac.at; helo=secgw2.intern.tuwien.ac.at
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Jun 2025 12:59:56 -0400
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

--Apple-Mail=_F1A87DAE-AFC8-4DEE-8868-E22A1AD0F3D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Generation of a QEMU based instruction set simulator from a processor =
description in OpenVADL (SAMOS=E2=80=9925)

QEMU (Quick EMUlator) is a generic and open source machine emulator and =
virtualizer which employs
Dynamic Binary Translation (DBT) to emulate a guest architecture on a =
host architecture. OpenVADL is
an open source implementation of the Vienna Architecture Description =
Language (VADL), a processor
description language developed for rapid design space exploration in the =
area of processor design.
OpenVADL automatically generates various essential artifacts. One such =
artifact is the Instruction Set
Simulator (ISS), which enables the execution of programs compiled for =
the described processor on
different host systems. To achieve high-performance simulation with =
broad platform support,
OpenVADL's ISS generator produces a QEMU frontend, seamlessly =
integrating into the QEMU system.
This integration leverages QEMU's DBT, along with built-in features such =
as GDB debugging. Optimized
generation of QEMU's TCG intermediate representation ensures competitive =
performance, even when
compared to manually written and optimized frontends. Benchmark results =
show that the
OpenVADL-generated QEMU based ISS achieves a speedup of up to 1.77 =
compared to the official
handwritten QEMU frontend for the RISC-V RV64IM instruction set =
architecture.

Full article: =
https://www.complang.tuwien.ac.at/vadl/papers/samos25Acknowledge.pdf
GitHub: https://github.com/OpenVADL/openvadl
Information: https://www.openvadl.org <https://www.openvadl.org/>

In OpenVADL version 0.2.0 a QEMU frontend for the integer subset of =
RISC-V RV**IM and AArch64
frontend can be automatically generated from a VADL specification. =
Limited compiler generation for
RISC-V is available, for AArch64 it is work in progress. Power and AMD64 =
is work in progress.
Specification of tensor instructions is work in progress. Floating point =
support is not available.
Hardware generation is work in progress.

Andreas

--=20
andi@complang.tuwien.ac.at <mailto:andi@complang.tuwien.ac.at>      =
Andreas Krall
www.complang.tuwien.ac.at/andi <http://www.complang.tuwien.ac.at/andi>  =
Compilers and Languages, TU Wien
tel: (+431) 58801/18511         Argentinierstr. 8/4/194-5
fax: (+431) 58801/18598         A-1040 Wien    AUSTRIA    EUROPE







--Apple-Mail=_F1A87DAE-AFC8-4DEE-8868-E22A1AD0F3D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D"">
	=09
=09
=09
		<div class=3D"page" title=3D"Page 1">
			<div class=3D"layoutArea">
				<div class=3D"column"><p class=3D""><b =
class=3D"">Generation of a QEMU based instruction set
simulator from a processor description in
OpenVADL</b>&nbsp;(SAMOS=E2=80=9925)</p>
				</div>
			</div>
		</div></div><div class=3D""><div class=3D"">QEMU (Quick =
EMUlator) is a generic and open source machine emulator and virtualizer =
which employs</div><div class=3D"">Dynamic Binary Translation (DBT) to =
emulate a guest architecture on a host architecture. OpenVADL =
is</div><div class=3D"">an open source implementation of the Vienna =
Architecture Description Language (VADL), a processor</div><div =
class=3D"">description language developed for rapid design space =
exploration in the area of processor design.</div><div class=3D"">OpenVADL=
 automatically generates various essential artifacts. One such artifact =
is the Instruction Set</div><div class=3D"">Simulator (ISS), which =
enables the execution of programs compiled for the described processor =
on</div><div class=3D"">different host systems. To achieve =
high-performance simulation with broad platform support,</div><div =
class=3D"">OpenVADL's ISS generator produces a QEMU frontend, seamlessly =
integrating into the QEMU system.</div><div class=3D"">This integration =
leverages QEMU's DBT, along with built-in features such as GDB =
debugging. Optimized</div><div class=3D"">generation of QEMU's TCG =
intermediate representation ensures competitive performance, even =
when</div><div class=3D"">compared to manually written and optimized =
frontends. Benchmark results show that the</div><div =
class=3D"">OpenVADL-generated QEMU based ISS achieves a speedup of up to =
1.77 compared to the official</div><div class=3D"">handwritten QEMU =
frontend for the RISC-V RV64IM instruction set =
architecture.</div></div><div class=3D""><br class=3D""></div><div =
class=3D"">Full article:&nbsp;<a =
href=3D"https://www.complang.tuwien.ac.at/vadl/papers/samos25Acknowledge.p=
df" =
class=3D"">https://www.complang.tuwien.ac.at/vadl/papers/samos25Acknowledg=
e.pdf</a></div><div class=3D"">GitHub:&nbsp;<a =
href=3D"https://github.com/OpenVADL/openvadl" =
class=3D"">https://github.com/OpenVADL/openvadl</a></div><div =
class=3D"">Information:&nbsp;<a rel=3D"nofollow" itemprop=3D"url" =
class=3D"Link--primary" title=3D"https://www.openvadl.org" =
href=3D"https://www.openvadl.org" style=3D"box-sizing: border-box; =
text-decoration: none; caret-color: rgb(31, 35, 40); white-space: =
nowrap; color: var(--fgColor-default) =
!important;">https://www.openvadl.org</a></div><div class=3D""><br =
class=3D""></div><div class=3D"">In OpenVADL version 0.2.0 a QEMU =
frontend for the integer subset of RISC-V RV**IM and AArch64</div><div =
class=3D"">frontend can be automatically generated from a VADL =
specification. Limited compiler generation for</div><div class=3D"">RISC-V=
 is available, for AArch64 it is work in progress. Power and AMD64 is =
work in progress.</div><div class=3D"">Specification of tensor =
instructions is work in progress. Floating point support is not =
available.</div><div class=3D"">Hardware generation is work in =
progress.</div><div class=3D""><br class=3D""></div><div =
class=3D"">Andreas</div><div class=3D""><br class=3D""></div><div =
class=3D"">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D""><span class=3D"Apple-style-span" style=3D"border-collapse: =
separate; color: rgb(0, 0, 0); font-family: Helvetica; font-style: =
normal; font-variant-ligatures: normal; font-variant-caps: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: -webkit-auto; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; border-spacing: =
0px; -webkit-text-decorations-in-effect: none; =
-webkit-text-stroke-width: 0px;"><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""><div class=3D""><div class=3D""><div class=3D""><font =
class=3D"Apple-style-span" face=3D"Monaco">--&nbsp;<br class=3D""><a =
href=3D"mailto:andi@complang.tuwien.ac.at" =
class=3D"">andi@complang.tuwien.ac.at</a>&nbsp; &nbsp; =
&nbsp;&nbsp;Andreas Krall<br class=3D""><a =
href=3D"http://www.complang.tuwien.ac.at/andi" =
class=3D"">www.complang.tuwien.ac.at/andi</a>&nbsp;&nbsp;Compilers and =
Languages, TU Wien<br class=3D"">tel: (+431) 58801/18511 &nbsp; &nbsp; =
&nbsp; &nbsp;&nbsp;Argentinierstr.&nbsp;</font><span style=3D"font-family:=
 Monaco;" class=3D"">8/4/194-5</span><font class=3D"Apple-style-span" =
face=3D"Monaco"><br class=3D"">fax: (+431) 58801/18598 &nbsp; &nbsp; =
&nbsp; &nbsp;&nbsp;A-1040 Wien &nbsp; &nbsp;AUSTRIA &nbsp; =
&nbsp;EUROPE<br class=3D""></font></div></div></div></div><div =
class=3D""><font class=3D"Apple-style-span" face=3D"Monaco"><br =
class=3D""></font></div></div></span><br =
class=3D"Apple-interchange-newline"></div><br =
class=3D"Apple-interchange-newline"></div><br =
class=3D"Apple-interchange-newline"><br =
class=3D"Apple-interchange-newline">
</div>
<br class=3D""></body></html>=

--Apple-Mail=_F1A87DAE-AFC8-4DEE-8868-E22A1AD0F3D4--

