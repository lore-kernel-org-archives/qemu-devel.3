Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6EAD58CBD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 01:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4TmG-00009i-Te; Sun, 22 Mar 2026 21:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1w4Tm9-00009H-Sy; Sun, 22 Mar 2026 21:08:15 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1w4Tm8-0002CV-2L; Sun, 22 Mar 2026 21:08:13 -0400
X-UUID: bcf482c2265411f1a21c59e7364eecb8-20260323
X-CID-CACHE: Type:Local,Time:202603230905+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:3d4bd11e-c460-468e-a873-b8f495c0b998, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:89c9d04, CLOUDID:0973ee26d8f22c38d7f74e4042e28148,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102|898,TC:0,Content:0|14|51,EDM:-
 3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: EF334E7F615894A3C81E98A5676B0B32
X-UUID: bcf482c2265411f1a21c59e7364eecb8-20260323
Received: from node1 [(10.44.16.4)] by mailgw.kylinos.cn
 (envelope-from <yanlonglong@kylinos.cn>) (Generic MTA)
 with ESMTP id 1502801868; Mon, 23 Mar 2026 09:08:01 +0800
Received: from node1 (localhost [127.0.0.1])
 by node1 (NSMail) with SMTP id 6299D43107285;
 Mon, 23 Mar 2026 09:08:01 +0800 (CST)
Received: by node1 (NSMail, from userid 10001)
 id 5A53543107285; Mon, 23 Mar 2026 09:08:01 +0800 (CST)
From: =?UTF-8?B?5pmP6b6Z6b6Z?= <yanlonglong@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSBody9pZGU6IHJlc29sdmUgY29yZSBjcmFzaCBjYXVzZWQgYnkgb3B0aWNhbCBkcml2ZSBwb3AtdXAgZHVyaW5nIHZpcnR1YWwgbWFjaGluZSBzdGFydHVw?=
To: =?UTF-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>,
 =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: =?UTF-8?B?cWVtdS1ibG9jaw==?= <qemu-block@nongnu.org>,
 =?UTF-8?B?Sm9obiBTbm93?= <jsnow@redhat.com>
Date: Mon, 23 Mar 2026 09:08:01 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <206l037xdraj-206rqjp6tegc@nsmail8.2--kylin--1>
References: ba45d8ab-7c2f-4634-9bce-900af78ecc8d@linaro.org
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Mon, 23 Mar 2026 09:08:01 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-247k83fuyuem-247p6qy9hy7j
X-ns-mid: webmail-69c09271-20sbo8f0
X-ope-from: <yanlonglong@kylinos.cn>
X-receipt: 0
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=yanlonglong@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, HTML_OBFUSCATE_05_10=0.26, MIME_HTML_ONLY=0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

This message is in MIME format.

