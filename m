Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914E4C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 04:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1repUE-0005Ob-JP; Mon, 26 Feb 2024 23:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1repUC-0005Nj-GN; Mon, 26 Feb 2024 23:54:36 -0500
Received: from hq-ms.auriga.com ([82.97.202.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1repU8-0003sW-R5; Mon, 26 Feb 2024 23:54:35 -0500
Received: from HQ-MS1.office.auriga.msk (82.97.202.32) by
 hq-ms1.office.auriga.msk (82.97.202.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 07:54:25 +0300
Received: from HQ-MS1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f]) by
 hq-ms1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f%7]) with mapi id
 15.02.1258.028; Tue, 27 Feb 2024 07:54:25 +0300
From: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?gb2312?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkqKY=?= <philmd@linaro.org>
CC: Sergey Kambalin <serg.oker@gmail.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 11/41] Temporarily disable unimplemented rpi4b devices
Thread-Topic: [PATCH v6 11/41] Temporarily disable unimplemented rpi4b devices
Thread-Index: AQHaaEc6YuEUwcJh2EK2QOCCGQCXr7EcbnsAgAABPwCAACjVAIAACeWAgAD9wcM=
Date: Tue, 27 Feb 2024 04:54:25 +0000
Message-ID: <4297f93fcef5486082744993da1430b2@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-12-sergey.kambalin@auriga.com>
 <2ab7b523-816b-409b-a58a-f09e3f71ff8e@linaro.org>
 <CAFEAcA-WwWQnAQTmoCixaW5aeRWrdx__YoSHp_VyGEbk-rOkpg@mail.gmail.com>
 <df5f7f10-41ba-4c2e-8d50-9d35203d940a@linaro.org>,
 <CAFEAcA8D45XrBBL1f7SxBCVD6vUO+Yvsxko7Kx91qgEbzrXG2w@mail.gmail.com>
In-Reply-To: <CAFEAcA8D45XrBBL1f7SxBCVD6vUO+Yvsxko7Kx91qgEbzrXG2w@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [201.203.117.224]
x-tm-as-product-ver: SMEX-14.0.0.1158-9.0.1002-28216.005
x-tm-as-result: No-10--21.119300-8.000000
x-tmase-matchedrid: HSR30PgxbmSJVA+ukO+5MWg4D2QV/2zL6r3HCixfuKcc4ri4RJV/1W/R
 DAZTdSI3QnEYvg6//klFmXhQ6rgRVOyDy8V8lTWUzH6d90mb4+Ih6cl1707zKlZxVB3B2qbP6Xk
 ezPna397QLE3MitZAfl9/IWsrV5Ek1LFdtmiebE5itzfafzhYerzutTz14s8pB4N9b2b2Ot4/2z
 5u7TubFAIwhzm9NC1TpgolEZSL3/yz4NrOslvOzl/ZJ0h1vLl1yqyllX6UJIudR6+/ciGZAfbDH
 OYOZbX4beErIfiu8GZlrLxd1tqooBbgKoOAPCuuL4+sB3yBscndvovMm13clRKiNb69EtW/yYIi
 Bm/4N4sJ2N6lvoKB0qy8ojY+JYM93EFo0BgyYlmzRPQ8T4oe5WCHSksKltZjQaizph4jN8MHBNw
 MIojZciDBePRktFgrasTfiNU8Iol8y08qUfybyEfhraIl1XgxMVx/3ZYby7+4GyTmeN+AbLoS0G
 HxlnK45ZHdquAwKoHzFueD9gdrXWR5WlY/ZLL5olVO7uyOCDWUO3k9AyCPTdbZhgeyVPQj1Ieck
 OrbKEygQHW2OnNQW4pv+QMT5WBbKBTLaHqiE4AEOhHzDsL05jiSnQGKjk61fQccuHmatJuFrghe
 PSnjN2N7PTAmkNnglETKOSy0ENRLvya6rP8regcbMHjYNxGhhZApJAdFDDabKItl61J/ye0BHTk
 Ec6okqL+IMxNwhQ7VuWxchefT7ExpKBY5Y2zCmaYBWdD2mOqRePDckBJ6a37cGd19dSFd
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--21.119300-8.000000
x-tmase-version: SMEX-14.0.0.1158-9.0.1002-28216.005
x-tm-snts-smtp: 7508ADE0C0366D2462AF5AF20EE6817C260201F29B5E675FCFD8DD68D848D28D2000:8
Content-Type: multipart/alternative;
 boundary="_000_4297f93fcef5486082744993da1430b2aurigacom_"
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

