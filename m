Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9C7C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbyn-0003KI-GK; Tue, 14 Jul 2026 08:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andi@complang.tuwien.ac.at>)
 id 1wjbyl-0003H4-Qf
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:11:15 -0400
Received: from secgw1.intern.tuwien.ac.at ([128.130.30.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andi@complang.tuwien.ac.at>)
 id 1wjbyj-0001rd-Bv
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:11:15 -0400
Received: from Kiteworks (kwmta1.intern.tuwien.ac.at [128.130.30.91])
 by secgw1.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 66ECA6SN023529;
 Tue, 14 Jul 2026 14:10:06 +0200
Received: from secgw1.intern.tuwien.ac.at ([128.130.30.71])
 by totemomail.intern.tuwien.ac.at (Totemo SMTP Server) with SMTP ID 281;
 Tue, 14 Jul 2026 12:11:15 +0000 (GMT)
Received: from edge19a.intern.tuwien.ac.at (edge19a.intern.tuwien.ac.at
 [IPv6:2001:629:1005:30::45])
 by secgw1.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 66ECA5Ia023517
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Tue, 14 Jul 2026 14:10:06 +0200
Received: from mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) by
 edge19a.intern.tuwien.ac.at (2001:629:1005:30::45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 14:10:05 +0200
Received: from smtpclient.apple (2001:4bc9:c06d:73b1:b58b:1528:8bd5:a82c) by
 mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 14:10:05 +0200
From: Andreas Krall <andi@complang.tuwien.ac.at>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_166779A8-601B-4CF6-871C-F784888D3E9D"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [ANNOUNCE] OpenVADL 0.3.0 (QEMU target generator with tensor support)
Message-ID: <9F747C76-BF27-4D2D-8A95-7FC00C3AB6E4@complang.tuwien.ac.at>
Date: Tue, 14 Jul 2026 14:09:54 +0200
CC: "Zottele, Johannes" <e11911133@student.tuwien.ac.at>
To: <qemu-devel@nongnu.org>
X-ClientProxiedBy: mbx19c.intern.tuwien.ac.at (2001:629:1005:30::83) To
 mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82)
Received-SPF: pass client-ip=128.130.30.71;
 envelope-from=andi@complang.tuwien.ac.at; helo=secgw1.intern.tuwien.ac.at
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Apple-Mail=_166779A8-601B-4CF6-871C-F784888D3E9D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

We announce the availability of OpenVADL 0.3.0 =
(https://github.com/OpenVADL/openvadl).

OpenVADL now supports the specification of tensor instructions with =
preliminary auto vectorization
to generate QEMU TCG vector instructions. Furthermore, dynamically =
bi-endian memory access
and aliasing of the program counter with the general purpose register =
file is supported (needed
for the specification of AArch32). A hardware generator for scalar =
processor pipelines is working
now too. The slides from the FSiC conference give some details regarding =
the implementation
and preliminary performance numbers: =
https://wiki.f-si.org/images/6/69/OpenVADLfsic2026.pdf

Andreas
--=20
andi@complang.tuwien.ac.at <mailto:andi@complang.tuwien.ac.at>      =
Andreas Krall
www.complang.tuwien.ac.at/andi <http://www.complang.tuwien.ac.at/andi>  =
Compilers and Languages, TU Wien
tel: (+431) 58801/18511         Argentinierstr. 8/4/194-5
fax: (+431) 58801/18598         A-1040 Wien    AUSTRIA    EUROPE




--Apple-Mail=_166779A8-601B-4CF6-871C-F784888D3E9D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="us-ascii"

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">We announce the availability of OpenVADL =
0.3.0 (<a =
href=3D"https://github.com/OpenVADL/openvadl">https://github.com/OpenVADL/=
openvadl</a>).<div><br></div><div>OpenVADL now supports the =
specification of tensor instructions with preliminary auto =
vectorization</div><div>to generate QEMU TCG vector instructions. =
Furthermore, dynamically bi-endian memory access</div><div>and aliasing =
of the program counter with the general purpose register file is =
supported (needed</div><div>for the specification of AArch32). A =
hardware generator for scalar processor pipelines is =
working</div><div>now too. The slides from the FSiC conference give some =
details regarding the implementation</div><div>and preliminary =
performance numbers:&nbsp;<a =
href=3D"https://wiki.f-si.org/images/6/69/OpenVADLfsic2026.pdf">https://wi=
ki.f-si.org/images/6/69/OpenVADLfsic2026.pdf</a></div><div><br></div><div>=
Andreas</div><div><div>
<meta charset=3D"UTF-8"><div dir=3D"auto" style=3D"caret-color: rgb(0, =
0, 0); color: rgb(0, 0, 0); letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid; overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><div><div><font face=3D"Menlo">--&nbsp;<br><a =
href=3D"mailto:andi@complang.tuwien.ac.at">andi@complang.tuwien.ac.at</a>&=
nbsp; &nbsp; &nbsp;&nbsp;Andreas Krall<br><a =
href=3D"http://www.complang.tuwien.ac.at/andi">www.complang.tuwien.ac.at/a=
ndi</a>&nbsp;&nbsp;Compilers and Languages, TU Wien<br>tel: (+431) =
58801/18511 &nbsp; &nbsp; &nbsp; =
&nbsp;&nbsp;Argentinierstr.&nbsp;8/4/194-5<br>fax: (+431) 58801/18598 =
&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;A-1040 Wien &nbsp; &nbsp;AUSTRIA &nbsp; =
&nbsp;EUROPE</font></div><div><font =
face=3D"Menlo"><br></font></div></div></div><br =
class=3D"Apple-interchange-newline">
</div>
<br></div></body></html>=

--Apple-Mail=_166779A8-601B-4CF6-871C-F784888D3E9D--

