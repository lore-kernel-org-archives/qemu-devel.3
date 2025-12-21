Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E844AD68BD5
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 23:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXTDz-0005RB-Pe; Sun, 21 Dec 2025 18:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1vXTDy-0005R3-5w
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 18:52:30 -0500
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1vXTDv-0007AV-0N
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 18:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=eKj25jiiK4DPg1zE3nTHe7A2m6pskjJmOG8KEofiN8Y=; b=j
 JL3MK//WQ3HxG2JruoWaPj1a3+6UhHXtJvxcEGQhnAiYeV3xKG4DE3GRzsQ/k0r6
 aWiaWe1zDFLqbka7IbtW6GRa0ip05O556FoRby4v+9T3xW2GgR/hHAewHYlYIxFZ
 L2MZiSGeGZiuJM2yRl0N0bT5nFQaFcRZp3JQXx1ZDs=
Received: from 13824125580$163.com ( [218.13.223.218] ) by
 ajax-webmail-wmsvr-40-124 (Coremail) ; Mon, 22 Dec 2025 07:52:11 +0800
 (CST)
X-Originating-IP: [218.13.223.218]
Date: Mon, 22 Dec 2025 07:52:11 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: Is there any manuals or page to show how to setup a nest
 translation environment with stage1 and stage2 page tables on intel-iommu ?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2dBP+dvkko5yafY+kfmUkbhuw6UcWxsv4g1Y5fc8oEtgXB4AM/V3JyOFDI1MyEBwawgCO6aABL495bYKlYzJvrgfYf2/b5fzhmm0RIog==
Content-Type: multipart/alternative; 
 boundary="----=_Part_24258_916245184.1766361131686"
MIME-Version: 1.0
Message-ID: <25fe2f31.1798.19b4353eaa7.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: fCgvCgDnbywriEhpeg5FAA--.1778W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/xtbC8guY2mlIiCvDxgAA38
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.2; envelope-from=13824125580@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_FONT_FACE_BAD=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

------=_Part_24258_916245184.1766361131686
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

