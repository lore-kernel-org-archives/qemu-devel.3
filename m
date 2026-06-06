Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B41ACD8C8C
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 13:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVrNn-0002YD-Bj; Sat, 06 Jun 2026 09:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rongyichang@xiaomi.com>)
 id 1wVhHu-0003dM-3s
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 23:01:35 -0400
Received: from outboundhk.mxmail.xiaomi.com ([118.143.206.90])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rongyichang@xiaomi.com>) id 1wVhHq-0006V4-3l
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 23:01:29 -0400
X-CSE-ConnectionGUID: XhLQCZP7TRiB/JpD9polWQ==
X-CSE-MsgGUID: LMNVltFXR8yoePpPX6w/DQ==
X-IronPort-AV: E=Sophos;i="6.24,189,1774281600"; 
 d="scan'208,217";a="151895430"
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>
Subject: =?gb2312?B?tPC4tDogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCBxZW11XSB1aS9zZGwy?=
 =?gb2312?B?OiBhZGQgZ3JhYi1vbi10YWJsZXQgb3B0aW9uIGZvciBhYnNvbHV0ZSBpbnB1?=
 =?gb2312?Q?t_devices?=
Thread-Topic: [External Mail]Re: [PATCH qemu] ui/sdl2: add grab-on-tablet
 option for absolute input devices
Thread-Index: AQHc9QrzLXP+H0KPgk2jkMDCAfr3kLYw1kzJ
Date: Sat, 6 Jun 2026 03:01:13 +0000
Message-ID: <8d662e1969be4a9a89c0b38991986ebe@xiaomi.com>
References: <178065435170.20548.15372728064868431795-0@git.sr.ht>,
 <f54a2b09-f144-abc3-6163-563908c336a3@eik.bme.hu>
