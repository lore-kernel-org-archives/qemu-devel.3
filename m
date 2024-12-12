Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AF9E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjq7-0008DR-FE; Thu, 12 Dec 2024 09:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=06952aba3=kenneth_jia@asus.com>)
 id 1tLjIX-0008WD-P2; Thu, 12 Dec 2024 08:32:09 -0500
Received: from ms.asus.com ([103.10.4.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=06952aba3=kenneth_jia@asus.com>)
 id 1tLjIV-0008Cn-IF; Thu, 12 Dec 2024 08:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
 t=1734010328; x=1765546328;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=+BWRoSgWsOE7X8gxhEeW0GKnSxnR6+ax66jypHGL0EM=;
 b=kSEIwmPlsA74iIJV6EMf8DtoY9h5NgfN7Axe5t2Nge8i8folPRv+DkN7
 gMKv3aXwpXHr8TZT8rbXrVtviwDHWoFvWbKZkLQBXqLWKVr4NxGMEAE1j
 xZHT+kT+75GOzQHkOmSgAccuA+LV8S8PoauqB8TBPMH2WpksPrubnfSal M=;
IronPort-Data: A9a23:I1xTWqm+lBSgH6QIZooBKpTo5gybJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIWDT2DPquCZWDyf4snYITnoUIDv5/RnIJmTwtpqyljRS4T+ZvOCOrCIxarNUt+DOWaFxs/s
 J92hvosjiwQZiWBzvt4GuW5xZVE/fjUAOC6U4YoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GKNgFaYDEpFs8pvlzsy5JweiBtA1nQiaPZCukPplnV9JPrz8onqdxMU6qENdgKLb
 76rIIORpws1zD90Yj+RqYsXR2VRKlLk0ahivVINM0SqqkAqSiXfSc/XPtJEAatco23hc9ycV
 LyhHHF/IOskFvSkpQgTb/VXOwRfLfJf2rrIGlyuiN6Pn2/tLn/W7cw7WSnaPaVAkgp2KUhl3
 rk1GGlTKy7b3qS/y7n9Qe52nsIuMI/iJ54E0p1i5WiGV7B8ENaYH+OTvLe03x9p7ixKNfXTY
 cwUdTpYbhXJSxRUJ0xRA5U79AutriCmL20H9gLIzUYxyzHZkQJb3aPyCf/UefiTavVZwE+q/
 VuTqgwVBTlfbrRz0wGt63+pm6rGhybTXoUUG7ulsPlwjzW7zWgcIAcbWVuyvb+yjUvWc8pfK
 kgR9gIqrK477kvtScPyNzW6qXuFuCkYWtx4GvYi5QyB1qff40CSAW1sZjdHZMYrq+c9QjAn3
 ViPhM/zGDdz9raSTDSU69+8oiiyMC49N2IOZSYYCwAC5rHLuYw2k1fDQ8huFIazidv6Hyy2x
 CqFxBXSnJ1K0pRNjfT9pgyB2mvESoX1czPZLz7/BgqNhj6Vrqb/D2B0wTA3Ncp9Ebs=
IronPort-HdrOrdr: A9a23:5vRwV60O56Yu4XZpLDYOogqjBFckLtp133Aq2lEZdPUMSL38qy
 iv9M516faGskd0ZJhAo6HxBEDuewK+yXcY2+Qs1NSZLXrbUQmTXeNfBOLZqlWKcREWndQy6U
 4USchD4arLbGSS4/yX3ODyKadG/DDOytHPuQ7x9QYVcekxBpsQlzuQKWugYzZLrEkqP+tFKH
 LTi/A32wZJNx4sH7WG7stpZZm4m/Tb0I/jaQQLQwUq8hWKkFqTmcHHOgndwxMXST8K3rs462
 jClGXCl9uej80=
X-Talos-CUID: 9a23:WXESg2DWaC35lN76EwxG5BENOMUqSVnM9WXMc22TVGJTZoTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AqgDWzw1sjfJ1021UQiCDgpNB6jUjuq7zBmoAioo?=
 =?us-ascii?q?/nsiHETVfCzvDhQbse9py?=
Received: from unknown (HELO ACC-EX16-V01.acc.corpnet.asus) ([172.29.34.11])
 by ms.asus.com with ESMTP; 12 Dec 2024 21:31:55 +0800
Received: from ACC-EX16-V03.acc.corpnet.asus (172.29.34.13) by
 ACC-EX16-V01.acc.corpnet.asus (172.29.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Thu, 12 Dec 2024 21:31:54 +0800
Received: from ACC-EX16-V03.acc.corpnet.asus ([fe80::3dae:532a:2ef6:9654]) by
 ACC-EX16-V03.acc.corpnet.asus ([fe80::3dae:532a:2ef6:9654%3]) with
 mapi id 15.01.2507.043; Thu, 12 Dec 2024 21:31:48 +0800
To: "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>
CC: =?gb2312?B?J0OopmRyaWMgTGUgR29hdGVyJw==?= <clg@redhat.com>,
 =?gb2312?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZKimJw==?= <philmd@linaro.org>,
 "'Jamin Lin'" <jamin_lin@aspeedtech.com>, 'Andrew Jeffery'
 <andrew@codeconstruct.com.au>, 'Gavin Shan' <gshan@redhat.com>, "'open
 list:All patches CC here'" <qemu-devel@nongnu.org>
Subject: [PATCH]    hw/arm/aspeed: fix connect_serial_hds_to_uarts
Thread-Topic: [PATCH]    hw/arm/aspeed: fix connect_serial_hds_to_uarts
Thread-Index: AdtMmbwfoRQua2veTYW8MQ+0Vi041Q==
Date: Thu, 12 Dec 2024 13:31:48 +0000
Message-ID: <5f9b0c53f1644922ba85522046e92f4c@asus.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [116.235.194.63]
x-tm-as-product-ver: SMEX-14.0.0.3223-9.1.2019-28826.004
x-tm-as-result: No-10--14.720100-8.000000
x-tmase-matchedrid: 17iyaxE7EzIfHU5fltg9RrbW4WOZNAUnj5XD/cFEQwaQ+UeH24Dz4Lhu
 upHpXEmLU2VRnkEujdpjybcuQlsAB7ipA0mFNtPDyGyaQXOvRx4pihtGF1HQYaINgcEzNI9j7AI
 n5hx14Jqif1w5aAHlEkOBQVcKGV65AyTN38gAq/3vgBmbjAvGcP4HMKRDK5w12YGbrr/jo0ffOn
 cxfqt6MFxvJFCPsGl/3S/hhdntlxAm0dhXKknEYuKkRrdQOxlEJeVHOyz36PR3+86qkOXr2qF1m
 9FYSo2UVs7wr6DPfUIagKanydgPttdASTplK1Vu5PkCeM7tNe3Ed+T1CCeSceHZCF6RvUzMY3Pf
 SmNBHfKjg0lrtKMWyoAII85gNIZEPRhkRGot+L5w0hoJ16zIu7LMDEFKafMtcHZCeuS/TLNsMSR
 /KkjaoxLRXl5vgI6AUvWcNoeLMyxYKVgm72vjJg==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--14.720100-8.000000
x-tmase-version: SMEX-14.0.0.3223-9.1.2019-28826.004
x-tm-snts-smtp: F343C16444858CD64C6543F9F7079A6048EF239BBCBDAED2B483D0437155F81A2000:9
Content-Type: multipart/alternative;
 boundary="_000_5f9b0c53f1644922ba85522046e92f4casuscom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=103.10.4.142;
 envelope-from=prvs=06952aba3=kenneth_jia@asus.com; helo=ms.asus.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIMWL_WL_HIGH=-0.496, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Dec 2024 09:05:35 -0500
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
Reply-to:  =?gb2312?B?S2VubmV0aCBKaWEovNa8zbarX7uqy7bJz7qjKQ==?=
 <kenneth_jia@asus.com>
From: kenneth_jia--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_5f9b0c53f1644922ba85522046e92f4casuscom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

RnJvbSAyNGQzYmFkYmJiOWRjYzBkMjIwNjA5YTdkZDMwZjhkYTUwMDJjYmE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogS2VubmV0aCBKaWEgPGtlbm5ldGhfamlhQGFzdXMuY29tPg0K
RGF0ZTogVGh1LCAxMiBEZWMgMjAyNCAyMDo0MjowNCArMDgwMA0KU3ViamVjdDogW1BBVENIXSAg
ICBody9hcm0vYXNwZWVkOiBmaXggY29ubmVjdF9zZXJpYWxfaGRzX3RvX3VhcnRzDQoNCiAgIElu
IHRoZSBsb29wLCB3ZSBuZWVkIGlnbm9yZSB0aGUgaW5kZXggaW5jcmVhc2Ugd2hlbiB1YXJ0ID09
IHVhcnRfY2hvc2VuDQogICBXZSBzaG91bGQgaW5jcmVhc2UgdGhlIGluZGV4IG9ubHkgYWZ0ZXIg
d2UgYWxsb2NhdGUgYSBzZXJpYWwuDQoNClNpZ25lZC1vZmYtYnk6IEtlbm5ldGggSmlhIDxrZW5u
ZXRoX2ppYUBhc3VzLmNvbT4NCi0tLQ0KaHcvYXJtL2FzcGVlZC5jIHwgNCArKy0tDQoxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
aHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jDQppbmRleCA1NTY0OThmMmEwLi5kOGNi
MmQxNDI5IDEwMDY0NA0KLS0tIGEvaHcvYXJtL2FzcGVlZC5jDQorKysgYi9ody9hcm0vYXNwZWVk
LmMNCkBAIC0zNjQsMTEgKzM2NCwxMSBAQCBzdGF0aWMgdm9pZCBjb25uZWN0X3NlcmlhbF9oZHNf
dG9fdWFydHMoQXNwZWVkTWFjaGluZVN0YXRlICpibWMpDQogICAgIGludCB1YXJ0X2Nob3NlbiA9
IGJtYy0+dWFydF9jaG9zZW4gPyBibWMtPnVhcnRfY2hvc2VuIDogYW1jLT51YXJ0X2RlZmF1bHQ7
DQoNCiAgICAgYXNwZWVkX3NvY191YXJ0X3NldF9jaHIocywgdWFydF9jaG9zZW4sIHNlcmlhbF9o
ZCgwKSk7DQotICAgIGZvciAoaW50IGkgPSAxLCB1YXJ0ID0gc2MtPnVhcnRzX2Jhc2U7IGkgPCBz
Yy0+dWFydHNfbnVtOyBpKyssIHVhcnQrKykgew0KKyAgICBmb3IgKGludCBpID0gMSwgdWFydCA9
IHNjLT51YXJ0c19iYXNlOyBpIDwgc2MtPnVhcnRzX251bTsgdWFydCsrKSB7DQogICAgICAgICBp
ZiAodWFydCA9PSB1YXJ0X2Nob3Nlbikgew0KICAgICAgICAgICAgIGNvbnRpbnVlOw0KICAgICAg
ICAgfQ0KLSAgICAgICAgYXNwZWVkX3NvY191YXJ0X3NldF9jaHIocywgdWFydCwgc2VyaWFsX2hk
KGkpKTsNCisgICAgICAgIGFzcGVlZF9zb2NfdWFydF9zZXRfY2hyKHMsIHVhcnQsIHNlcmlhbF9o
ZChpKyspKTsNCiAgICAgfQ0KfQ0KDQotLQ0KMi4zNC4xDQo=

--_000_5f9b0c53f1644922ba85522046e92f4casuscom_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
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
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:=B5=C8=CF=DF;}
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
<p class=3D"MsoNormal"><span lang=3D"EN-US">From 24d3badbbb9dcc0d220609a7dd=
30f8da5002cba7 Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From: Kenneth Jia &lt;kenneth_j=
ia@asus.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Date: Thu, 12 Dec 2024 20:42:04=
 &#43;0800<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Subject: [PATCH]&nbsp;&nbsp;&nb=
sp; hw/arm/aspeed: fix connect_serial_hds_to_uarts<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; In the loop, we ne=
ed ignore the index increase when uart =3D=3D uart_chosen<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; We should increase=
 the index only after we allocate a serial.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Kenneth Jia &lt;=
kenneth_jia@asus.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">hw/arm/aspeed.c | 4 &#43;&#43;-=
-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1 file changed, 2 insertions(&#=
43;), 2 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/hw/arm/aspeed.c b/=
hw/arm/aspeed.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 556498f2a0..d8cb2d1429 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/hw/arm/aspeed.c<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/hw/arm/aspeed=
.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -364,11 &#43;364,11 @@ stati=
c void connect_serial_hds_to_uarts(AspeedMachineState *bmc)<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; int ua=
rt_chosen =3D bmc-&gt;uart_chosen ? bmc-&gt;uart_chosen : amc-&gt;uart_defa=
ult;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; aspeed=
_soc_uart_set_chr(s, uart_chosen, serial_hd(0));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; for (int i =
=3D 1, uart =3D sc-&gt;uarts_base; i &lt; sc-&gt;uarts_num; i&#43;&#43;, ua=
rt&#43;&#43;) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp; for (in=
t i =3D 1, uart =3D sc-&gt;uarts_base; i &lt; sc-&gt;uarts_num; uart&#43;&#=
43;) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (uart =3D=3D uart_chosen) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; aspeed_soc_uart_set_chr(s, uart, serial_hd(i));<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; aspeed_soc_uart_set_chr(s, uart, serial_hd(i&#43;&#43;));<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.34.1<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_5f9b0c53f1644922ba85522046e92f4casuscom_--

