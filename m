Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29472D185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnqR-0003uk-0f; Thu, 08 Jan 2026 06:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vdnqL-0003ik-Uw
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:06:19 -0500
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vdnqF-00024x-1c
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=8Rz5vsDDRTz8BdEaBkN4G7cnweh4k/Yh/6V19o30xvY=; b=N
 v+j/bXEMqr3bLfcGUqUqY/uWPjJpICLV+oyJJawcNIgqWF3xM05IQ9asWvd6pBS3
 i/Rzy3evRt9O01PCVA4oZkVyW5xJnL0PpDvUvHqLxlzCBhOLPix9zUlw3B/TmViT
 BvAHHGl6VZMKB7aSFPyEVF3gGtIou9oQl4jeQn9B28=
Received: from alanosong$163.com ( [240e:36a:147b:2000:d929:aa2:af1f:209a] )
 by ajax-webmail-wmsvr-40-149 (Coremail) ; Thu, 8 Jan 2026 19:05:31 +0800
 (CST)
X-Originating-IP: [240e:36a:147b:2000:d929:aa2:af1f:209a]
Date: Thu, 8 Jan 2026 19:05:31 +0800 (CST)
From: "Alano Song" <alanosong@163.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Jonathan Cameron" <jonathan.cameron@huawei.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Question about qemu patch
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2dBfScv0so5yifbekfmkwShuw7Uca1uPog1YBec+MGiQ7P2y4BRk1eNF7I/eWBOQyMigeHTBxM6/xFUYZAlo4b80UsWkaSvtq63Ikjug==
Content-Type: multipart/alternative; 
 boundary="----=_Part_144884_731843111.1767870331891"
MIME-Version: 1.0
Message-ID: <331af4b3.96f0.19b9d487bf4.Coremail.alanosong@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lSgvCgD3P7R8j19pU+BSAA--.16572W
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9hs0SGlfj3tjTAAA38
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=117.135.210.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

