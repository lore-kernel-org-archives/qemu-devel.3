Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740B0C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 18:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdDgn-0002Vf-OT; Thu, 22 Feb 2024 13:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1rdDgj-0002Uv-E4; Thu, 22 Feb 2024 13:20:53 -0500
Received: from hq-ms.auriga.com ([82.97.202.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1rdDgh-00045P-2X; Thu, 22 Feb 2024 13:20:53 -0500
Received: from HQ-MS1.office.auriga.msk (82.97.202.32) by
 hq-ms1.office.auriga.msk (82.97.202.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 22 Feb 2024 21:15:39 +0300
Received: from HQ-MS1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f]) by
 hq-ms1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f%7]) with mapi id
 15.02.1258.028; Thu, 22 Feb 2024 21:15:39 +0300
From: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
To: Peter Maydell <peter.maydell@linaro.org>, Sergey Kambalin
 <serg.oker@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 00/41] Raspberry Pi 4B machine
Thread-Topic: [PATCH v5 00/41] Raspberry Pi 4B machine
Thread-Index: AQHaYtGCfqkL7B0Tb0KILu02iBHW8bEWbf6AgABB86g=
Date: Thu, 22 Feb 2024 18:15:39 +0000
Message-ID: <caf1110f9e9445cab3aa00ebab24d263@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>,
 <CAFEAcA-Wir3M7dVV5247uMPxCtrYs8j4Z3S7nucCx3Ha8pA1dg@mail.gmail.com>
In-Reply-To: <CAFEAcA-Wir3M7dVV5247uMPxCtrYs8j4Z3S7nucCx3Ha8pA1dg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.55.54.50]
x-tm-as-product-ver: SMEX-14.0.0.1158-9.0.1002-28208.000
x-tm-as-result: No-10--23.857400-8.000000
x-tmase-matchedrid: h5TVo972vkSJVA+ukO+5MWg4D2QV/2zL6r3HCixfuKcc4ri4RJV/1W/R
 DAZTdSI3QnEYvg6//klFmXhQ6rgRVOyDy8V8lTWUzH6d90mb4+Ih6cl1707zKlZxVB3B2qbP6Xk
 ezPna397QLE3MitZAfl9/IWsrV5Ek1LFdtmiebE5itzfafzhYerzutTz14s8p0fmBwOcEOYMwrh
 SFC/dJGEZSxU13SYvpALYX+A8A0O0PTrDKsCYT0OKLvlSV0+r2rLALtod6A6ZmNqUsn94Y20FEM
 +pwiCobBt8n8fEuJJVX0KLFo/pn8fp4lWjAX1OzlOneJcroAxT3Oai+medFbKlOQjQcrzOl1jOm
 H0YwN7E45PBNB8uybZsbsj1AjTF7LdR5g5YGhzKj5gmRCefvLmHWZvjZxlUH33Nl3elSfsrGdRf
 PKx6LHMD46MsbWPCAmEKHz5YiYlQf0H3tYJmWPRMXUu1hb2VrrB85uDT3cKRvKpAGRBjcb9nfJr
 USEbFDd4EWkOs0kBZq+rSiPqZuvsQTSPZE5H8gOIQ9GP2P2u8cDDLReGt4PZTYluj+pBVBngIgp
 j8eDcAPEIloOPJwnn0GyL/mi/M8OMB0shqXhHpB7zALuogCGAYqv4YJG1FYtRdrdgLuMyW7mZq8
 BJXPF1kSgZIgXtrH
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--23.857400-8.000000
x-tmase-version: SMEX-14.0.0.1158-9.0.1002-28208.000
x-tm-snts-smtp: 87E843C24A95885FD72591806D2F0CB8A0A582E6A0C336A4E8704232656EEB592000:8
Content-Type: multipart/alternative;
 boundary="_000_caf1110f9e9445cab3aa00ebab24d263aurigacom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=82.97.202.32;
 envelope-from=sergey.kambalin@auriga.com; helo=hq-ms.auriga.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--_000_caf1110f9e9445cab3aa00ebab24d263aurigacom_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Hi Peter!

Sorry, it wasn't intentional.


How can I keep the tags from v4?


Thanks,
Sergey Kambalin
Software Developer,
Auriga Inc.


________________________________
=EF=D4: Peter Maydell <peter.maydell@linaro.org>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 22 =C6=C5=D7=D2=C1=CC=D1 2024 =C7. 11:17:07
=EB=CF=CD=D5: Sergey Kambalin
=EB=CF=D0=C9=D1: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Kambalin, Serg=
ey
=F4=C5=CD=C1: Re: [PATCH v5 00/41] Raspberry Pi 4B machine

