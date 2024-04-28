Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3DAC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 02:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0u1p-0006gI-Kw; Sat, 27 Apr 2024 22:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1s0u1m-0006g2-P7; Sat, 27 Apr 2024 22:12:30 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1s0u1i-00057g-FS; Sat, 27 Apr 2024 22:12:30 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX3RF9sC1mfwZOAA--.40375S2;
 Sun, 28 Apr 2024 10:12:13 +0800 (CST)
Received: from DESKTOP-E65K6PP (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXcDl2sC1mchoAAA--.139S3;
 Sun, 28 Apr 2024 10:12:06 +0800 (CST)
Date: Sun, 28 Apr 2024 10:12:06 +0800
From: "xiongyining1480@phytium.com.cn" <xiongyining1480@phytium.com.cn>
To: "Richard Henderson" <richard.henderson@linaro.org>, 
 qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: rad <rad@semihalf.com>, peter.maydell <peter.maydell@linaro.org>, 
 quic_llindhol <quic_llindhol@quicinc.com>, 
 "Marcin Juszkiewicz" <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa
 machine
References: <20240426073553.326946-1-xiongyining1480@phytium.com.cn>, 
 <20240426073553.326946-2-xiongyining1480@phytium.com.cn>, 
 <a25e01c0-5f6e-4568-93ec-970987eb6d07@linaro.org>
X-Priority: 3
X-GUID: F05A055B-186E-4EED-9A38-56A6D16D2805
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.228[cn]
Mime-Version: 1.0
Message-ID: <2024042810120618268213@phytium.com.cn>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart176011612711_=----"
X-CM-TRANSID: AQAAfwDXcDl2sC1mchoAAA--.139S3
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQAJBmYtU2QBHQABsv
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=xiongyinin
 g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tFWUArWxGFW7Jw47Ar4xWFg_yoW8Wr48pr
 W8Gr98K3ykJ3sFka13Za1xXr1rXr1rAa18Jr1Iqw42vwn8Ga4xKr17Kr4rC3srGry8A3s2
 9FWIqa4ruFs8urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=xiongyining1480@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------=_001_NextPart176011612711_=----
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQp4aW9uZ3lpbmluZzE0ODBAcGh5dGl1bS5jb20uY24NCiANCkZyb206IFJpY2hhcmQg
SGVuZGVyc29uDQpEYXRlOiAyMDI0LTA0LTI3IDAwOjA2DQpUbzogWGlvbmcgWWluaW5nOyBxZW11
LWFybTsgcWVtdS1kZXZlbA0KQ0M6IHJhZDsgcGV0ZXIubWF5ZGVsbDsgcXVpY19sbGluZGhvbDsg
bWFyY2luLmp1c3praWV3aWN6DQpTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvMV0gaHcvYXJtL3Ni
c2EtcmVmOiBFbmFibGUgQ1BVIGNsdXN0ZXIgb24gQVJNIHNic2EgbWFjaGluZQ0KT24gNC8yNi8y
NCAwMDozNSwgWGlvbmcgWWluaW5nIHdyb3RlOg0KPiBGcm9tOiB4aW9uZ3lpbmluZzE0ODAgPHhp
b25neWluaW5nMTQ4MEBwaHl0aXVtLmNvbS5jbj4NCj4gDQo+IEVuYWJsZSBDUFUgY2x1c3RlciBz
dXBwb3J0IG9uIFNic2FRZW11IHBsYXRmb3JtLCBzbyB0aGF0IHVzZXJzIGNhbg0KPiBzcGVjaWZ5
IGEgNC1sZXZlbCBDUFUgaGllcmFyY2h5IHNvY2tldHMvY2x1c3RlcnMvY29yZXMvdGhyZWFkcy4g
QW5kDQo+IHRoaXMgdG9wb2xvZ3kgY2FuIGJlIHBhc3NlZCB0byB0aGUgZmlybXdhcmUgdGhyb3Vn
aCBEVCBjcHUtbWFwLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWGlvbmcgWWluaW5nIDx4aW9uZ3lp
bmluZzE0ODBAcGh5dGl1bS5jb20uY24+DQo+IHRlc3RlZC1ieTogTWFyY2luIEp1c3praWV3aWN6
IDxtYXJjaW4uanVzemtpZXdpY3pAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgZG9jcy9zeXN0ZW0v
YXJtL3Nic2EucnN0IHwgIDQgKysrKw0KPiAgIGh3L2FybS9zYnNhLXJlZi5jICAgICAgICB8IDM3
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDQwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCiANCj4gSXNuJ3QgdGhpcyBiYXNp
Y2FsbHkgd2hhdCBNUElEUl9FTDEgaXMgc3VwcG9zZWQgdG8gaW5kaWNhdGU/DQo+IFdlIGRvIG5v
dCB5ZXQgaW1wbGVtZW50IGFsbCBvZiB0aGF0IGluIFFFTVUsIGJ1dCBzaG91bGQuDQogDQo+IFdo
eSBkb2VzIHRoZSBzYW1lIGluZm8gbmVlZCB0byBiZSByZXBsaWNhdGVkIGluIGRldmljZXRyZWU/
DQogDQpzYnNhIHVzZXMgUFBUVCB0byBpbmRpY2F0ZSB0aGUgY3B1IHRvcG9sb2d5LCBhbmQgT1Mg
dXNlIHRoZSBBQ1BJIHRvIGdldCBoYXJkd2FyZSBpbmZvbWF0aW9uLiBXZSBhZGQgdGhlIHJlbGF0
ZWQgaW5mb3JtYXRpb24gaW4gZGV2aWNldHJlZSwgYW5kIFRGLUEgcGFyc2VzIGRldmljZXRyZWUN
CmFuZCBleHRyYWN0IGRhdGEgZm9ybSBpdCAsIHNvIEVESzIgY2FuIGdhdGhlciBkYXRhIGZvcm0g
VEYtQSB0byBjcmVhdGUgUFBUVCB0YWJsZXMgdmlhIFNNQyBjYWxscy4gDQoNCk5vdyB0aGUgUFBU
VCB0YWJsZXMgY3JlYXRlZCBieSBFREsyIGxvc2Ugc29tZSBkZXRhaWxlZCBpbmZvcm1hdGlvbiwg
c28gdGhlIGNwdSB0b3BvbG9neSBPUyBpZGVudGlmaWVkIGNhbm5vdCBhbGlnbiB3aXRoIHRoZSBx
ZW11IGNvbmZpZ3VyZS4gV2UgaG9wZSB0byBhZGQgdGhlIHRvcG9sb2d5IA0KaW5mb3JtYXRpb24g
aW4gZGV2aWNlIHRyZWUsIHNvIEVLRDIgY2FuIGNyZWF0ZSBtb3JlIGRldGFpbGVkIFBQVFQgdGFi
bGVzLg0KIA0KPiByfg0K

------=_001_NextPart176011612711_=----
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
rom:</b>&nbsp;<a href=3D"mailto:richard.henderson@linaro.org">Richard Hend=
erson</a></div><div><b>Date:</b>&nbsp;2024-04-27&nbsp;00:06</div><div><b>T=
o:</b>&nbsp;<a href=3D"mailto:xiongyining1480@phytium.com.cn">Xiong Yining=
</a>; <a href=3D"mailto:qemu-arm@nongnu.org">qemu-arm</a>; <a href=3D"mail=
to:qemu-devel@nongnu.org">qemu-devel</a></div><div><b>CC:</b>&nbsp;<a href=
=3D"mailto:rad@semihalf.com">rad</a>; <a href=3D"mailto:peter.maydell@lina=
ro.org">peter.maydell</a>; <a href=3D"mailto:quic_llindhol@quicinc.com">qu=
ic_llindhol</a>; <a href=3D"mailto:marcin.juszkiewicz@linaro.org">marcin.j=
uszkiewicz</a></div><div><b>Subject:</b>&nbsp;Re: [PATCH v4 1/1] hw/arm/sb=
sa-ref: Enable CPU cluster on ARM sbsa machine</div></div></div><div><div>=
On 4/26/24 00:35, Xiong Yining wrote:</div>=0A<div>&gt; From: xiongyining1=
480 &lt;xiongyining1480@phytium.com.cn&gt;</div>=0A<div>&gt; </div>=0A<div=
>&gt; Enable CPU cluster support on SbsaQemu platform, so that users can</=
div>=0A<div>&gt; specify a 4-level CPU hierarchy sockets/clusters/cores/th=
reads. And</div>=0A<div>&gt; this topology can be passed to the firmware t=
hrough DT cpu-map.</div>=0A<div>&gt; </div>=0A<div>&gt; Signed-off-by: Xio=
ng Yining &lt;xiongyining1480@phytium.com.cn&gt;</div>=0A<div>&gt; tested-=
by: Marcin Juszkiewicz &lt;marcin.juszkiewicz@linaro.org&gt;</div>=0A<div>=
&gt; ---</div>=0A<div>&gt;&nbsp;&nbsp; docs/system/arm/sbsa.rst |&nbsp; 4 =
++++</div>=0A<div>&gt;&nbsp;&nbsp; hw/arm/sbsa-ref.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; | 37 ++++++++++++++++++++++++++++++++++++-</div>=0A<d=
iv>&gt;&nbsp;&nbsp; 2 files changed, 40 insertions(+), 1 deletion(-)</div>=
=0A<div>&nbsp;</div>=0A<div>&gt; Isn't this basically what MPIDR_EL1 is su=
pposed to indicate?</div>=0A<div>&gt; We do not yet implement all of that =
in QEMU, but should.</div>=0A<div>&nbsp;</div>=0A<div>&gt; Why does the sa=
me info need to be replicated in devicetree?</div>=0A<div>&nbsp;</div><div=
><div>sbsa uses PPTT to indicate the cpu topology, and OS use the ACPI to =
get hardware infomation. We add the related information in devicetree, and=
 TF-A parses devicetree</div><div>and extract data form it , so EDK2 can g=
ather data form TF-A to create PPTT tables via SMC calls.&nbsp;</div><div>=
<br></div><div>Now the PPTT tables created by EDK2 lose some detailed info=
rmation, so the cpu topology OS identified cannot align with the qemu conf=
igure. We hope to add the topology&nbsp;</div><div>information in device t=
ree, so EKD2 can create more detailed PPTT tables.</div></div>=0A<div>&nbs=
p;</div>=0A<div>&gt; r~</div>=0A</div></blockquote>=0A</body></html>
------=_001_NextPart176011612711_=------


