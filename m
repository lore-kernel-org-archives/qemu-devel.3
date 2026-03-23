Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA00D58CBB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 01:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Tjn-00082a-IG; Sun, 22 Mar 2026 21:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1w4Tjg-00082G-SQ
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 21:05:41 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1w4Tje-00023N-2E
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 21:05:40 -0400
X-UUID: 5d8246bc265411f1a21c59e7364eecb8-20260323
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:4fe2dcd0-31e2-4c1f-b2b5-cdffc3e3f44a, IP:0,
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
X-CID-RHF: 53E17CBBFE5CE0F929568BAFC700FE55
X-UUID: 5d8246bc265411f1a21c59e7364eecb8-20260323
Received: from node1 [(10.44.16.4)] by mailgw.kylinos.cn
 (envelope-from <yanlonglong@kylinos.cn>) (Generic MTA)
 with ESMTP id 1489393134; Mon, 23 Mar 2026 09:05:21 +0800
Received: from node1 (localhost [127.0.0.1])
 by node1 (NSMail) with SMTP id 3F9AB43107286;
 Mon, 23 Mar 2026 09:05:21 +0800 (CST)
Received: by node1 (NSMail, from userid 10001)
 id 3886F43107286; Mon, 23 Mar 2026 09:05:21 +0800 (CST)
From: =?UTF-8?B?5pmP6b6Z6b6Z?= <yanlonglong@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSBody9pZGU6IHJlc29sdmUgY29yZSBjcmFzaCBjYXVzZWQgYnkgb3B0aWNhbCBkcml2ZSBwb3AtdXAgZHVyaW5nIHZpcnR1YWwgbWFjaGluZSBzdGFydHVw?=
To: =?UTF-8?B?TWFya3VzIEFybWJydXN0ZXI=?= <armbru@redhat.com>
Cc: =?UTF-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>,
 =?UTF-8?B?Sm9obiBTbm93?= <jsnow@redhat.com>
Date: Mon, 23 Mar 2026 09:05:21 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <1a3bpqsg0je3-1a3jv8ue67n0@nsmail8.2--kylin--1>
References: 87341vkmxc.fsf@pond.sub.org
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Mon, 23 Mar 2026 09:05:21 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-1d5o9jijul9q-1d5t870ydp2n
X-ns-mid: webmail-69c091d1-1angym7p
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

