Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52675C47258
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 01:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVMLY-0006D7-JZ; Wed, 31 Jan 2024 20:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenfu@staff.sina.com>)
 id 1rVMLP-0006Cm-OK; Wed, 31 Jan 2024 20:58:23 -0500
Received: from staff-jes1.sina.com.cn ([61.135.152.204]
 helo=mail.staff.sina.com.cn) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenfu@staff.sina.com>)
 id 1rVMLM-0005ZN-Mb; Wed, 31 Jan 2024 20:58:23 -0500
Received: from ex2016-33.staff.sina.com.cn (10.211.212.33) by
 ex2016-38.staff.sina.com.cn (10.211.212.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 1 Feb 2024 09:57:34 +0800
Received: from ex2016-33.staff.sina.com.cn ([fe80::d4d6:f1ac:10c9:b986]) by
 ex2016-33.staff.sina.com.cn ([fe80::d4d6:f1ac:10c9:b986%3]) with mapi id
 15.01.2507.009; Thu, 1 Feb 2024 09:57:34 +0800
From: =?gb2312?B?s8Lm2g==?= <chenfu@staff.sina.com>
To: "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: =?gb2312?B?tPC4tDogRGlzayBtaWdyYXRpb24gZnJvbSBxY293MiB0byBTUERL?=
Thread-Topic: Disk migration from qcow2 to SPDK
Thread-Index: AdpTJsy5P0xmI6iBS5OxVZuJFVR4CgBivgyA
Date: Thu, 1 Feb 2024 01:57:34 +0000
Message-ID: <ed661c7f455f4e39bf5354a2984f48d2@staff.sina.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.235.54.13]
Content-Type: multipart/alternative;
 boundary="_000_ed661c7f455f4e39bf5354a2984f48d2staffsinacom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=61.135.152.204;
 envelope-from=chenfu@staff.sina.com; helo=mail.staff.sina.com.cn
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_ed661c7f455f4e39bf5354a2984f48d2staffsinacom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

Y2FuIHNvbWVvbmUgaGVscCBtZSA/DQoNCreivP7Iyzogs8Lm2g0Kt6LLzcqxvOQ6IDIwMjTE6jHU
wjMwyNUgMTA6NTENCsrVvP7IyzogJ3FlbXUtYmxvY2tAbm9uZ251Lm9yZycgPHFlbXUtYmxvY2tA
bm9uZ251Lm9yZz4NCrOty806ICdxZW11LWRldmVsQG5vbmdudS5vcmcnIDxxZW11LWRldmVsQG5v
bmdudS5vcmc+DQrW98ziOiBEaXNrIG1pZ3JhdGlvbiBmcm9tIHFjb3cyIHRvIFNQREsNCg0KSGVs
bG8gZXZlcnlvbmUsDQoNClJlY2VudGx5LCB3ZSBhcmUgbG9va2luZyB0byBzd2l0Y2ggdGhlIFZN
oa9zIGRpc2tzIGZyb20gdGhlIHFlbXUgZHJpdmVyIHdpdGggdGhlIHFjb3cyIGZvcm1hdCB0byBh
IHZob3N0LXVzZXItYmxrIGRyaXZlciBiYXNlZCBvbiBTUERLLiBDdXJyZW50bHksIHdlIGFyZSBh
YmxlIHRvIGNvcHkgZGF0YSBpbnRvIGFuIFNQREstYmFzZWQgdGFyZ2V0IHVzaW5nIHRoZSBibG9j
a2NvcHkgbWV0aG9kLiBXZSB3b3VsZCBsaWtlIHRvIGlucXVpcmUgaWYgdGhlcmUgaXMgYSB0aGVv
cmV0aWNhbCBwb3NzaWJpbGl0eSB0byBzd2l0Y2ggdGhlIHZpcnRpbyBiYWNrZW5kIGZyb20gcWVt
dSB0byB2aG9zdC11c2VyLWJsayBvbmxpbmUuIElmIGl0J3MgcG9zc2libGUsIHdoYXQgd291bGQg
bmVlZCB0byBiZSBkb25lPw0KDQpCZXN0IHJlZ2FyZHMNCg==

--_000_ed661c7f455f4e39bf5354a2984f48d2staffsinacom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:=CE=A2=C8=ED=D1=C5=BA=DA;
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CE=A2=C8=ED=D1=C5=BA=DA";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"Helvetica Neue";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica Neue&quot;;color:#2C2D30;background:white">can someone help me ?</spa=
n><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sa=
ns-serif">=B7=A2=BC=FE=C8=CB<span lang=3D"EN-US">:</span></span></b><span l=
ang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;=CE=A2=C8=ED=D1=
=C5=BA=DA&quot;,sans-serif">
</span><span style=3D"font-size:11.0pt;font-family:&quot;=CE=A2=C8=ED=D1=C5=
=BA=DA&quot;,sans-serif">=B3=C2=E6=DA<span lang=3D"EN-US">
<br>
</span><b>=B7=A2=CB=CD=CA=B1=BC=E4<span lang=3D"EN-US">:</span></b><span la=
ng=3D"EN-US"> 2024</span>=C4=EA<span lang=3D"EN-US">1</span>=D4=C2<span lan=
g=3D"EN-US">30</span>=C8=D5<span lang=3D"EN-US"> 10:51<br>
</span><b>=CA=D5=BC=FE=C8=CB<span lang=3D"EN-US">:</span></b><span lang=3D"=
EN-US"> 'qemu-block@nongnu.org' &lt;qemu-block@nongnu.org&gt;<br>
</span><b>=B3=AD=CB=CD<span lang=3D"EN-US">:</span></b><span lang=3D"EN-US"=
> 'qemu-devel@nongnu.org' &lt;qemu-devel@nongnu.org&gt;<br>
</span><b>=D6=F7=CC=E2<span lang=3D"EN-US">:</span></b><span lang=3D"EN-US"=
> Disk migration from qcow2 to SPDK<o:p></o:p></span></span></p>
</div>
</div>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello everyone,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Recently, we are looking to swi=
tch the VM=A1=AFs disks from the qemu driver with the qcow2 format to a vho=
st-user-blk driver based on SPDK. Currently, we are able to copy data into =
an SPDK-based target using the blockcopy
 method. We would like to inquire if there is a theoretical possibility to =
switch the virtio backend from qemu to vhost-user-blk online. If it's possi=
ble, what would need to be done?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best regards<o:p></o:p></span><=
/p>
</div>
</body>
</html>

--_000_ed661c7f455f4e39bf5354a2984f48d2staffsinacom_--

