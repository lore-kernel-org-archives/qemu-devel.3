Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910D3C27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 08:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFVP5-0004TD-Pv; Fri, 07 Jun 2024 04:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1sFVP1-0004RK-LD; Fri, 07 Jun 2024 04:56:51 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1sFVOv-0001rn-Kv; Fri, 07 Jun 2024 04:56:51 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnw89y2JmH0EMAA--.5408S2;
 Fri, 07 Jun 2024 16:56:29 +0800 (CST)
Received: from DESKTOP-E65K6PP (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDnkdc7y2Jmf7YAAA--.1076S3;
 Fri, 07 Jun 2024 16:56:28 +0800 (CST)
Date: Fri, 7 Jun 2024 16:56:28 +0800
From: "xiongyining1480@phytium.com.cn" <xiongyining1480@phytium.com.cn>
To: "Marcin Juszkiewicz" <marcin.juszkiewicz@linaro.org>, 
 qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: rad <rad@semihalf.com>, peter.maydell <peter.maydell@linaro.org>, 
 quic_llindhol <quic_llindhol@quicinc.com>
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa
 machine
References: <20240426073553.326946-1-xiongyining1480@phytium.com.cn>, 
 <20240426073553.326946-2-xiongyining1480@phytium.com.cn>, 
 <456d4233-a1b3-41fb-9fd9-e89a4fbb5c18@linaro.org>
X-Priority: 3
X-GUID: E96D04C6-96C5-426E-8177-65651E3E14A7
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.228[cn]
Mime-Version: 1.0
Message-ID: <2024060716413143583852@phytium.com.cn>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart835020623601_=----"
X-CM-TRANSID: AQAAfwDnkdc7y2Jmf7YAAA--.1076S3
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQAJBmZiD2QDeAABsb
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=xiongyinin
 g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7AryfKrWfGrWUAF17uryrXrb_yoW8AF4rpF
 WUtrnIyw1DCrWDCa17Wa4xur95uw15uayUtry0qFWktr98ua18CrnxKanY9ry7G348K34j
 vws2k34Uua90v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=xiongyining1480@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL=1.31, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This is a multi-part message in MIME format.

------=_001_NextPart835020623601_=----
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQp4aW9uZ3lpbmluZzE0ODBAcGh5dGl1bS5jb20uY24NCiANCkZyb206IE1hcmNpbiBK
dXN6a2lld2ljeg0KRGF0ZTogMjAyNC0wNS0yNCAwMjo0Nw0KVG86IFhpb25nIFlpbmluZzsgcWVt
dS1hcm07IHFlbXUtZGV2ZWwNCkNDOiByYWQ7IHBldGVyLm1heWRlbGw7IHF1aWNfbGxpbmRob2wN
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS8xXSBody9hcm0vc2JzYS1yZWY6IEVuYWJsZSBDUFUg
Y2x1c3RlciBvbiBBUk0gc2JzYSBtYWNoaW5lDQpXIGRuaXUgMjYuMDQuMjAyNCBvIDA5OjM1LCBY
aW9uZyBZaW5pbmcgcGlzemU6DQo+IEZyb206IHhpb25neWluaW5nMTQ4MDx4aW9uZ3lpbmluZzE0
ODBAcGh5dGl1bS5jb20uY24+DQo+IA0KPiBFbmFibGUgQ1BVIGNsdXN0ZXIgc3VwcG9ydCBvbiBT
YnNhUWVtdSBwbGF0Zm9ybSwgc28gdGhhdCB1c2VycyBjYW4NCj4gc3BlY2lmeSBhIDQtbGV2ZWwg
Q1BVIGhpZXJhcmNoeSBzb2NrZXRzL2NsdXN0ZXJzL2NvcmVzL3RocmVhZHMuIEFuZA0KPiB0aGlz
IHRvcG9sb2d5IGNhbiBiZSBwYXNzZWQgdG8gdGhlIGZpcm13YXJlIHRocm91Z2ggRFQgY3B1LW1h
cC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFhpb25nIFlpbmluZzx4aW9uZ3lpbmluZzE0ODBAcGh5
dGl1bS5jb20uY24+DQo+IHRlc3RlZC1ieTogTWFyY2luIEp1c3praWV3aWN6PG1hcmNpbi5qdXN6
a2lld2ljekBsaW5hcm8ub3JnPg0KIA0KPkkgaGFkIHNvbWUgdGhpbmtpbmcgYWJvdXQgaXQgcmVj
ZW50bHkuIFRoaXMgcGF0Y2ggZXhwb3J0ZWQgd2hvbGUgDQo+L2NwdXMvY3B1LW1hcC8gdHJlZSB3
aGljaCB3ZSB0aGVuIHBhcnNlIGluIFRGLUEgdG8gZ2V0IGFtb3VudCBvZiANCj5zb2NrZXRzL2Ns
dXN0ZXJzL2NvcmVzL3RocmVhZHMuDQogDQo+V2h5IG5vdCBleHBvcnQgdGhlbSBkaXJlY3RseT8g
S2luZCBvZjoNCj4gDQo+ICAgICAgICBjcHVzIHsNCj4gICAgICAgICAgICAgICAgIHRvcG9sb2d5
IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdGhyZWFkcyA9IDwweDAxPjsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgY29yZXMgPSA8MHgwND47DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGNsdXN0ZXJzID0gPDB4MDE+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzb2NrZXRz
ID0gPDB4MDE+Ow0KPiAgICAgICAgICAgICAgICAgfTsNCj4gDQo+SXQgZ2l2ZXMgZXZlcnl0aGlu
ZyB3ZSBuZWVkLg0KDQpGdWxseSBhZ3JlZS4NCiANCj5IYWQgc29tZSB0aGlua2luZyBhYm91dCBl
eHBvcnRpbmcgYW1vdW50IG9mIGNvcmVzIHBlciBjbHVzdGVyICg4IG5vdywgDQo+dmlydCB1c2Vz
IDE2IHdoaWNoIGlzIGFyY2hpdGVjdHVyZSBtYXhpbXVtIG5vdykgaW4gY2FzZSB3ZSB3b3VsZCB1
c2UgaXQgDQo+aW4gZ2VuZXJhdGlvbiBvZiBQUFRUIGluIEVESzIuDQoNCkkgZG9uJ3QgZnVsbHkg
dW5kZXJzdGFuZCAidGhlIGFtb3VudCBvZiBjb3JlcyBwZXIgY2x1c3RlciIsIGRvZXMgaXQgbWVh
bnMgdGhlIHVzZXIgY29uZmlnOiAtc21wIGNsdXN0ZXJzPVgsIGNvcmVzPVkgd2hpY2ggaW5kaWNh
dGVzDQp0aGUgbnVtYmVyIG9mIGNvcmVzIGluIG9uZSBjbHVzdGVyIGlzIFksIG9yIHRoZSBBRkYw
L0FGRjEgaW4gTVBESVI/DQoNClRoZSBjcHUgdG9wb2xvZ3kgaXMgZGVmaW5lZCBieSB0aGUgdXNl
ciBvbiBjb21tYW5kIGxpbmUgd2hpY2ggUFBUVCB3YW50IHRvIGFsaWduIHdpdGguICBBbmQgdGhl
IHZhbHVlIG9mIEFGRjAvQUZGMSBpcyBnZW5lcmFsbHkgDQo4IG9yIDE2IHdoaWNoIHdpbGwgbm90
IGFmZmVjdGVkIGJ5ICBvcHRpb24gLXNtcCBjb21tYW5kLiAgIENvbnNpZGVyaW5nIHRoYXQgTVBE
SVIgY2Fubm90IHJlZmxlY3QgdGhlIGNwdSB0b3BvbG9neSBjb25maWd1cmF0ZWQgYnkgDQp1c2Vy
LCBpIGd1ZXNzIHRoZSBQUFRUICBkb24ndCBuZWVkIHRvIHVzZSB0aGUgTVBESVIgdmFsdWUuDQoN
Cg==

------=_001_NextPart835020623601_=----
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DUTF-8"><style>body { line-height: 1.5; }blockquote { margin-top: 0px; =
margin-bottom: 0px; margin-left: 0.5em; }body { font-size: 14px; font-fami=
ly: "Microsoft YaHei UI"; color: rgb(0, 0, 0); line-height: 1.5; }</style>=
</head><body>=0A<div><span></span><br></div>=0A<div><br></div><hr style=3D=
"width: 210px; height: 1px;" color=3D"#b5c4df" size=3D"1" align=3D"left">=
=0A<div><span><div style=3D"MARGIN: 10px; FONT-FAMILY: verdana; FONT-SIZE:=
 10pt"><div>xiongyining1480@phytium.com.cn</div></div></span></div>=0A<blo=