On Mon, 19 Feb 2024 at 01:19, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Introducing Raspberry Pi 4B model.
> It contains new BCM2838 SoC, PCIE subsystem,
> RNG200, Thermal sensor and Genet network controller.
>
> It can work with recent linux kernels 6.x.x.
> Two avocado tests was added to check that.
>
> Unit tests has been made as read/write operations
> via mailbox properties.
>
> Genet integration test is under development.
>
> Every single commit
> 1) builds without errors
> 2) passes regression tests
> 3) passes style check*
> *the only exception is bcm2838-mbox-property-test.c file
> containing heavy macros usage which cause a lot of
> false-positives of checkpatch.pl.
>
> I did my best to keep the commits less than 200 changes,
> but had to make some of them a bit more in order to
> keep their integrity.
>
> This is v5 patchset with the most of v1..v4 comments fixed.

I reviewed quite a lot of v4, but I don't see any of
my Reviewed-by tags in this version. Did you really change
every patch so much you had to drop the tags?

thanks
-- PMM

--_000_caf1110f9e9445cab3aa00ebab24d263aurigacom_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dkoi8-r">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>Hi Peter!&nbsp;<br>
<br>
<span>Sorry, it wasn't intentional</span>.<br>
<br>
</p>
<p>How can I keep the tags from v4?</p>
<p><br>
</p>
<div id=3D"x_Signature">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;App=
le Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe =
UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p><span lang=3D"en-US"><font size=3D"3" face=3D"Calibri,Helvetica,sans-ser=
if" color=3D"black" style=3D"font-family:Calibri,Helvetica,sans-serif,serif=
,&quot;EmojiFont&quot;"><span dir=3D"ltr" id=3D"x_divtagdefaultwrapper" sty=
le=3D"font-size:12pt"><font size=3D"3" face=3D"Calibri,Helvetica,sans-serif=
,EmojiFont,Apple Color Emoji,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,=
Android Emoji,EmojiSymbols" color=3D"black"><span id=3D"x_divtagdefaultwrap=
per" style=3D"font-size:12pt"></span></font></span></font></span></p>
<font size=3D"3" face=3D"Calibri,Helvetica,sans-serif" color=3D"black" styl=
e=3D"font-family:Calibri,Helvetica,sans-serif,serif,&quot;EmojiFont&quot;">=
<font size=3D"3" face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color=
 Emoji,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSym=
bols" color=3D"black">
<div style=3D"margin-top:0; margin-bottom:0"><i><span style=3D"font-size:10=
pt">Thanks,</span></i></div>
<i><span style=3D"font-size:10pt"></span></i>
<div style=3D"margin-top:0; margin-bottom:0"><i><span style=3D"font-size:10=
pt">Sergey Kambalin</span></i><i><br>
</i></div>
<i><span style=3D"font-size:10pt"></span></i>
<div style=3D"margin-top:0; margin-bottom:0"><i><span style=3D"font-size:10=
pt">Software Developer,</span></i></div>
<div style=3D"margin-top:0; margin-bottom:0"><i><span style=3D"font-size:10=
pt"><span>Auriga Inc.</span><br>
</span></i></div>
</font></font><br>
<p></p>
</div>
</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=EF=D4:</b> Peter Maydell &lt=
;peter.maydell@linaro.org&gt;<br>
<b>=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:</b> 22 =C6=C5=D7=D2=C1=CC=D1 2024 =C7. 1=
1:17:07<br>
<b>=EB=CF=CD=D5:</b> Sergey Kambalin<br>
<b>=EB=CF=D0=C9=D1:</b> qemu-arm@nongnu.org; qemu-devel@nongnu.org; Kambali=
n, Sergey<br>
<b>=F4=C5=CD=C1:</b> Re: [PATCH v5 00/41] Raspberry Pi 4B machine</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Mon, 19 Feb 2024 at 01:19, Sergey Kambalin &lt;=
serg.oker@gmail.com&gt; wrote:<br>
&gt;<br>
&gt; Introducing Raspberry Pi 4B model.<br>
&gt; It contains new BCM2838 SoC, PCIE subsystem,<br>
&gt; RNG200, Thermal sensor and Genet network controller.<br>
&gt;<br>
&gt; It can work with recent linux kernels 6.x.x.<br>
&gt; Two avocado tests was added to check that.<br>
&gt;<br>
&gt; Unit tests has been made as read/write operations<br>
&gt; via mailbox properties.<br>
&gt;<br>
&gt; Genet integration test is under development.<br>
&gt;<br>
&gt; Every single commit<br>
&gt; 1) builds without errors<br>
&gt; 2) passes regression tests<br>
&gt; 3) passes style check*<br>
&gt; *the only exception is bcm2838-mbox-property-test.c file<br>
&gt; containing heavy macros usage which cause a lot of<br>
&gt; false-positives of checkpatch.pl.<br>
&gt;<br>
&gt; I did my best to keep the commits less than 200 changes,<br>
&gt; but had to make some of them a bit more in order to<br>
&gt; keep their integrity.<br>
&gt;<br>
&gt; This is v5 patchset with the most of v1..v4 comments fixed.<br>
<br>
I reviewed quite a lot of v4, but I don't see any of<br>
my Reviewed-by tags in this version. Did you really change<br>
every patch so much you had to drop the tags?<br>
<br>
thanks<br>
-- PMM<br>
</div>
</span></font>
</body>
</html>

--_000_caf1110f9e9445cab3aa00ebab24d263aurigacom_--