--nsmail-1d5o9jijul9q-1d5t870ydp2n
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+VGhpcyBvY2N1cnJlZCBpbiBhIHByb2R1Y3Rpb24gZW52aXJv
bm1lbnQ8L3A+CjxwPiZuYnNwOzwvcD4KPGRpdiBpZD0ic2lnbmF0dXJlVG9w
Ij48L2Rpdj4KPGRpdiBpZD0iY3MyY19yZSIgc3R5bGU9Im1hcmdpbi1sZWZ0
OiAwLjVlbTsgcGFkZGluZy1sZWZ0OiAwLjVlbTsgYm9yZGVyLWxlZnQ6IDFw
eCBzb2xpZCAjY2FjYWNhOyAtd2Via2l0LXVzZXItbW9kaWZ5OiByZWFkLW9u
bHk7IC1tb3otdXNlci1tb2RpZnk6IHJlYWQtb25seTsgLW1zLXVzZXItbW9k
aWZ5OiByZWFkLW9ubHk7IC1vLXVzZXItbW9kaWZ5OiByZWFkLW9ubHk7Ij48
YnI+PGJyPjxicj4KPGRpdiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogI2Y4
ZjhmODsgcGFkZGluZzogOHB4IDEwcHg7IGZvbnQtZmFtaWx5OiBNaWNyb3Nv
ZnQgWWFIZWk7IGZvbnQtc2l6ZTogMTRweDsgY29sb3I6ICMwMDA7Ij48c3Ry
b25nPuS4uyZuYnNwOyZuYnNwOyZuYnNwO+mimO+8mjwvc3Ryb25nPjxzcGFu
IGlkPSJjczJjX3N1YmplY3QiPlJlOiBbUEFUQ0hdIGh3L2lkZTogcmVzb2x2
ZSBjb3JlIGNyYXNoIGNhdXNlZCBieSBvcHRpY2FsIGRyaXZlIHBvcC11cCBk
dXJpbmcgdmlydHVhbCBtYWNoaW5lIHN0YXJ0dXA8L3NwYW4+IDxicj48c3Ry
b25nPuaXpSZuYnNwOyZuYnNwOyZuYnNwO+acn++8mjwvc3Ryb25nPjxzcGFu
IGlkPSJjczJjX2RhdGUiPjIwMjblubQwM+aciDIw5pelMTQ6NTc8L3NwYW4+
IDxicj48c3Ryb25nPuWPkeS7tuS6uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJj
czJjX2Zyb20iPk1hcmt1cyBBcm1icnVzdGVyPC9zcGFuPiA8YnI+PHN0cm9u
Zz7mlLbku7bkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY190byIgc3R5
bGU9IndvcmQtYnJlYWs6IGJyZWFrLWFsbDsiPk1hcmt1cyBBcm1icnVzdGVy
PC9zcGFuPiA8YnI+PHN0cm9uZz7mioTpgIHkurrvvJo8L3N0cm9uZz48c3Bh
biBpZD0iY3MyY190byIgc3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLWFsbDsi
PnFlbXUtZGV2ZWwsSm9obiBTbm93PC9zcGFuPjwvZGl2Pgo8YnI+CjxkaXYg
aWQ9ImNzMmNfY29udGVudCI+UmVwcm9kdWNlcj8gSXMgdGhpcyBhIHJlZ3Jl
c3Npb24/IHlhbmxvbmdsb25nICZsdDt5YW5sb25nbG9uZ0BreWxpbm9zLmNu
Jmd0OyB3cml0ZXM6ICZndDsgU2lnbmVkLW9mZi1ieTogeWFubG9uZ2xvbmcg
Jmx0O3lhbmxvbmdsb25nQGt5bGlub3MuY24mZ3Q7ICZndDsgLS0tICZndDsg
aHcvaWRlL2F0YXBpLmMgfCA1ICsrKysrICZndDsgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSAmZ3Q7ICZndDsgZGlmZiAtLWdpdCBhL2h3L2lk
ZS9hdGFwaS5jIGIvaHcvaWRlL2F0YXBpLmMgJmd0OyBpbmRleCBhNDJiNzQ4
NTIxLi5kMTRmZWVkNDViIDEwMDY0NCAmZ3Q7IC0tLSBhL2h3L2lkZS9hdGFw
aS5jICZndDsgKysrIGIvaHcvaWRlL2F0YXBpLmMgJmd0OyBAQCAtMTUzLDYg
KzE1MywxMSBAQCBzdGF0aWMgdm9pZCBjZF9yZWFkX3NlY3Rvcl9jYih2b2lk
ICpvcGFxdWUsIGludCByZXQpICZndDsgc3RhdGljIGludCBjZF9yZWFkX3Nl
Y3RvcihJREVTdGF0ZSAqcykgJmd0OyB7ICZndDsgdm9pZCAqYnVmOyAmZ3Q7
ICsgJmd0OyArIC8vcmVzb2x2ZSBjb3JlIGNyYXNoIGNhdXNlZCBieSBvcHRp
Y2FsIGRyaXZlIHBvcC11cCBkdXJpbmcgdmlydHVhbCBtYWNoaW5lIHN0YXJ0
dXAgZG9jcy9kZXZlbC9zdHlsZS5yc3Q6IFdlIHVzZSB0cmFkaXRpb25hbCBD
LXN0eWxlIC9gYCpgYCBgYCpgYC8gY29tbWVudHMgYW5kIGF2b2lkIC8vIGNv
bW1lbnRzLiAmZ3Q7ICsgaWYgKCFibGtfaXNfYXZhaWxhYmxlKHMtJmd0O2Js
aykpIHsgJmd0OyArIHJldHVybiAtRU5PTUVESVVNOyAmZ3Q7ICsgfSAmZ3Q7
ICZndDsgaWYgKHMtJmd0O2NkX3NlY3Rvcl9zaXplICE9IDIwNDggJmFtcDsm
YW1wOyBzLSZndDtjZF9zZWN0b3Jfc2l6ZSAhPSAyMzUyKSB7ICZndDsgYmxv
Y2tfYWNjdF9pbnZhbGlkKGJsa19nZXRfc3RhdHMocy0mZ3Q7YmxrKSwgQkxP
Q0tfQUNDVF9SRUFEKTsgJmx0Oy95YW5sb25nbG9uZ0BreWxpbm9zLmNuJmd0
OyZsdDsveWFubG9uZ2xvbmdAa3lsaW5vcy5jbiZndDs8L2Rpdj4KPC9kaXY+
CjxwPiZuYnNwOzwvcD4KPHA+Jm5ic3A7PC9wPgo8ZGl2IGlkPSJzaWduYXR1
cmVCb20iPgo8ZGl2Pgo8cD4mbmJzcDs8L3A+Cjxicj4KPHAgc3R5bGU9ImNv
bG9yOiAjMDAwOyBmb250LXNpemU6IDE2cHg7Ij4tLS08L3A+CjxkaXYgaWQ9
ImNzMmNfbWFpbF9zaWdhdHVyZSIgc3R5bGU9ImNvbG9yOiAjMDAwOyBmb250
LXNpemU6IDE2cHg7IGZvbnQtZmFtaWx5OiBNaWNyb3NvZnQgWWFIZWk7Ij48
L2Rpdj4KPHA+Jm5ic3A7PC9wPgo8L2Rpdj4KPC9kaXY+PC9kaXY+

--nsmail-1d5o9jijul9q-1d5t870ydp2n--

