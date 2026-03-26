Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789E9109E55C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ece-00014f-O8; Thu, 26 Mar 2026 02:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1w5ecd-00014U-DQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:55:15 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1w5ecZ-0004bz-3N
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=eKFPfilZSJjUgBTJpntGgSHDkEJb7wK7+iF2fXLWktc=; b=I
 JmU5GjdlKcJDhE3Fjvl0VzQ+1zlpOOKZ5bgekFZ9bR3NuteHsAlsGKZGLNNLFIiD
 SZZbgtPbL8kGc4ZHJvw6sibauacMhUcLc8hoS+sOxzFlPj9HQt0YBUGJO+BRIdZ6
 YLkAKvgCJ9QxfbAVT54F0jw6N22IS+TGtvModmPV6s=
Received: from 13824125580$163.com ( [218.13.223.218] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Thu, 26 Mar 2026 14:54:56 +0800
 (CST)
X-Originating-IP: [218.13.223.218]
Date: Thu, 26 Mar 2026 14:54:56 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: =?UTF-8?Q?Contradiction_in_Intel_IOMMU_Two=E2=80=91S?=
 =?UTF-8?Q?tage_Translation:_Stage=E2=80=AF1_Mapping_?=
 =?UTF-8?Q?Requirements_Leaked_to_Hypervisor_?=
 =?UTF-8?Q?Due_to_Host=E2=80=91Side_Driver_Interface.?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2cBvmbt0gi4CSdZ+kcmk8Rhe8/XsKws/gg1YdSc/kEtQ3UwTs7YlZoMXTy0s+1Bh21tyOdUyFg0eRDWrNVBJLAaCqdgJfAqieqxGNFyg==
Content-Type: multipart/alternative; 
 boundary="----=_Part_94063_1232434990.1774508096463"
MIME-Version: 1.0
Message-ID: <c304de5.6160.19d28ecbbd0.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bygvCgD3V+xA2MRpqfaAAA--.4807W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/xtbC0ADRFGnE2ECo4gAA3q
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=117.135.210.3; envelope-from=13824125580@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

------=_Part_94063_1232434990.1774508096463
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGkgZm9sa3M6CkluIGEgdHdvLXN0YWdlIHRyYW5zbGF0aW9uIHNjaGVtZSwgdGhlIGZpcnN0IHN0
YWdlIHNob3VsZCBiZSBoaWRkZW4gaW5zaWRlIHRoZSBWTSBkcml2ZXIuIEZvciBleGFtcGxlLCB0
aGUgZW11bGF0ZWQgaGFyZHdhcmUgb2YgdGhlIFZNIG5lZWRzIHRvIHVzZSBTdGFnZeKArzEgdG8g
bWFwIEdWQSAob3IgR0lPVkEpIHRvIEdQQSwgd2hpbGUgU3RhZ2XigK8yIHNob3VsZCBiZSBoYW5k
bGVkIGJ5IHRoZSBoeXBlcnZpc29yLiBJIHVuZGVyc3RhbmQgdGhpcyBwcmluY2lwbGUuCgpIb3dl
dmVyLCBpbiB0aGUgY3VycmVudCBJbnRlbCBJT01NVSBpbXBsZW1lbnRhdGlvbiBvZiB0d28tc3Rh
Z2UgdHJhbnNsYXRpb24sIGl0IHNlZW1zIHRoYXQgYm90aCBTdGFnZeKArzIgYW5kIFN0YWdl4oCv
MSByZXF1aXJlIGRpcmVjdGx5IGludm9raW5nIGRyaXZlciBpbnRlcmZhY2VzIGluIHRoZSBob3N0
IGh5cGVydmlzb3IuIFRoaXMgYXBwcm9hY2ggZXhwb3NlcyB0aGUgVk3igJlzIGludGVybmFsIFN0
YWdl4oCvMSBtYXBwaW5nIHJlcXVpcmVtZW50cyB0byB0aGUgaHlwZXJ2aXNvciwgd2hpY2ggY3Jl
YXRlcyBhIGNvbnRyYWRpY3Rpb24uCgpIb3cgc2hvdWxkIFFFTVUgYW5kIExpbnV4IGltcGxlbWVu
dCB0aGlzIHByb3Blcmx5PwoKQmVzdCB3aXNoZXMgdG8geW91IQoKemxjYW8u
------=_Part_94063_1232434990.1774508096463
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PGRpdiBz
dHlsZT0ibWFyZ2luOjA7Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxNnB4OyI+SGkgZm9sa3M6
PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+PGRpdiBzdHlsZT0ibWFyZ2luOiAx
NnB4IDBweDsgcGFkZGluZzogMHB4OyBib3JkZXI6IDBweCBub25lIHJnYigxNSwgMTcsIDIxKTsg
Zm9udC1zaXplOiAxNnB4OyBmb250LWZhbWlseTogcXVvdGUtY2prLXBhdGNoLCBJbnRlciwgc3lz
dGVtLXVpLCAtYXBwbGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsICZxdW90O1NlZ29lIFVJ
JnF1b3Q7LCBSb2JvdG8sIE94eWdlbiwgVWJ1bnR1LCBDYW50YXJlbGwsICZxdW90O09wZW4gU2Fu
cyZxdW90OywgJnF1b3Q7SGVsdmV0aWNhIE5ldWUmcXVvdDssIHNhbnMtc2VyaWY7IHRleHQtaW5k
ZW50OiAyZW07Ij5JbiBhIHR3by1zdGFnZSB0cmFuc2xhdGlvbiBzY2hlbWUsIHRoZSBmaXJzdCBz
dGFnZSBzaG91bGQgYmUgaGlkZGVuIGluc2lkZSB0aGUgVk0gZHJpdmVyLiBGb3IgZXhhbXBsZSwg
dGhlIGVtdWxhdGVkIGhhcmR3YXJlIG9mIHRoZSBWTSBuZWVkcyB0byB1c2UgU3RhZ2XigK8xIHRv
IG1hcCBHVkEgKG9yIEdJT1ZBKSB0byBHUEEsIHdoaWxlIFN0YWdl4oCvMiBzaG91bGQgYmUgaGFu
ZGxlZCBieSB0aGUgaHlwZXJ2aXNvci4gSSB1bmRlcnN0YW5kIHRoaXMgcHJpbmNpcGxlLjwvZGl2
PjxwIGNsYXNzPSJkcy1tYXJrZG93bi1wYXJhZ3JhcGgiIHN0eWxlPSJtYXJnaW46IDE2cHggMHB4
OyBjb2xvcjogcmdiKDE1LCAxNywgMjEpOyBmb250LWZhbWlseTogcXVvdGUtY2prLXBhdGNoLCBJ
bnRlciwgc3lzdGVtLXVpLCAtYXBwbGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsICZxdW90
O1NlZ29lIFVJJnF1b3Q7LCBSb2JvdG8sIE94eWdlbiwgVWJ1bnR1LCBDYW50YXJlbGwsICZxdW90
O09wZW4gU2FucyZxdW90OywgJnF1b3Q7SGVsdmV0aWNhIE5ldWUmcXVvdDssIHNhbnMtc2VyaWY7
IGZvbnQtc2l6ZTogMTZweDsiPkhvd2V2ZXIsIGluIHRoZSBjdXJyZW50IEludGVsIElPTU1VIGlt
cGxlbWVudGF0aW9uIG9mIHR3by1zdGFnZSB0cmFuc2xhdGlvbiwgaXQgc2VlbXMgdGhhdCBib3Ro
IFN0YWdl4oCvMiBhbmQgU3RhZ2XigK8xIHJlcXVpcmUgZGlyZWN0bHkgaW52b2tpbmcgZHJpdmVy
IGludGVyZmFjZXMgaW4gdGhlIGhvc3QgaHlwZXJ2aXNvci4gVGhpcyBhcHByb2FjaCBleHBvc2Vz
IHRoZSBWTeKAmXMgaW50ZXJuYWwgU3RhZ2XigK8xIG1hcHBpbmcgcmVxdWlyZW1lbnRzIHRvIHRo
ZSBoeXBlcnZpc29yLCB3aGljaCBjcmVhdGVzIGEgY29udHJhZGljdGlvbi48L3A+PHAgY2xhc3M9
ImRzLW1hcmtkb3duLXBhcmFncmFwaCIgc3R5bGU9Im1hcmdpbi10b3A6IDE2cHg7IG1hcmdpbi1y
aWdodDogMHB4OyBtYXJnaW4tbGVmdDogMHB4OyBjb2xvcjogcmdiKDE1LCAxNywgMjEpOyBmb250
LWZhbWlseTogcXVvdGUtY2prLXBhdGNoLCBJbnRlciwgc3lzdGVtLXVpLCAtYXBwbGUtc3lzdGVt
LCBCbGlua01hY1N5c3RlbUZvbnQsICZxdW90O1NlZ29lIFVJJnF1b3Q7LCBSb2JvdG8sIE94eWdl
biwgVWJ1bnR1LCBDYW50YXJlbGwsICZxdW90O09wZW4gU2FucyZxdW90OywgJnF1b3Q7SGVsdmV0
aWNhIE5ldWUmcXVvdDssIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTZweDsgbWFyZ2luLWJvdHRv
bTogMHB4ICFpbXBvcnRhbnQ7Ij5Ib3cgc2hvdWxkIFFFTVUgYW5kIExpbnV4IGltcGxlbWVudCB0
aGlzIHByb3Blcmx5PzwvcD48cCBjbGFzcz0iZHMtbWFya2Rvd24tcGFyYWdyYXBoIiBzdHlsZT0i
bWFyZ2luLXRvcDogMTZweDsgbWFyZ2luLXJpZ2h0OiAwcHg7IG1hcmdpbi1sZWZ0OiAwcHg7IGNv
bG9yOiByZ2IoMTUsIDE3LCAyMSk7IGZvbnQtZmFtaWx5OiBxdW90ZS1jamstcGF0Y2gsIEludGVy
LCBzeXN0ZW0tdWksIC1hcHBsZS1zeXN0ZW0sIEJsaW5rTWFjU3lzdGVtRm9udCwgJnF1b3Q7U2Vn
b2UgVUkmcXVvdDssIFJvYm90bywgT3h5Z2VuLCBVYnVudHUsIENhbnRhcmVsbCwgJnF1b3Q7T3Bl
biBTYW5zJnF1b3Q7LCAmcXVvdDtIZWx2ZXRpY2EgTmV1ZSZxdW90Oywgc2Fucy1zZXJpZjsgZm9u
dC1zaXplOiAxNnB4OyBtYXJnaW4tYm90dG9tOiAwcHggIWltcG9ydGFudDsiPkJlc3Qgd2lzaGVz
IHRvIHlvdSE8L3A+PHAgY2xhc3M9ImRzLW1hcmtkb3duLXBhcmFncmFwaCIgc3R5bGU9Im1hcmdp
bi10b3A6IDE2cHg7IG1hcmdpbi1yaWdodDogMHB4OyBtYXJnaW4tbGVmdDogMHB4OyBjb2xvcjog
cmdiKDE1LCAxNywgMjEpOyBmb250LWZhbWlseTogcXVvdGUtY2prLXBhdGNoLCBJbnRlciwgc3lz
dGVtLXVpLCAtYXBwbGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsICZxdW90O1NlZ29lIFVJ
JnF1b3Q7LCBSb2JvdG8sIE94eWdlbiwgVWJ1bnR1LCBDYW50YXJlbGwsICZxdW90O09wZW4gU2Fu
cyZxdW90OywgJnF1b3Q7SGVsdmV0aWNhIE5ldWUmcXVvdDssIHNhbnMtc2VyaWY7IGZvbnQtc2l6
ZTogMTZweDsgbWFyZ2luLWJvdHRvbTogMHB4ICFpbXBvcnRhbnQ7Ij56bGNhby48L3A+PC9kaXY+
PC9kaXY+
------=_Part_94063_1232434990.1774508096463--


