Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35802C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 02:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUeDU-0004Qv-1i; Mon, 29 Jan 2024 21:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenfu@staff.sina.com>)
 id 1rUeDQ-0004LL-AC; Mon, 29 Jan 2024 21:51:12 -0500
Received: from staff-jes1.sina.com.cn ([61.135.152.204]
 helo=mail.staff.sina.com.cn) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenfu@staff.sina.com>)
 id 1rUeDL-0001kz-9n; Mon, 29 Jan 2024 21:51:11 -0500
Received: from ex2016-33.staff.sina.com.cn (10.211.212.33) by
 ex2016-32.staff.sina.com.cn (10.211.212.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 30 Jan 2024 10:50:32 +0800
Received: from ex2016-33.staff.sina.com.cn ([fe80::d4d6:f1ac:10c9:b986]) by
 ex2016-33.staff.sina.com.cn ([fe80::d4d6:f1ac:10c9:b986%3]) with mapi id
 15.01.2507.009; Tue, 30 Jan 2024 10:50:27 +0800
From: =?gb2312?B?s8Lm2g==?= <chenfu@staff.sina.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Disk migration from qcow2 to SPDK
Thread-Topic: Disk migration from qcow2 to SPDK
Thread-Index: AdpTJsy5P0xmI6iBS5OxVZuJFVR4Cg==
Date: Tue, 30 Jan 2024 02:50:27 +0000
Message-ID: <cfb4361182f74713b3382304e3b03e7b@staff.sina.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.235.54.13]
Content-Type: multipart/alternative;
 boundary="_000_cfb4361182f74713b3382304e3b03e7bstaffsinacom_"
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

--_000_cfb4361182f74713b3382304e3b03e7bstaffsinacom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8gZXZlcnlvbmUsDQoNClJlY2VudGx5LCB3ZSBhcmUgbG9va2luZyB0byBzd2l0Y2ggdGhl
IFZNoa9zIGRpc2tzIGZyb20gdGhlIHFlbXUgZHJpdmVyIHdpdGggdGhlIHFjb3cyIGZvcm1hdCB0
byBhIHZob3N0LXVzZXItYmxrIGRyaXZlciBiYXNlZCBvbiBTUERLLiBDdXJyZW50bHksIHdlIGFy
ZSBhYmxlIHRvIGNvcHkgZGF0YSBpbnRvIGFuIFNQREstYmFzZWQgdGFyZ2V0IHVzaW5nIHRoZSBi
bG9ja2NvcHkgbWV0aG9kLiBXZSB3b3VsZCBsaWtlIHRvIGlucXVpcmUgaWYgdGhlcmUgaXMgYSB0
aGVvcmV0aWNhbCBwb3NzaWJpbGl0eSB0byBzd2l0Y2ggdGhlIHZpcnRpbyBiYWNrZW5kIGZyb20g
cWVtdSB0byB2aG9zdC11c2VyLWJsayBvbmxpbmUuIElmIGl0J3MgcG9zc2libGUsIHdoYXQgd291
bGQgbmVlZCB0byBiZSBkb25lPw0KDQpCZXN0IHJlZ2FyZHMNCg==

--_000_cfb4361182f74713b3382304e3b03e7bstaffsinacom_
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
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
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

--_000_cfb4361182f74713b3382304e3b03e7bstaffsinacom_--

