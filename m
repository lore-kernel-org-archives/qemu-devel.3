Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E912BC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trf2M-0008VX-AT; Mon, 10 Mar 2025 11:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <b-chu1@ti.com>) id 1treUw-0004gE-9F
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:52:54 -0400
Received: from lelvem-ot02.ext.ti.com ([198.47.23.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <b-chu1@ti.com>) id 1treUt-0003yn-TE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:52:53 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52AEqmah1001596
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741618368;
 bh=6isOCP4rL6vg1z2crGFBSuwJ4/guHJS8dUjU9PZ96D4=;
 h=From:To:Subject:Date;
 b=OeZIPVdY20cXhyCIDi/I5JXyyzXCTUQNtuiQF31u8pz4BWSrQx8oSnR5Y9WRr/yRB
 naxrJvnFLXAai1OChmQSbhSai4dV1iH8Y9I4ehv9ZaTXFTWC+Tr0jOdx3n8y5O3Iam
 mz6977HliPbWMTwGsLYEOaHGJnHHKMF+Pc+oTX8Y=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52AEqmFN066901
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:52:48 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Mar 2025 09:52:47 -0500
Received: from DLEE104.ent.ti.com ([fe80::1b8:1a58:6ede:b6f0]) by
 DLEE104.ent.ti.com ([fe80::1b8:1a58:6ede:b6f0%17]) with mapi id
 15.01.2507.023; Mon, 10 Mar 2025 09:52:47 -0500
From: "Chu, Benson" <b-chu1@ti.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [qemu-riscv] Error mapping file: Invalid argument
Thread-Topic: [qemu-riscv] Error mapping file: Invalid argument
Thread-Index: AduPfbObvaZEQCeIQHKWYq5QvtJv3w==
Date: Mon, 10 Mar 2025 14:52:47 +0000
Message-ID: <f5ee7468950a4c3abbd3b05b7753d15c@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.37.7]
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: multipart/alternative;
 boundary="_000_f5ee7468950a4c3abbd3b05b7753d15cticom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=198.47.23.235; envelope-from=b-chu1@ti.com;
 helo=lelvem-ot02.ext.ti.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 10 Mar 2025 11:26:56 -0400
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

--_000_f5ee7468950a4c3abbd3b05b7753d15cticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

I am working on a linker for the RISC-V target, and I was trying to use qem=
u-riscv32 to test my linker.

However, I have noticed that qemu-riscv32 has some restrictions about how t=
he program can be laid out in memory, and getting my linker to place the pr=
ogram in a way that qemu-riscv32 will accept is very annoying.

By my understanding, for each segment to be loaded, offset into the ELF fil=
e must match the offset into a target page, which seems to be 4KiB.

I noticed that GNU ld and LLVM's lld both follow this placement by default.=
 Is there some ABI that's being conformed to for this? Is there any documen=
tation describing why placement needs to be done this way?

Thanks!
Benson


--_000_f5ee7468950a4c3abbd3b05b7753d15cticom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello all, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am working on a linker for the RISC-V target, and =
I was trying to use qemu-riscv32 to test my linker.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">However, I have noticed that qemu-riscv32 has some r=
estrictions about how the program can be laid out in memory, and getting my=
 linker to place the program in a way that qemu-riscv32 will accept is very=
 annoying.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">By my understanding, for each segment to be loaded, =
offset into the ELF file must match the offset into a target page, which se=
ems to be 4KiB.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I noticed that GNU ld and LLVM&#8217;s lld both foll=
ow this placement by default. Is there some ABI that&#8217;s being conforme=
d to for this? Is there any documentation describing why placement needs to=
 be done this way?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks!<o:p></o:p></p>
<p class=3D"MsoNormal">Benson<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_f5ee7468950a4c3abbd3b05b7753d15cticom_--

