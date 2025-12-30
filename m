Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A26BE9410F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 05:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaSki-0001y2-Er; Tue, 30 Dec 2025 00:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1vaSkf-0001xW-VY
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 00:58:37 -0500
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1vaSka-0001m8-5W
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 00:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=8E+WE8DKWWfz7m9zLjRt4imtZiV+2SbTRaN1u1u3M2o=; b=Q
 zWGTJSd2KhZ56/b/CzM/QPdbFk7MsN0Gj5XHcvDOSV88hPbsKhmdidrTYYcLU5Vw
 qtvtjeENa9YAFW7h3Y1Om+2asRrGbEvyoZ2e4lwmQF0mxD1qtG9YA9CyFQm0gyO2
 BEbxoysYWWFCV4iAbvCAGi78GTLNpY1CgX3DRWxZvg=
Received: from 13824125580$163.com ( [218.13.223.218] ) by
 ajax-webmail-wmsvr-40-148 (Coremail) ; Tue, 30 Dec 2025 13:58:16 +0800
 (CST)
X-Originating-IP: [218.13.223.218]
Date: Tue, 30 Dec 2025 13:58:16 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: How can we develop a new QEMU platform from scratch to run a
 manufacturer's proprietary software system?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2dBfycu0oi4CSRZekfmUkbhuw6UcWxsv4g1Y5fc+AGuhHp5C4BbHhcPlXdwcKlDjmGrAO5TAFW0sJgb7Z/qvjI+89LuzXapT80I9e7Pw==
Content-Type: multipart/alternative; 
 boundary="----=_Part_71094_925319560.1767074296502"
MIME-Version: 1.0
Message-ID: <16b311d9.48de.19b6dd5f2b7.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lCgvCgDXDzr4aVNpoStNAA--.1319W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/xtbC8hjHCmlTafiz2wAA3k
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.3; envelope-from=13824125580@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=no autolearn_force=no
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