------=_Part_144884_731843111.1767870331891
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgYWxsLAoKSSBhbSB3cml0aW5nIHRvIHNoYXJlIGEgcGF0Y2ggYW5kIGFzayBmb3Igc29tZSBh
ZHZpY2UuCgpJIG5vdGljZWQgdGhlcmUgaXMgbm8gRGVzaWduV2FyZSBJMkMgY29udHJvbGxlciBt
b2RlbCBpbiBRRU1VLApzbyBJIGhhdmUgYXR0ZW1wdGVkIHRvIGFkZCBpdDoKaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDEwNjEzMTI1My4xNjE5Mi0xLUFsYW5vU29uZ0Ax
NjMuY29tLwoKSSBoYXZlIGEgY291cGxlIG9mIHF1ZXN0aW9ucyByZWdhcmRpbmcgdGhlIHBhdGNo
OgoKCjEpIElzIGl0IGFjY2VwdGFibGUgdG8gc3VibWl0IHRoZSBJMkMgY29udHJvbGxlciBtb2Rl
bCBieSBpdHNlbGYsCgogICAgd2l0aG91dCBpbnN0YW50aWF0aW5nIGl0IG9uIGFueSBzcGVjaWZp
YyBtYWNoaW5lIGJvYXJkPwoKICAgIFVzZXJzIHdobyBuZWVkIGl0IGNvdWxkIHRoZW4gYWRkIGl0
IHRvIHRoZWlyIG93biBtYWNoaW5lIG1vZGVscy4KCiAgICAxLjEpIElmIGl0IGlzIHJlcXVpcmVk
IHRvIGluc3RhbnRpYXRlIHRoZSBuZXcgbW9kZWwgb24gYSBtYWNoaW5lIGJvYXJkLAogICAgICAg
IHdoaWNoIGJvYXJkIHdvdWxkIHlvdSByZWNvbW1lbmQgZm9yIHRoaXMgcHVycG9zZT8KCiAgICAg
ICAgUGF0Y2ggcmV2aWV3ZXIgcmVtYWluZWQgbWUsIHRoYXQgdGhlIGFybS92aXJ0IGJvYXJkIGlz
IGEgbWFpbiBtb2RlbCB1c2VkLgogICAgICAgIEFuZCBJIGRvbid0IHdhbnQgbWFrZSB0cm91Ymxl
cyBvbiBzdWNoIGltcG9ydGFudCBtb2RlbC4KCjIpIENvaW5jaWRlbnRhbGx5LCBJIGZvdW5kIHRo
YXQgSm9lbCBTdGFubGV5IGlzIGRvaW5nIHRoZSBzYW1lIHdvcmujrEhBSEEgOikKICAgIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjAxMDYwNTU2NTguMjA5MDI5LTEyLWpv
ZWxAam1zLmlkLmF1LwoKCiAgICBXaGF0IHNob3VsZCBJIGRvIG5leHQsIG1heSBiZSB3ZSBjYW4g
d29yayB0b2dldGhlciB0byBzdWJtaXQgc3VjaCBtb2RlbCA/CgpCZXN0IFJlZ2FyZHMsCkFsYW5v
IFNvbmcu
------=_Part_144884_731843111.1767870331891
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PGRpdiBz
dHlsZT0ibWFyZ2luOjA7Ij48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZTsiPkhp
IGFsbCw8YnI+PGJyPkkgYW0gd3JpdGluZyB0byBzaGFyZSBhIHBhdGNoIGFuZCBhc2sgZm9yIHNv
bWUgYWR2aWNlLjxicj48YnI+SSBub3RpY2VkIHRoZXJlIGlzIG5vIERlc2lnbldhcmUgSTJDIGNv
bnRyb2xsZXIgbW9kZWwgaW4gUUVNVSw8YnI+c28gSSBoYXZlIGF0dGVtcHRlZCB0byBhZGQgaXQ6
PGJyPjxhIGhyZWY9Imh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjAxMDYx
MzEyNTMuMTYxOTItMS1BbGFub1NvbmdAMTYzLmNvbS8iPmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMjAyNjAxMDYxMzEyNTMuMTYxOTItMS1BbGFub1NvbmdAMTYzLmNvbS88L2E+
PGJyPjxicj5JIGhhdmUgYSBjb3VwbGUgb2YgcXVlc3Rpb25zIHJlZ2FyZGluZyB0aGUgcGF0Y2g6
PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+PHNwYW4gc3R5bGU9ImZvbnQtZmFt
aWx5OiBtb25vc3BhY2U7Ij48YnI+PC9zcGFuPjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5
OiBtb25vc3BhY2U7Ij4xKSBJcyBpdCBhY2NlcHRhYmxlIHRvIDx1PnN1Ym1pdCB0aGUgSTJDIGNv
bnRyb2xsZXIgbW9kZWwgYnkgaXRzZWxmLDwvdT48dT48YnI+PC91Pjwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlOyI+Jm5ic3A7ICZuYnNwOyA8dT53
aXRob3V0IGluc3RhbnRpYXRpbmcgaXQ8L3U+IG9uIGFueSBzcGVjaWZpYyBtYWNoaW5lIGJvYXJk
Pzwvc3Bhbj48YnI+PC9kaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2U7Ij4m
bmJzcDsgJm5ic3A7IFVzZXJzIHdobyBuZWVkIGl0IGNvdWxkIHRoZW4gYWRkIGl0IHRvIHRoZWly
IG93biBtYWNoaW5lIG1vZGVscy48YnI+PGJyPiZuYnNwOyAmbmJzcDsgMS4xKSBJZiBpdCBpcyBy
ZXF1aXJlZCB0byBpbnN0YW50aWF0ZSB0aGUgbmV3IG1vZGVsIG9uIGEgbWFjaGluZSBib2FyZCw8
YnI+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IDx1PndoaWNoIGJvYXJkIHdvdWxkIHlvdSBy
ZWNvbW1lbmQ8L3U+IGZvciB0aGlzIHB1cnBvc2U/PGJyPjxicj4mbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgUGF0Y2ggcmV2aWV3ZXIgcmVtYWluZWQgbWUsIHRoYXQgdGhlIGFybS92aXJ0IGJv
YXJkIGlzIGEgbWFpbiBtb2RlbCB1c2VkLjxicj4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
QW5kIEkgZG9uJ3Qgd2FudCBtYWtlIHRyb3VibGVzIG9uIHN1Y2ggaW1wb3J0YW50IG1vZGVsLjwv
c3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPjxzcGFuIHN0eWxlPSJmb250LWZhbWls
eTogbW9ub3NwYWNlOyI+PGJyPjIpIENvaW5jaWRlbnRhbGx5LCBJIGZvdW5kIHRoPC9zcGFuPjxz
cGFuIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlOyI+YXQmbmJzcDtKb2VsIFN0YW5sZXkm
bmJzcDtpcyBkbzwvc3Bhbj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZTsiPmlu
ZyB0aGUgc2FtZSB3b3Jro6xIQUhBIDopPC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjog
MHB4OyI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2U7Ij4mbmJzcDsgJm5ic3A7
Jm5ic3A7PGEgaHJlZj0iaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDEw
NjA1NTY1OC4yMDkwMjktMTItam9lbEBqbXMuaWQuYXUvIj5odHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjYwMTA2MDU1NjU4LjIwOTAyOS0xMi1qb2VsQGptcy5pZC5hdS88L2E+
PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMHB4OyI+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OiBtb25vc3BhY2U7Ij48YnI+PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjow
OyI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2U7Ij4mbmJzcDsgJm5ic3A7IFdo
YXQgc2hvdWxkIEkgZG8gbmV4dCwgbWF5IGJlIHdlIGNhbiB3b3JrIHRvZ2V0aGVyJm5ic3A7dG8g
c3VibWl0IHN1Y2ggbW9kZWwgPzxicj48YnI+QmVzdCBSZWdhcmRzLDxicj5BbGFubyBTb25nLjwv
c3Bhbj48L2Rpdj48L2Rpdj4=
------=_Part_144884_731843111.1767870331891--