ICAgSGkgZ3V5czoKICAgICAgSSB3YW50IHRvIGxlYXJuIGFib3V0IGhvdyBJbnRlbCBJT01NVSBz
ZWNvbmQtbGV2ZWwgdHJhbnNsYXRpb24gd29ya3MuIERvZXMgYW55b25lIGhhdmUgYW55IG1hdGVy
aWFscyBvciBwYWdlcyBvbiB0aGlzIHRvcGljLCBzdWNoIGFzIFdJUCByZXBvc2l0b3JpZXMsIG9w
ZXJhdGlvbmFsIGd1aWRlcywgZXRjLj8gVGhhbmtzIQpCUnMKemxjYW8uCgo=
------=_Part_24258_916245184.1766361131686
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PGRpdiBz
dHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMTUs
IDE3LCAyMSk7IGZvbnQtc2l6ZTogMTZweDsgZm9udC1mYW1pbHk6IHF1b3RlLWNqay1wYXRjaCwg
SW50ZXIsIHN5c3RlbS11aSwgLWFwcGxlLXN5c3RlbSwgQmxpbmtNYWNTeXN0ZW1Gb250LCAmcXVv
dDtTZWdvZSBVSSZxdW90OywgUm9ib3RvLCBPeHlnZW4sIFVidW50dSwgQ2FudGFyZWxsLCAmcXVv
dDtPcGVuIFNhbnMmcXVvdDssICZxdW90O0hlbHZldGljYSBOZXVlJnF1b3Q7LCBzYW5zLXNlcmlm
OyI+SGkgZ3V5czo8L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48c3BhbiBzdHls
ZT0iY29sb3I6IHJnYigxNSwgMTcsIDIxKTsgZm9udC1zaXplOiAxNnB4OyBmb250LWZhbWlseTog
cXVvdGUtY2prLXBhdGNoLCBJbnRlciwgc3lzdGVtLXVpLCAtYXBwbGUtc3lzdGVtLCBCbGlua01h
Y1N5c3RlbUZvbnQsICZxdW90O1NlZ29lIFVJJnF1b3Q7LCBSb2JvdG8sIE94eWdlbiwgVWJ1bnR1
LCBDYW50YXJlbGwsICZxdW90O09wZW4gU2FucyZxdW90OywgJnF1b3Q7SGVsdmV0aWNhIE5ldWUm
cXVvdDssIHNhbnMtc2VyaWY7Ij4mbmJzcDsgJm5ic3A7ICZuYnNwOyBJIHdhbnQgdG8gbGVhcm4g
YWJvdXQgaG93IEludGVsIElPTU1VIHNlY29uZC1sZXZlbCB0cmFuc2xhdGlvbiB3b3Jrcy4gRG9l
cyBhbnlvbmUgaGF2ZSBhbnkgbWF0ZXJpYWxzIG9yIHBhZ2VzIG9uIHRoaXMgdG9waWMsIHN1Y2gg
YXMgV0lQIHJlcG9zaXRvcmllcywgb3BlcmF0aW9uYWwgZ3VpZGVzLCBldGMuPyBUaGFua3MhPC9z
cGFuPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+PGZvbnQgY29sb3I9IiMwZjExMTUiIGZh
Y2U9InF1b3RlLWNqay1wYXRjaCwgSW50ZXIsIHN5c3RlbS11aSwgLWFwcGxlLXN5c3RlbSwgQmxp
bmtNYWNTeXN0ZW1Gb250LCBTZWdvZSBVSSwgUm9ib3RvLCBPeHlnZW4sIFVidW50dSwgQ2FudGFy
ZWxsLCBPcGVuIFNhbnMsIEhlbHZldGljYSBOZXVlLCBzYW5zLXNlcmlmIj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOiAxNnB4OyI+QlJzPC9zcGFuPjwvZm9udD48L2Rpdj48ZGl2IHN0eWxlPSJtYXJn
aW46MDsiPjxmb250IGNvbG9yPSIjMGYxMTE1IiBmYWNlPSJxdW90ZS1jamstcGF0Y2gsIEludGVy
LCBzeXN0ZW0tdWksIC1hcHBsZS1zeXN0ZW0sIEJsaW5rTWFjU3lzdGVtRm9udCwgU2Vnb2UgVUks
IFJvYm90bywgT3h5Z2VuLCBVYnVudHUsIENhbnRhcmVsbCwgT3BlbiBTYW5zLCBIZWx2ZXRpY2Eg
TmV1ZSwgc2Fucy1zZXJpZiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTZweDsiPnpsY2FvLjwv
c3Bhbj48L2ZvbnQ+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigxNSwgMTcsIDIx
KTsgZm9udC1zaXplOiAxNnB4OyBmb250LWZhbWlseTogcXVvdGUtY2prLXBhdGNoLCBJbnRlciwg
c3lzdGVtLXVpLCAtYXBwbGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsICZxdW90O1NlZ29l
IFVJJnF1b3Q7LCBSb2JvdG8sIE94eWdlbiwgVWJ1bnR1LCBDYW50YXJlbGwsICZxdW90O09wZW4g
U2FucyZxdW90OywgJnF1b3Q7SGVsdmV0aWNhIE5ldWUmcXVvdDssIHNhbnMtc2VyaWY7Ij48YnI+
PC9zcGFuPjwvZGl2PjxkaXYgY2xhc3M9Il84NzFjYmNhIiBzdHlsZT0iei1pbmRleDogMTA7IGZs
ZXgtZGlyZWN0aW9uOiBjb2x1bW47IGFsaWduLWl0ZW1zOiBjZW50ZXI7IG1hcmdpbjogYXV0byAz
MnB4IDBweDsgZGlzcGxheTogZmxleDsgcG9zaXRpb246IHN0aWNreTsgYm90dG9tOiAwcHg7IGJh
Y2tncm91bmQtaW1hZ2U6IGxpbmVhci1ncmFkaWVudChyZ2JhKDAsIDAsIDAsIDApIDAlLCByZ2Jh
KDAsIDAsIDAsIDApIDMwJSwgcmdiKDI1NSwgMjU1LCAyNTUpIDMwJSwgcmdiKDI1NSwgMjU1LCAy
NTUpIDEwMCUpOyBiYWNrZ3JvdW5kLXBvc2l0aW9uOiAwJSAwJTsgYmFja2dyb3VuZC1zaXplOiBh
dXRvOyBiYWNrZ3JvdW5kLXJlcGVhdDogcmVwZWF0OyBiYWNrZ3JvdW5kLWF0dGFjaG1lbnQ6IHNj
cm9sbDsgYmFja2dyb3VuZC1vcmlnaW46IHBhZGRpbmctYm94OyBiYWNrZ3JvdW5kLWNsaXA6IGJv
cmRlci1ib3g7IGNvbG9yOiByZ2IoMTI4LCAwLCAxMjgpOyBmb250LWZhbWlseTogcXVvdGUtY2pr
LXBhdGNoLCBJbnRlciwgc3lzdGVtLXVpLCAtYXBwbGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZv
bnQsICZxdW90O1NlZ29lIFVJJnF1b3Q7LCBSb2JvdG8sIE94eWdlbiwgVWJ1bnR1LCBDYW50YXJl
bGwsICZxdW90O09wZW4gU2FucyZxdW90OywgJnF1b3Q7SGVsdmV0aWNhIE5ldWUmcXVvdDssIHNh
bnMtc2VyaWY7IGZvbnQtdmFyaWFudC1saWdhdHVyZXM6IG5vLWNvbnRleHR1YWw7Ij48L2Rpdj48
L2Rpdj4=
------=_Part_24258_916245184.1766361131686--