--_000_4297f93fcef5486082744993da1430b2aurigacom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgUGV0ZXIgYW5kIFBoaWxpcHBlIQ0KDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyBhbmQg
ZmVlZGJhY2shDQoNCg0KT0ssIEknbGwgZml4IFBDSUUtcmVsYXJ0ZWQgY29tbWVudHMgYW5kIHRo
ZSBvdmVybGFwcGluZyBpc3N1ZQ0KDQoNCkJSLA0KU2VyZ2V5IEthbWJhbGluDQpTb2Z0d2FyZSBE
ZXZlbG9wZXIsDQpBdXJpZ2EgSW5jLg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQqnsKfkOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQqnsKfk
p+Gn4qfRp9On3afWp9+n4DogMjYgp+an1qfTp+Kn0afdp/EgMjAyNCCn1C4gMTA6NDE6MzENCqes
p+Cn3qflOiBQaGlsaXBwZSBNYXRoaWV1LURhdWSopg0Kp6yn4Kfhp9qn8TogU2VyZ2V5IEthbWJh
bGluOyBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IEthbWJhbGlu
LCBTZXJnZXkNCqe0p9an3qfROiBSZTogW1BBVENIIHY2IDExLzQxXSBUZW1wb3JhcmlseSBkaXNh
YmxlIHVuaW1wbGVtZW50ZWQgcnBpNGIgZGV2aWNlcw0KDQpPbiBNb24sIDI2IEZlYiAyMDI0IGF0
IDE2OjA2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWSopiA8cGhpbG1kQGxpbmFyby5vcmc+IHdyb3Rl
Og0KPg0KPiBPbiAyNi8yLzI0IDE0OjM5LCBQZXRlciBNYXlkZWxsIHdyb3RlOg0KPiA+IE9uIE1v
biwgMjYgRmViIDIwMjQgYXQgMTM6MzUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZKimIDxwaGlsbWRA
bGluYXJvLm9yZz4gd3JvdGU6DQo+ID4+DQo+ID4+IE9uIDI2LzIvMjQgMDE6MDIsIFNlcmdleSBL
YW1iYWxpbiB3cm90ZToNCj4gPj4+ICtzdGF0aWMgdm9pZCByYXNwaTRfbW9kaWZ5X2R0Yihjb25z
dCBzdHJ1Y3QgYXJtX2Jvb3RfaW5mbyAqaW5mbywgdm9pZCAqZmR0KQ0KPiA+Pj4gK3sNCj4gPj4+
ICsgICAgdWludDY0X3QgcmFtX3NpemU7DQo+ID4+PiArDQo+ID4+PiArICAgIC8qIFRlbXBvcmFy
aWx5IGRpc2FibGUgZm9sbG93aW5nIGRldmljZXMgdW50aWwgdGhleSBhcmUgaW1wbGVtZW50ZWQg
Ki8NCj4gPj4+ICsgICAgY29uc3QgY2hhciAqbm9kZXNfdG9fcmVtb3ZlW10gPSB7DQo+ID4+PiAr
ICAgICAgICAiYnJjbSxiY20yNzExLXBjaWUiLA0KPiA+Pj4gKyAgICAgICAgImJyY20sYmNtMjcx
MS1ybmcyMDAiLA0KPiA+Pj4gKyAgICAgICAgImJyY20sYmNtMjcxMS10aGVybWFsIiwNCj4gPj4+
ICsgICAgICAgICJicmNtLGJjbTI3MTEtZ2VuZXQtdjUiLA0KPiA+Pj4gKyAgICB9Ow0KPiA+Pj4g
Kw0KPiA+Pj4gKyAgICBmb3IgKGludCBpID0gMDsgaSA8IEFSUkFZX1NJWkUobm9kZXNfdG9fcmVt
b3ZlKTsgaSsrKSB7DQo+ID4+PiArICAgICAgICBjb25zdCBjaGFyICpkZXZfc3RyID0gbm9kZXNf
dG9fcmVtb3ZlW2ldOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICAgaW50IG9mZnNldCA9IGZkdF9u
b2RlX29mZnNldF9ieV9jb21wYXRpYmxlKGZkdCwgLTEsIGRldl9zdHIpOw0KPiA+Pj4gKyAgICAg
ICAgaWYgKG9mZnNldCA+PSAwKSB7DQo+ID4+PiArICAgICAgICAgICAgaWYgKCFmZHRfbm9wX25v
ZGUoZmR0LCBvZmZzZXQpKSB7DQo+ID4+DQo+ID4+IFBldGVyLCBJIHJlbWVtYmVyIGEgZGlzY3Vz
c2lvbiB3aGVyZSB5b3Ugd3JlIG5vdCBrZWVuIG9uIGFsdGVyaW5nIERUQg0KPiA+PiBmb3Igbm9u
LVZpcnQgbWFjaGluZXMuDQo+ID4+DQo+ID4+IFNpbmNlIHRoZXNlIGRldmljZXMgYXJlIGFsbCBp
bXBsZW1lbnRlZCBhdCB0aGUgZW5kIG9mIHRoZSBzZXJpZXMsIHdoeQ0KPiA+PiBub3QgYWRkIHRo
ZSBkZXZpY2VzIHRoZW4gdGhlIHJhc3BpNCBib2FyZCBhdCB0aGUgZW5kLCBzbyB0aGlzIHBhdGNo
IGlzDQo+ID4+IG5vdCBldmVuIHJlcXVpcmVkPw0KPiA+DQo+ID4gSSdtIG5vdCBzdXBlci1rZWVu
IG9uIGl0LCBidXQgYXMgeW91IHNheSBpdCBnb2VzIGF3YXkgb25jZSBhbGwNCj4gPiB0aGUgZGV2
aWNlcyBhcmUgaW1wbGVtZW50ZWQsIHNvIEknbSBub3QgdG9vIHdvcnJpZWQuDQo+ID4NCj4gPiBE
b2luZyBpdCB0aGlzIHdheSBhcm91bmQgd291bGQgbGV0IHVzIHRha2UgdGhlIGZpcnN0IDExIHBh
dGNoZXMNCj4gPiBpbiB0aGUgc2VyaWVzIGludG8gZ2l0IG5vdyAodGhleSd2ZSBhbGwgYmVlbiBy
ZXZpZXdlZCksIHdoaWNoDQo+ID4gZ2l2ZXMgdXMgKEkgdGhpbmspIGEgZnVuY3Rpb25hbCByYXNw
aTQgd2l0aCBzb21lIG1pc3NpbmcgZGV2aWNlcywNCj4gPiB3aGljaCBzZWVtcyB1c2VmdWwgaW4g
dGhlIGludGVyaW0gdW50aWwgdGhlIHJlc3Qgb2YgdGhlIHNlcmllcw0KPiA+IGdldHMgcmV2aWV3
ZWQgYW5kIGNvbW1pdHRlZC4NCj4NCj4gRmluZSBieSBtZSEgU2VyZ2V5LCBkb24ndCB3ZSBhbHNv
IG5lZWQgcGF0Y2ggIzM5IChBZGQgbWlzc2VkIEJDTTI4MzUNCj4gcHJvcGVydGllcykgdG8gaGF2
ZSBhIGhhcHB5IExpbnV4IGJvb3Q/DQo+DQo+IFBhdGNoICMxNyAiSW1wbGVtZW50IEJDTTI4Mzgg
dGhlcm1hbCBzZW5zb3IiIGNvdWxkIGFsc28gZ28gaW4gYnV0IGl0DQo+IGRvZXNuJ3QgYXBwbHkg
Y2xlYW5seSBvbiB0b3Agb2YgMS0xMik7IG1heWJlIFNlcmdleSBjYW4gc2VuZCBhIHNlcmllcw0K
PiBvZiAicGF0Y2hlcyBhbHJlYWR5IHJldmlld2VkIiBvbiB0b3Agc28gdGhleSBnZXQgaW4gZm9y
IHY5LCBwb3N0cG9uaW5nDQo+IHBjaWUvbmV0d29yayBmb3IgYWZ0ZXIgcmVsZWFzZS4NCg0KSSds
bCBwdXQgdG9nZXRoZXIgYSBwdWxscmVxIHRvbW9ycm93IChzZWUgbXkgb3RoZXIgZW1haWwgZm9y
IGRldGFpbHMNCm9mIHdoaWNoIHBhdGNoZXMgcGx1cyB0aGUgbmVjZXNzYXJ5IGNoYW5nZXMgdG8g
dGhlIGF2b2NhZG8gdGVzdHMpLg0KU2VyZ2V5IC0tIEkgc3VnZ2VzdCB5b3Ugd2FpdCB0aWwgdGhh
dCBnZXRzIHVwc3RyZWFtLCBhbmQgdGhlbg0KcmViYXNlIG9uIHRoYXQuDQoNCi0tIFBNTQ0K