In-Reply-To: <f54a2b09-f144-abc3-6163-563908c336a3@eik.bme.hu>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.165]
Content-Type: multipart/alternative;
 boundary="_000_8d662e1969be4a9a89c0b38991986ebexiaomicom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=118.143.206.90;
 envelope-from=rongyichang@xiaomi.com; helo=outboundhk.mxmail.xiaomi.com
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Jun 2026 09:47:42 -0400
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
Reply-to:  =?gb2312?B?yNnS5bL9?= <rongyichang@xiaomi.com>
From:  =?gb2312?B?yNnS5bL9?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_8d662e1969be4a9a89c0b38991986ebexiaomicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KSWYgd2UgdXNlIGEgZ2VuZXJpYyBuYW1l
IGxpa2UgImNsaWNrLXRvLWdyYWIiIChub3QgdGFibGV0LXNwZWNpZmljKSwNCnNob3VsZCB3ZSBh
bHNvIGNvbnNpZGVyIHRoZSByZXZlcnNlIGRpcmVjdGlvbiChqiBpLmUuLCBhbGxvd2luZyByZWxh
dGl2ZQ0KKG1vdXNlKSBkZXZpY2VzIHRvIHVzZSB0aGUgdGFibGV0LXN0eWxlIGVkZ2UtdW5ncmFi
L3JlZ3JhYiBiZWhhdmlvcg0KdmlhIHNvbWV0aGluZyBsaWtlICJjbGljay10by1ncmFiPW9mZiI/
DQoNCkN1cnJlbnRseSByZWxhdGl2ZSBkZXZpY2VzIGFsd2F5cyB1c2UgY2xpY2stdG8tZ3JhYiwg
YW5kIGFic29sdXRlDQpkZXZpY2VzIGFsd2F5cyB1c2UgZWRnZS1iYXNlZCBhdXRvLWdyYWIuIElm
IHdlIG1ha2UgdGhpcyBhIGdlbmVyaWMNCnRvZ2dsZSwgdGhlIHNlbWFudGljcyB3b3VsZCBiZToN
Cg0KICAtZGlzcGxheSBzZGwsY2xpY2stdG8tZ3JhYj1vbiAgIKH6IGJvdGggZGV2aWNlIHR5cGVz
IHVzZSBjbGljay10by1ncmFiDQogIC1kaXNwbGF5IHNkbCxjbGljay10by1ncmFiPW9mZiAgofog
Ym90aCBkZXZpY2UgdHlwZXMgdXNlIGVkZ2UtdW5ncmFiDQoNCkhvd2V2ZXIsIGVkZ2UtdW5ncmFi
IGRvZXNuJ3QgcmVhbGx5IHdvcmsgZm9yIHJlbGF0aXZlIChtb3VzZSkgZGV2aWNlcywNCmJlY2F1
c2Ugb25jZSB0aGUgbW91c2UgZXNjYXBlcyB0aGUgd2luZG93LCBTREwgc3RvcHMgZGVsaXZlcmlu
ZyBtb3Rpb24NCmV2ZW50cyBhbmQgdGhlIGd1ZXN0IGN1cnNvciBiZWNvbWVzIHVuY29udHJvbGxh
YmxlLg0KDQpTbyBpbiBwcmFjdGljZSwgdGhpcyBvcHRpb24gY2FuIG9ubHkgbWVhbmluZ2Z1bGx5
IGNoYW5nZSBiZWhhdmlvciBmb3INCmFic29sdXRlIGRldmljZXMuIFRoYXQncyB3aHkgSSBjaG9z
ZSBhIHRhYmxldC1zcGVjaWZpYyBuYW1lIKGqIHRvIG1ha2UNCml0IGNsZWFyIHRoYXQgaXQgb25s
eSBhZmZlY3RzIGFic29sdXRlIGNvb3JkaW5hdGUgZGV2aWNlcy4NCg0KVGhhdCBzYWlkLCBJJ20g
b3BlbiB0byAiY2xpY2stdG8tZ3JhYj1vbnxvZmYiIGlmIHlvdSBwcmVmZXIgYSBtb3JlDQpnZW5l
cmljIG5hbWUuIFRoZSBpbXBsZW1lbnRhdGlvbiB3b3VsZCByZW1haW4gdGhlIHNhbWUgKG9ubHkg
YWZmZWN0aW5nDQphYnNvbHV0ZSBkZXZpY2VzKSwganVzdCB3aXRoIGEgbW9yZSBnZW5lcmFsIG5h
bWUuDQoNCldoYXQgZG8geW91IHRoaW5rPw0KDQpCZXN0IHJlZ2FyZHMsDQpZaWNoYW5nDQoNCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogQkFMQVRPTiBab2x0YW4g
PGJhbGF0b25AZWlrLmJtZS5odT4NCreiy83KsbzkOiAyMDI2xOo21MI2yNUgMDo0NzowMA0KytW8
/sjLOiDI2dLlsv0NCrOty806IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgbWFyY2FuZHJlLmx1cmVh
dUByZWRoYXQuY29tOyBhcm1icnVAcmVkaGF0LmNvbTsgZWJsYWtlQHJlZGhhdC5jb20NCtb3zOI6
IFtFeHRlcm5hbCBNYWlsXVJlOiBbUEFUQ0ggcWVtdV0gdWkvc2RsMjogYWRkIGdyYWItb24tdGFi
bGV0IG9wdGlvbiBmb3IgYWJzb2x1dGUgaW5wdXQgZGV2aWNlcw0KDQpbzeKyv9PKvP5dILTL08q8
/sC01LTT2tChw9e5q8u+zeKyv6Osx+u998n3tKbA7aGjyPS21NPKvP6wssir0NS05tLJo6zH672r
08q8/teqt6K4+G1pc2VjQHhpYW9taS5jb229+NDQt7TAoQ0KDQpPbiBGcmksIDUgSnVuIDIwMjYs
IH5yb25neWljaGFuZyB3cm90ZToNCj4gRnJvbTogcm9uZ3lpY2hhbmcgPHJvbmd5aWNoYW5nQHhp
YW9taS5jb20+DQo+DQo+IFdoZW4gdXNpbmcgYWJzb2x1dGUgY29vcmRpbmF0ZSBpbnB1dCBkZXZp
Y2VzIChlLmcuIHZpcnRpby10YWJsZXQtZGV2aWNlKSwNCj4gdGhlIFNETCBkaXNwbGF5IGJhY2tl
bmQgaW1wbGVtZW50cyBhICJzb2Z0IGdyYWIiIHdoZXJlIHRoZSBtb3VzZSBpcw0KPiBhdXRvbWF0
aWNhbGx5IGdyYWJiZWQgd2hlbiBpdCBlbnRlcnMgdGhlIHdpbmRvdyBpbnRlcmlvciBhbmQgdW5n
cmFiYmVkDQo+IHdoZW4gaXQgaGl0cyB0aGUgd2luZG93IGVkZ2UuIFRoaXMgZWRnZS11bmdyYWIg
YmVoYXZpb3IgY2F1c2VzIHByb2JsZW1zDQo+IGluIGVtYmVkZGVkIGVtdWxhdGlvbiBzY2VuYXJp
b3M6DQo+DQo+IDEuIE1vdXNlIGVzY2FwZXMgdGhlIFNETCB3aW5kb3cgYXQgZWRnZXMNCj4gMi4g
U0RMIGRvZXMgbm90IGRlbGl2ZXIgQlVUVE9OVVAgZXZlbnRzIGZvciB0aGUgZXNjYXBlZCBtb3Vz
ZQ0KPiAzLiBUaGUgZ3Vlc3QgZ2V0cyBzdHVjayBpbiBhIHByZXNzZWQvdG91Y2gtZG93biBzdGF0
ZQ0KPiA0LiBGaXJzdCBjbGljayBiYWNrIGludG8gdGhlIHdpbmRvdyBpcyBzaWxlbnRseSBkcm9w
cGVkDQo+DQo+IFRoaXMgaXNzdWUgaXMgY29uZmlybWVkIGFzIGEga25vd24gU0RMIGxpbWl0YXRp
b24gKFNETCBpc3N1ZSAjNTMwMSkuDQo+DQo+IEFkZCBhIG5ldyAtZGlzcGxheSBzZGwsZ3JhYi1v
bi10YWJsZXQ9b24gb3B0aW9uIHRoYXQgbWFrZXMgYWJzb2x1dGUNCj4gY29vcmRpbmF0ZSBkZXZp
Y2VzIHVzZSB0aGUgc2FtZSBncmFiIGJlaGF2aW9yIGFzIHJlbGF0aXZlIChtb3VzZSkNCj4gZGV2
aWNlczogdXNlciBtdXN0IGNsaWNrIHRvIGdyYWIsIEN0cmwrQWx0K0cgdG8gcmVsZWFzZSwgYW5k
IG5vDQo+IGF1dG9tYXRpYyBncmFiIG9uIHdpbmRvdyBlbnRlciBvciBlZGdlLWJhc2VkIHVuZ3Jh
Yi9yZWdyYWIuDQoNCk1heWJlIGl0J3MgYmV0dGVyIHRvIG5hbWUgdGhlIG9wdGlvbiBjbGljay10
by1ncmFiIG9yIGdyYWItb24tY2xpY2sgb3INCnNvbWV0aGluZyBzaW1pbGFyIGFzIHRoYXQncyB3
aGF0IGl0IGNoYW5nZXMgYW5kIG5vdCBzcGVjaWZpYyB0byB0YWJsZXRzLg0KDQpSZWdhcmRzLg0K
QkFMQVRPTiBab2x0YW4NCiMvKioqKioqsb7Tyrz+vLDG5Li9vP66rNPQ0KHD17mry761xLGjw9zQ
xc+io6y99s/e09q3osvNuPjJz8PmtdjWt9bQwdCz9rXEuPbIy7vyyLrX6aGjvfvWucjOus7G5Mv7
yMvS1MjOus7Qzsq9yrnTw6OosPzAqLWrsrvP3tPayKuyv7vysr+31rXY0LnCtqGiuLTWxqGiu/LJ
oreio6mxvtPKvP7W0LXE0MXPoqGjyOe5+8T6tO3K1cHLsb7Tyrz+o6zH68T6waK8tLXnu7C78tPK
vP7NqNaqt6K8/sjLsqLJvrP9sb7Tyrz+o6EgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50
cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMg
aW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBs
aXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4g
aW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRp
YWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25z
IG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5
b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioqKioqLyMNCg==