------=_Part_71094_925319560.1767074296502
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgZm9sa3M6CiAgICAgICAgSG93IGNhbiB3ZSBkZXZlbG9wIGEgbmV3IFFFTVUgcGxhdGZvcm0g
ZnJvbSBzY3JhdGNoIHRvIHJ1biBhIG1hbnVmYWN0dXJlcidzIHByb3ByaWV0YXJ5IHNvZnR3YXJl
IHN5c3RlbT8gQXJlIHRoZXJlIGFueSBzdGVwLWJ5LXN0ZXAgZ3VpZGVzIG9yIGRlbW8gZXhhbXBs
ZXMgYXZhaWxhYmxlIGZvciBzdGFydGluZyBmcm9tIHplcm8/IFRoYW5rIHlvdS4KCgpCUnMKemxj
YW8=
------=_Part_71094_925319560.1767074296502
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PGRpdiBz
dHlsZT0ibWFyZ2luOiAwcHg7Ij48c3BhbiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogdHJhbnNw
YXJlbnQ7IGNvbG9yOiByZ2IoMTUsIDE3LCAyMSk7IGZvbnQtZmFtaWx5OiBxdW90ZS1jamstcGF0
Y2gsIEludGVyLCBzeXN0ZW0tdWksIC1hcHBsZS1zeXN0ZW0sIEJsaW5rTWFjU3lzdGVtRm9udCwg
JnF1b3Q7U2Vnb2UgVUkmcXVvdDssIFJvYm90bywgT3h5Z2VuLCBVYnVudHUsIENhbnRhcmVsbCwg
JnF1b3Q7T3BlbiBTYW5zJnF1b3Q7LCAmcXVvdDtIZWx2ZXRpY2EgTmV1ZSZxdW90Oywgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxNnB4OyI+SGkgZm9sa3M6PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9
Im1hcmdpbjogMHB4OyI+PHNwYW4gc3R5bGU9ImJhY2tncm91bmQtY29sb3I6IHRyYW5zcGFyZW50
OyBjb2xvcjogcmdiKDE1LCAxNywgMjEpOyBmb250LWZhbWlseTogcXVvdGUtY2prLXBhdGNoLCBJ
bnRlciwgc3lzdGVtLXVpLCAtYXBwbGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsICZxdW90
O1NlZ29lIFVJJnF1b3Q7LCBSb2JvdG8sIE94eWdlbiwgVWJ1bnR1LCBDYW50YXJlbGwsICZxdW90
O09wZW4gU2FucyZxdW90OywgJnF1b3Q7SGVsdmV0aWNhIE5ldWUmcXVvdDssIHNhbnMtc2VyaWY7
IGZvbnQtc2l6ZTogMTZweDsiPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBIb3cgY2FuIHdl
IGRldmVsb3AgYSBuZXcgUUVNVSBwbGF0Zm9ybSBmcm9tIHNjcmF0Y2ggdG8gcnVuIGEgbWFudWZh
Y3R1cmVyJ3MgcHJvcHJpZXRhcnkgc29mdHdhcmUgc3lzdGVtPyBBcmUgdGhlcmUgYW55IHN0ZXAt
Ynktc3RlcCBndWlkZXMgb3IgZGVtbyBleGFtcGxlcyBhdmFpbGFibGUgZm9yIHN0YXJ0aW5nIGZy
b20gemVybz8gVGhhbmsgeW91Ljwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDBweDsi
PjxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiB0cmFuc3BhcmVudDsgY29sb3I6IHJnYigx
NSwgMTcsIDIxKTsgZm9udC1mYW1pbHk6IHF1b3RlLWNqay1wYXRjaCwgSW50ZXIsIHN5c3RlbS11
aSwgLWFwcGxlLXN5c3RlbSwgQmxpbmtNYWNTeXN0ZW1Gb250LCAmcXVvdDtTZWdvZSBVSSZxdW90
OywgUm9ib3RvLCBPeHlnZW4sIFVidW50dSwgQ2FudGFyZWxsLCAmcXVvdDtPcGVuIFNhbnMmcXVv
dDssICZxdW90O0hlbHZldGljYSBOZXVlJnF1b3Q7LCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE2
cHg7Ij48YnI+PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMHB4OyI+PHNwYW4gc3R5
bGU9ImJhY2tncm91bmQtY29sb3I6IHRyYW5zcGFyZW50OyBjb2xvcjogcmdiKDE1LCAxNywgMjEp
OyBmb250LWZhbWlseTogcXVvdGUtY2prLXBhdGNoLCBJbnRlciwgc3lzdGVtLXVpLCAtYXBwbGUt
c3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsICZxdW90O1NlZ29lIFVJJnF1b3Q7LCBSb2JvdG8s
IE94eWdlbiwgVWJ1bnR1LCBDYW50YXJlbGwsICZxdW90O09wZW4gU2FucyZxdW90OywgJnF1b3Q7
SGVsdmV0aWNhIE5ldWUmcXVvdDssIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTZweDsiPkJSczwv
c3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDBweDsiPjxzcGFuIHN0eWxlPSJiYWNrZ3Jv
dW5kLWNvbG9yOiB0cmFuc3BhcmVudDsgY29sb3I6IHJnYigxNSwgMTcsIDIxKTsgZm9udC1mYW1p
bHk6IHF1b3RlLWNqay1wYXRjaCwgSW50ZXIsIHN5c3RlbS11aSwgLWFwcGxlLXN5c3RlbSwgQmxp
bmtNYWNTeXN0ZW1Gb250LCAmcXVvdDtTZWdvZSBVSSZxdW90OywgUm9ib3RvLCBPeHlnZW4sIFVi
dW50dSwgQ2FudGFyZWxsLCAmcXVvdDtPcGVuIFNhbnMmcXVvdDssICZxdW90O0hlbHZldGljYSBO
ZXVlJnF1b3Q7LCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE2cHg7Ij56bGNhbzwvc3Bhbj48L2Rp
dj48L2Rpdj4=
------=_Part_71094_925319560.1767074296502--