--_000_4297f93fcef5486082744993da1430b2aurigacom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
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
<p>Hi Peter and Philippe!</p>
<p><br>
</p>
<p>Thank you for the review and feedback!<br>
</p>
<p><br>
</p>
<p>OK, I'll fix PCIE-relarted comments and the overlapping issue<br>
</p>
<p><br>
</p>
<div id=3D"x_Signature">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quo=
t;,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,=
&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
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
pt">BR,</span></i></div>
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
color=3D"#000000" style=3D"font-size:11pt"><b>=A7=B0=A7=E4:</b> Peter Mayde=
ll &lt;peter.maydell@linaro.org&gt;<br>
<b>=A7=B0=A7=E4=A7=E1=A7=E2=A7=D1=A7=D3=A7=DD=A7=D6=A7=DF=A7=E0:</b> 26 =A7=
=E6=A7=D6=A7=D3=A7=E2=A7=D1=A7=DD=A7=F1 2024 =A7=D4. 10:41:31<br>
<b>=A7=AC=A7=E0=A7=DE=A7=E5:</b> Philippe Mathieu-Daud=A8=A6<br>
<b>=A7=AC=A7=E0=A7=E1=A7=DA=A7=F1:</b> Sergey Kambalin; qemu-arm@nongnu.org=
; qemu-devel@nongnu.org; Kambalin, Sergey<br>
<b>=A7=B4=A7=D6=A7=DE=A7=D1:</b> Re: [PATCH v6 11/41] Temporarily disable u=
nimplemented rpi4b devices</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Mon, 26 Feb 2024 at 16:06, Philippe Mathieu-Dau=
d=A8=A6 &lt;philmd@linaro.org&gt; wrote:<br>
&gt;<br>
&gt; On 26/2/24 14:39, Peter Maydell wrote:<br>
&gt; &gt; On Mon, 26 Feb 2024 at 13:35, Philippe Mathieu-Daud=A8=A6 &lt;phi=
lmd@linaro.org&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 26/2/24 01:02, Sergey Kambalin wrote:<br>
&gt; &gt;&gt;&gt; &#43;static void raspi4_modify_dtb(const struct arm_boot_=
info *info, void *fdt)<br>
&gt; &gt;&gt;&gt; &#43;{<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; uint64_t ram_size;<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* Temporarily disable following =
devices until they are implemented */<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; const char *nodes_to_remove[] =3D=
 {<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;brc=
m,bcm2711-pcie&quot;,<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;brc=
m,bcm2711-rng200&quot;,<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;brc=
m,bcm2711-thermal&quot;,<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;brc=
m,bcm2711-genet-v5&quot;,<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; };<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; for (int i =3D 0; i &lt; ARRAY_SI=
ZE(nodes_to_remove); i&#43;&#43;) {<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const cha=
r *dev_str =3D nodes_to_remove[i];<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int offse=
t =3D fdt_node_offset_by_compatible(fdt, -1, dev_str);<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offse=
t &gt;=3D 0) {<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!fdt_nop_node(fdt, offset)) {<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Peter, I remember a discussion where you wre not keen on alte=
ring DTB<br>
&gt; &gt;&gt; for non-Virt machines.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Since these devices are all implemented at the end of the ser=
ies, why<br>
&gt; &gt;&gt; not add the devices then the raspi4 board at the end, so this=
 patch is<br>
&gt; &gt;&gt; not even required?<br>
&gt; &gt;<br>
&gt; &gt; I'm not super-keen on it, but as you say it goes away once all<br=
>
&gt; &gt; the devices are implemented, so I'm not too worried.<br>
&gt; &gt;<br>
&gt; &gt; Doing it this way around would let us take the first 11 patches<b=
r>
&gt; &gt; in the series into git now (they've all been reviewed), which<br>
&gt; &gt; gives us (I think) a functional raspi4 with some missing devices,=
<br>
&gt; &gt; which seems useful in the interim until the rest of the series<br=
>
&gt; &gt; gets reviewed and committed.<br>
&gt;<br>
&gt; Fine by me! Sergey, don't we also need patch #39 (Add missed BCM2835<b=
r>
&gt; properties) to have a happy Linux boot?<br>
&gt;<br>
&gt; Patch #17 &quot;Implement BCM2838 thermal sensor&quot; could also go i=
n but it<br>
&gt; doesn't apply cleanly on top of 1-12); maybe Sergey can send a series<=
br>
&gt; of &quot;patches already reviewed&quot; on top so they get in for v9, =
postponing<br>
&gt; pcie/network for after release.<br>
<br>
I'll put together a pullreq tomorrow (see my other email for details<br>
of which patches plus the necessary changes to the avocado tests).<br>
Sergey -- I suggest you wait til that gets upstream, and then<br>
rebase on that.<br>
<br>
-- PMM<br>
</div>
</span></font>
</body>
</html>

--_000_4297f93fcef5486082744993da1430b2aurigacom_--