ckquote style=3D"margin-Top: 0px; margin-Bottom: 0px; margin-Left: 0.5em; =
margin-Right: inherit"><div>&nbsp;</div><div style=3D"border:none;border-t=
op:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm"><div style=3D"PADDING-RI=
GHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;FONT-FAMILY:tahoma;COLOR:#000=
000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px; PADDING-TOP: 8px"><div><b>F=
rom:</b>&nbsp;<a href=3D"mailto:marcin.juszkiewicz@linaro.org">Marcin Jusz=
kiewicz</a></div><div><b>Date:</b>&nbsp;2024-05-24&nbsp;02:47</div><div><b=
>To:</b>&nbsp;<a href=3D"mailto:xiongyining1480@phytium.com.cn">Xiong Yini=
ng</a>; <a href=3D"mailto:qemu-arm@nongnu.org">qemu-arm</a>; <a href=3D"ma=
ilto:qemu-devel@nongnu.org">qemu-devel</a></div><div><b>CC:</b>&nbsp;<a hr=
ef=3D"mailto:rad@semihalf.com">rad</a>; <a href=3D"mailto:peter.maydell@li=
naro.org" class=3D"">peter.maydell</a>; <a href=3D"mailto:quic_llindhol@qu=
icinc.com" class=3D"">quic_llindhol</a></div><div><b>Subject:</b>&nbsp;Re:=
 [PATCH v4 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa machine</d=
iv></div></div><div><div>W dniu 26.04.2024 o&nbsp;09:35, Xiong Yining pisz=
e:</div>=0A<div>&gt; From: xiongyining1480&lt;xiongyining1480@phytium.com.=
cn&gt;</div>=0A<div>&gt; </div>=0A<div>&gt; Enable CPU cluster support on =
SbsaQemu platform, so that users can</div>=0A<div>&gt; specify a 4-level C=
PU hierarchy sockets/clusters/cores/threads. And</div>=0A<div>&gt; this to=
pology can be passed to the firmware through DT cpu-map.</div>=0A<div>&gt;=
 </div>=0A<div>&gt; Signed-off-by: Xiong Yining&lt;xiongyining1480@phytium=
.com.cn&gt;</div>=0A<div>&gt; tested-by: Marcin Juszkiewicz&lt;marcin.jusz=
kiewicz@linaro.org&gt;</div>=0A<div>&nbsp;</div>=0A<div>&gt;I had some thi=
nking about it recently. This patch exported whole </div>=0A<div>&gt;/cpus=
/cpu-map/ tree which we then parse in TF-A to get amount of </div>=0A<div>=
&gt;sockets/clusters/cores/threads.</div>=0A<div>&nbsp;</div>=0A<div>&gt;W=
hy not export them directly? Kind of:</div>=0A<div>&gt;&nbsp;</div>=0A<div=
>&gt;&nbsp; &nbsp; &nbsp; &nbsp; cpus {</div>=0A<div>&gt;&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;topology {</div>=0A<div>&gt;&=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp;threads =3D &lt;0x01&gt;;</div>=0A<div>&gt;&nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
cores =3D &lt;0x04&gt;;</div>=0A<div>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;clusters =3D &lt;=
0x01&gt;;</div>=0A<div>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sockets =3D &lt;0x01&gt;;</div>=
=0A<div>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
};</div>=0A<div>&gt;&nbsp;</div>=0A<div>&gt;It gives everything we need.</=
div><div><br></div><div>Fully agree.</div>=0A<div>&nbsp;</div>=0A<div>&gt;=
Had some thinking about exporting amount of cores per cluster (8 now, </di=
v>=0A<div>&gt;virt uses 16 which is architecture maximum now) in case we w=
ould use it </div>=0A<div>&gt;in generation of PPTT in EDK2.</div><div><br=
></div><div><span style=3D"background-color: transparent;">I don't fully u=
nderstand "the amount of cores per cluster", does it means the user config=
: -smp clusters=3DX, cores=3DY which indicates</span></div><div><span styl=
e=3D"background-color: transparent;">the number of cores in one cluster is=
 Y, or the AFF0/AFF1 in MPDIR?</span></div><div><span style=3D"background-=
color: transparent;"><br></span></div><div><span style=3D"background-color=
: transparent;">The cpu topology is defined by the user on command line wh=
ich PPTT want to align with.&nbsp;</span><span style=3D"background-color: =
transparent;">&nbsp;And t</span><span style=3D"background-color: transpare=
nt;">he value of AFF0/AFF1 is generally&nbsp;</span></div><div><span style=
=3D"background-color: transparent;">8 or 16&nbsp;</span><span style=3D"bac=
kground-color: transparent;">which will not&nbsp;</span><span style=3D"bac=
kground-color: transparent;">affected by&nbsp;</span><span style=3D"backgr=
ound-color: transparent;">&nbsp;</span><span style=3D"background-color: tr=
ansparent;">option -smp command.&nbsp; &nbsp;</span><span style=3D"backgro=
und-color: transparent;">Considering that MPDIR cannot reflect the cpu top=
ology configurated by&nbsp;</span></div><div><span style=3D"background-col=
or: transparent;">user, i guess the PPTT&nbsp; don't need to use the MPDIR=
 value.</span></div><div><br></div>=0A</div></blockquote>=0A</body></html>
------=_001_NextPart835020623601_=------