--nsmail-247k83fuyuem-247p6qy9hy7j
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+c2luY2Ugd2UgY29tcGlsZWQgdGhlIHJlbGVhc2UgdmVyc2lv
biwgd2UgZGlkbid0IHVzZSBhc3NlcnQgdG8gYWRkcmVzcyB0aGlzIGlzc3Vl
LjwvcD4KPHA+Jm5ic3A7PC9wPgo8ZGl2IGlkPSJzaWduYXR1cmVUb3AiPjwv
ZGl2Pgo8ZGl2IGlkPSJjczJjX3JlIiBzdHlsZT0ibWFyZ2luLWxlZnQ6IDAu
NWVtOyBwYWRkaW5nLWxlZnQ6IDAuNWVtOyBib3JkZXItbGVmdDogMXB4IHNv
bGlkICNjYWNhY2E7IC13ZWJraXQtdXNlci1tb2RpZnk6IHJlYWQtb25seTsg
LW1vei11c2VyLW1vZGlmeTogcmVhZC1vbmx5OyAtbXMtdXNlci1tb2RpZnk6
IHJlYWQtb25seTsgLW8tdXNlci1tb2RpZnk6IHJlYWQtb25seTsiPjxicj48
YnI+PGJyPgo8ZGl2IHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiAjZjhmOGY4
OyBwYWRkaW5nOiA4cHggMTBweDsgZm9udC1mYW1pbHk6IE1pY3Jvc29mdCBZ
YUhlaTsgZm9udC1zaXplOiAxNHB4OyBjb2xvcjogIzAwMDsiPjxzdHJvbmc+
5Li7Jm5ic3A7Jm5ic3A7Jm5ic3A76aKY77yaPC9zdHJvbmc+PHNwYW4gaWQ9
ImNzMmNfc3ViamVjdCI+UmU6IFtQQVRDSF0gaHcvaWRlOiByZXNvbHZlIGNv
cmUgY3Jhc2ggY2F1c2VkIGJ5IG9wdGljYWwgZHJpdmUgcG9wLXVwIGR1cmlu
ZyB2aXJ0dWFsIG1hY2hpbmUgc3RhcnR1cDwvc3Bhbj4gPGJyPjxzdHJvbmc+
5pelJm5ic3A7Jm5ic3A7Jm5ic3A75pyf77yaPC9zdHJvbmc+PHNwYW4gaWQ9
ImNzMmNfZGF0ZSI+MjAyNuW5tDAz5pyIMjDml6UxNTowODwvc3Bhbj4gPGJy
PjxzdHJvbmc+5Y+R5Lu25Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9ImNzMmNf
ZnJvbSI+UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k8L3NwYW4+IDxicj48c3Ry
b25nPuaUtuS7tuS6uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJjX3RvIiBz
dHlsZT0id29yZC1icmVhazogYnJlYWstYWxsOyI+cWVtdS1kZXZlbCxQaGls
aXBwZSBNYXRoaWV1LURhdWTDqTwvc3Bhbj4gPGJyPjxzdHJvbmc+5oqE6YCB
5Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9ImNzMmNfdG8iIHN0eWxlPSJ3b3Jk
LWJyZWFrOiBicmVhay1hbGw7Ij5xZW11LWJsb2NrLEpvaG4gU25vdzwvc3Bh
bj48L2Rpdj4KPGJyPgo8ZGl2IGlkPSJjczJjX2NvbnRlbnQiPkhpLCBDYydp
bmcgbWFpbnRhaW5lcnM6ICQgLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBs
IC1mIGh3L2lkZS9hdGFwaS5jIEpvaG4gU25vdyAmbHQ7anNub3dAcmVkaGF0
LmNvbSZndDsgKG9kZCBmaXhlcjpJREUpIHFlbXUtYmxvY2tAbm9uZ251Lm9y
ZyAob3BlbiBsaXN0OklERSkgcWVtdS1kZXZlbEBub25nbnUub3JnIChvcGVu
IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSkgT24gMjAvMy8yNiAwMzowNywg
eWFubG9uZ2xvbmcgd3JvdGU6ICZndDsgU2lnbmVkLW9mZi1ieTogeWFubG9u
Z2xvbmcgJmx0O3lhbmxvbmdsb25nQGt5bGlub3MuY24mZ3Q7ICZndDsgLS0t
ICZndDsgaHcvaWRlL2F0YXBpLmMgfCA1ICsrKysrICZndDsgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSAmZ3Q7ICZndDsgZGlmZiAtLWdpdCBh
L2h3L2lkZS9hdGFwaS5jIGIvaHcvaWRlL2F0YXBpLmMgJmd0OyBpbmRleCBh
NDJiNzQ4NTIxLi5kMTRmZWVkNDViIDEwMDY0NCAmZ3Q7IC0tLSBhL2h3L2lk
ZS9hdGFwaS5jICZndDsgKysrIGIvaHcvaWRlL2F0YXBpLmMgJmd0OyBAQCAt
MTUzLDYgKzE1MywxMSBAQCBzdGF0aWMgdm9pZCBjZF9yZWFkX3NlY3Rvcl9j
Yih2b2lkICpvcGFxdWUsIGludCByZXQpICZndDsgc3RhdGljIGludCBjZF9y
ZWFkX3NlY3RvcihJREVTdGF0ZSAqcykgJmd0OyB7ICZndDsgdm9pZCAqYnVm
OyAmZ3Q7ICsgJmd0OyArIC8vcmVzb2x2ZSBjb3JlIGNyYXNoIGNhdXNlZCBi
eSBvcHRpY2FsIGRyaXZlIHBvcC11cCBkdXJpbmcgdmlydHVhbCBtYWNoaW5l
IHN0YXJ0dXAgJmd0OyArIGlmICghYmxrX2lzX2F2YWlsYWJsZShzLSZndDti
bGspKSB7ICZndDsgKyByZXR1cm4gLUVOT01FRElVTTsgJmd0OyArIH0gSU1I
TyB3ZSBzaG91bGRuJ3QgcmVhY2ggdGhpcyBiZWNhdXNlIGRyaXZlIGVqZWN0
aW9uIHNob3VsZCBjYW5jZWwgYW55IHJ1bm5pbmcgdHJhbnNmZXIgKHdpdGgg
aWRlX3RyYW5zZmVyX3N0b3AgSUlSQykuIFdlIGNvdWxkIGFzc2VydCBoZXJl
OiBhc3NlcnQoYmxrX2lzX2F2YWlsYWJsZShzLSZndDtibGspKTsgdG8gY2hl
Y2sgdGhlIG1pc3NpbmcgY2FuY2VsIHRyYW5zZmVyIHBhdGguICZndDsgaWYg
KHMtJmd0O2NkX3NlY3Rvcl9zaXplICE9IDIwNDggJmFtcDsmYW1wOyBzLSZn
dDtjZF9zZWN0b3Jfc2l6ZSAhPSAyMzUyKSB7ICZndDsgYmxvY2tfYWNjdF9p
bnZhbGlkKGJsa19nZXRfc3RhdHMocy0mZ3Q7YmxrKSwgQkxPQ0tfQUNDVF9S
RUFEKTsgJmx0Oy95YW5sb25nbG9uZ0BreWxpbm9zLmNuJmd0OyZsdDsvanNu
b3dAcmVkaGF0LmNvbSZndDs8L2Rpdj4KPC9kaXY+CjxwPiZuYnNwOzwvcD4K
PHA+Jm5ic3A7PC9wPgo8ZGl2IGlkPSJzaWduYXR1cmVCb20iPgo8ZGl2Pgo8
cD4mbmJzcDs8L3A+Cjxicj4KPHAgc3R5bGU9ImNvbG9yOiAjMDAwOyBmb250
LXNpemU6IDE2cHg7Ij4tLS08L3A+CjxkaXYgaWQ9ImNzMmNfbWFpbF9zaWdh
dHVyZSIgc3R5bGU9ImNvbG9yOiAjMDAwOyBmb250LXNpemU6IDE2cHg7IGZv
bnQtZmFtaWx5OiBNaWNyb3NvZnQgWWFIZWk7Ij48L2Rpdj4KPHA+Jm5ic3A7
PC9wPgo8L2Rpdj4KPC9kaXY+PC9kaXY+

--nsmail-247k83fuyuem-247p6qy9hy7j--