--_000_8d662e1969be4a9a89c0b38991986ebexiaomicom_
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
<p></p>
<div>Hi,</div>
<div><br>
</div>
<div>Thanks for the review.</div>
<div><br>
</div>
<div>If we use a generic name like &quot;click-to-grab&quot; (not tablet-sp=
ecific),</div>
<div>should we also consider the reverse direction =A1=AA i.e., allowing re=
lative</div>
<div>(mouse) devices to use the tablet-style edge-ungrab/regrab behavior</d=
iv>
<div>via something like &quot;click-to-grab=3Doff&quot;?</div>
<div><br>
</div>
<div>Currently relative devices always use click-to-grab, and absolute</div=
>
<div>devices always use edge-based auto-grab. If we make this a generic</di=
v>
<div>toggle, the semantics would be:</div>
<div><br>
</div>
<div>&nbsp; -display sdl,click-to-grab=3Don&nbsp; &nbsp;=A1=FA both device =
types use click-to-grab</div>
<div>&nbsp; -display sdl,click-to-grab=3Doff&nbsp; =A1=FA both device types=
 use edge-ungrab</div>
<div><br>
</div>
<div>However, edge-ungrab doesn't really work for relative (mouse) devices,=
</div>
<div>because once the mouse escapes the window, SDL stops delivering motion=
</div>
<div>events and the guest cursor becomes uncontrollable.</div>
<div><br>
</div>
<div>So in practice, this option can only meaningfully change behavior for<=
/div>
<div>absolute devices. That's why I chose a tablet-specific name =A1=AA to =
make</div>
<div>it clear that it only affects absolute coordinate devices.</div>
<div><br>
</div>
<div>That said, I'm open to &quot;click-to-grab=3Don|off&quot; if you prefe=
r a more</div>
<div>generic name. The implementation would remain the same (only affecting=
</div>
<div><span style=3D"font-size:12pt">absolute devices), just with a more gen=
eral name.</span></div>
<div><br>
</div>
<div>What do you think?</div>
<div><br>
</div>
<div>Best regards,</div>
<div>Yichang</div>
<br>
<p></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> BALAT=
ON Zoltan &lt;balaton@eik.bme.hu&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2026=C4=EA6=D4=C26=C8=D5 0:47:00<br>
<b>=CA=D5=BC=FE=C8=CB:</b> =C8=D9=D2=E5=B2=FD<br>
<b>=B3=AD=CB=CD:</b> qemu-devel@nongnu.org; marcandre.lureau@redhat.com; ar=
mbru@redhat.com; eblake@redhat.com<br>
<b>=D6=F7=CC=E2:</b> [External Mail]Re: [PATCH qemu] ui/sdl2: add grab-on-t=
ablet option for absolute input devices</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">[=CD=E2=B2=BF=D3=CA=BC=FE] =B4=CB=D3=CA=BC=FE=C0=
=B4=D4=B4=D3=DA=D0=A1=C3=D7=B9=AB=CB=BE=CD=E2=B2=BF=A3=AC=C7=EB=BD=F7=C9=F7=
=B4=A6=C0=ED=A1=A3=C8=F4=B6=D4=D3=CA=BC=FE=B0=B2=C8=AB=D0=D4=B4=E6=D2=C9=A3=
=AC=C7=EB=BD=AB=D3=CA=BC=FE=D7=AA=B7=A2=B8=F8misec@xiaomi.com=BD=F8=D0=D0=
=B7=B4=C0=A1<br>
<br>
On Fri, 5 Jun 2026, ~rongyichang wrote:<br>
&gt; From: rongyichang &lt;rongyichang@xiaomi.com&gt;<br>
&gt;<br>
&gt; When using absolute coordinate input devices (e.g. virtio-tablet-devic=
e),<br>
&gt; the SDL display backend implements a &quot;soft grab&quot; where the m=
ouse is<br>
&gt; automatically grabbed when it enters the window interior and ungrabbed=
<br>
&gt; when it hits the window edge. This edge-ungrab behavior causes problem=
s<br>
&gt; in embedded emulation scenarios:<br>
&gt;<br>
&gt; 1. Mouse escapes the SDL window at edges<br>
&gt; 2. SDL does not deliver BUTTONUP events for the escaped mouse<br>
&gt; 3. The guest gets stuck in a pressed/touch-down state<br>
&gt; 4. First click back into the window is silently dropped<br>
&gt;<br>
&gt; This issue is confirmed as a known SDL limitation (SDL issue #5301).<b=
r>
&gt;<br>
&gt; Add a new -display sdl,grab-on-tablet=3Don option that makes absolute<=
br>
&gt; coordinate devices use the same grab behavior as relative (mouse)<br>
&gt; devices: user must click to grab, Ctrl&#43;Alt&#43;G to release, and n=
o<br>
&gt; automatic grab on window enter or edge-based ungrab/regrab.<br>
<br>
Maybe it's better to name the option click-to-grab or grab-on-click or<br>
something similar as that's what it changes and not specific to tablets.<br=
>
<br>
Regards.<br>
BALATON Zoltan<br>
</div>
</span></font>#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=
=D0=D0=A1=C3=D7=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=
=D3=DA=B7=A2=CB=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=
=F6=C8=CB=BB=F2=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=
=D2=D4=C8=CE=BA=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=
=DE=D3=DA=C8=AB=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=
=A1=A2=BB=F2=C9=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=
=A3=C8=E7=B9=FB=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=
=C1=A2=BC=B4=B5=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=
=A2=C9=BE=B3=FD=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments con=
tain confidential information from XIAOMI, which is intended only for the p=
erson or
 entity whose address is listed above. Any use of the information contained=
 herein in any way (including, but not limited to, total or partial disclos=
ure, reproduction, or dissemination) by persons other than the intended rec=
ipient(s) is prohibited. If you
 receive this e-mail in error, please notify the sender by phone or email i=
mmediately and delete it!******/#
</body>
</html>

--_000_8d662e1969be4a9a89c0b38991986ebexiaomicom_--

