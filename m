Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DB6F532CE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 04:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4t1w-000132-Ko; Tue, 24 Mar 2026 00:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w4sPD-0008S1-Bv; Mon, 23 Mar 2026 23:26:11 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w4sPA-0007pL-45; Mon, 23 Mar 2026 23:26:11 -0400
X-UUID: 2ad9d4cc273111f1a21c59e7364eecb8-20260324
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:c1e59fc9-9e2c-4650-8243-4246f5ad0e07, IP:0,
 U
 RL:0,TC:-9,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-9
X-CID-META: VersionHash:89c9d04, CLOUDID:058a6cace784d84cd6b05d80a6b84c0b,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102|898,TC:1,Content:0|14|51,EDM:-
 3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: A814217745AFC7E4D9941D82F79C941B
X-UUID: 2ad9d4cc273111f1a21c59e7364eecb8-20260324
Received: from node1 [(10.44.16.4)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>) (Generic MTA)
 with ESMTP id 1650988539; Tue, 24 Mar 2026 11:25:55 +0800
Received: from node1 (localhost [127.0.0.1])
 by node1 (NSMail) with SMTP id 08E4F43107285;
 Tue, 24 Mar 2026 11:25:55 +0800 (CST)
Received: by node1 (NSMail, from userid 10001)
 id 023DB43107285; Tue, 24 Mar 2026 11:25:54 +0800 (CST)
From: =?UTF-8?B?6LW15Zu95rGX?= <zhaoguohan@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSBibG9jay9jdXJsOiBmcmVlIHMtPnBhc3N3b3JkIGluIGNsZWFudXAgcGF0aHM=?=
To: =?UTF-8?B?emhhb2d1b2hhbl9zYWxtb24=?= <zhaoguohan_salmon@163.com>,
 =?UTF-8?B?S2V2aW4gV29sZg==?= <kwolf@redhat.com>,
 =?UTF-8?B?SGFubmEgUmVpdHo=?= <hreitz@redhat.com>,
 =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: =?UTF-8?B?cWVtdS1ibG9jaw==?= <qemu-block@nongnu.org>,
 =?UTF-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Date: Tue, 24 Mar 2026 11:25:54 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <764ug638jvkl-7651jdyo6106@nsmail8.2--kylin--1>
References: 05d1b4b2-5b05-44bb-a6c7-fc7f6afd512c@linaro.org
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Tue, 24 Mar 2026 11:25:54 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-79t7y6ferb14-79tcwtxtaeu1
X-ns-mid: webmail-69c20442-76pklxqn
X-ope-from: <zhaoguohan@kylinos.cn>
X-receipt: 0
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, HTML_OBFUSCATE_05_10=0.26, MIME_HTML_ONLY=0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Mar 2026 00:06:05 -0400
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

--nsmail-79t7y6ferb14-79tcwtxtaeu1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+Jmd0OyBTaG91bGQgd2UgZGlyZWN0bHkgY2FsbCBjdXJsX2Ns
b3NlKCkgaGVyZSBpbnN0ZWFkPyBPdGhlcndpc2U8L3A+CjxwPiZndDsgZmFj
dG9yIGEgY29tbW9uIGN1cmxfY2xlYW51cCgpIG91dCBhbmQgcmV1c2U/PC9w
Pgo8cD5UaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLjwvcD4KPHA+SSBkb24n
dCB0aGluayBjdXJsX2Nsb3NlKCkgY2FuIGJlIHVzZWQgZGlyZWN0bHkgZnJv
bSBvdXRfbm9jbGVhbiwgc2luY2U8YnI+b3V0X25vY2xlYW4gaXMgcmVhY2hl
ZCBmcm9tIHBhcnRpYWxseSBpbml0aWFsaXplZCBzdGF0ZXMuPC9wPgo8cD5j
dXJsX2Nsb3NlKCkgYXNzdW1lcyBhIHN1Y2Nlc3NmdWxseSBvcGVuZWQgaW5z
dGFuY2UgYW5kIHRlYXJzIGRvd24gdGhlPGJyPmFpby9jdXJsIHN0YXRlIHZp
YSBjdXJsX2RldGFjaF9haW9fY29udGV4dCgpLCB3aGlsZSBvdXRfbm9jbGVh
biBpcyB1c2VkPGJyPmJlZm9yZSBjdXJsX2F0dGFjaF9haW9fY29udGV4dCgp
IGFuZCwgaW4gc29tZSBjYXNlcywgYmVmb3JlIHMtJmd0O3NvY2tldHMgaXM8
YnI+aW5pdGlhbGl6ZWQuPC9wPgo8cD5TbyBJIHRoaW5rIHJldXNpbmcgY3Vy
bF9jbG9zZSgpIGhlcmUgd291bGQgY29uZmxhdGUgdGhlIG9wZW4tZmFpbHVy
ZSBhbmQ8YnI+bm9ybWFsIGNsb3NlIHBhdGhzLjwvcD4KPHA+SWYgd2Ugd2Fu
dCB0byBkZWR1cGxpY2F0ZSB0aGlzIGxhdGVyLCBmYWN0b3Jpbmcgb3V0IG9u
bHkgdGhlIGNvbW1vbiBmaWVsZDxicj5jbGVhbnVwIGludG8gYSBzbWFsbCBo
ZWxwZXIgc2hvdWxkIGJlIHNhZmVyLjwvcD4KPHA+VGhhbmtzLDxicj5HdW9I
YW48L3A+CjxwPiZuYnNwOzwvcD4KPGRpdiBpZD0ic2lnbmF0dXJlVG9wIj48
L2Rpdj4KPGRpdiBpZD0iY3MyY19yZSIgc3R5bGU9Im1hcmdpbi1sZWZ0OiAw
LjVlbTsgcGFkZGluZy1sZWZ0OiAwLjVlbTsgYm9yZGVyLWxlZnQ6IDFweCBz
b2xpZCAjY2FjYWNhOyAtd2Via2l0LXVzZXItbW9kaWZ5OiByZWFkLW9ubHk7
IC1tb3otdXNlci1tb2RpZnk6IHJlYWQtb25seTsgLW1zLXVzZXItbW9kaWZ5
OiByZWFkLW9ubHk7IC1vLXVzZXItbW9kaWZ5OiByZWFkLW9ubHk7Ij48YnI+
PGJyPjxicj4KPGRpdiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogI2Y4Zjhm
ODsgcGFkZGluZzogOHB4IDEwcHg7IGZvbnQtZmFtaWx5OiBNaWNyb3NvZnQg
WWFIZWk7IGZvbnQtc2l6ZTogMTRweDsgY29sb3I6ICMwMDA7Ij48c3Ryb25n
PuS4uyZuYnNwOyZuYnNwOyZuYnNwO+mimO+8mjwvc3Ryb25nPjxzcGFuIGlk
PSJjczJjX3N1YmplY3QiPlJlOiBbUEFUQ0hdIGJsb2NrL2N1cmw6IGZyZWUg
cy0mZ3Q7cGFzc3dvcmQgaW4gY2xlYW51cCBwYXRoczwvc3Bhbj4gPGJyPjxz
dHJvbmc+5pelJm5ic3A7Jm5ic3A7Jm5ic3A75pyf77yaPC9zdHJvbmc+PHNw
YW4gaWQ9ImNzMmNfZGF0ZSI+MjAyNuW5tDAz5pyIMjDml6UxNzoyNDwvc3Bh
bj4gPGJyPjxzdHJvbmc+5Y+R5Lu25Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9
ImNzMmNfZnJvbSI+UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k8L3NwYW4+IDxi
cj48c3Ryb25nPuaUtuS7tuS6uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJj
X3RvIiBzdHlsZT0id29yZC1icmVhazogYnJlYWstYWxsOyI+emhhb2d1b2hh
bl9zYWxtb24sS2V2aW4gV29sZixIYW5uYSBSZWl0eixQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqTwvc3Bhbj4gPGJyPjxzdHJvbmc+5oqE6YCB5Lq677yaPC9z
dHJvbmc+PHNwYW4gaWQ9ImNzMmNfdG8iIHN0eWxlPSJ3b3JkLWJyZWFrOiBi
cmVhay1hbGw7Ij5xZW11LWJsb2NrLHFlbXUtZGV2ZWw8L3NwYW4+PC9kaXY+
Cjxicj4KPGRpdiBpZD0iY3MyY19jb250ZW50Ij5IaSwgT24gMjAvMy8yNiAw
NzozMCwgemhhb2d1b2hhbl9zYWxtb25AMTYzLmNvbSB3cm90ZTogJmd0OyBG
cm9tOiBHdW9IYW4gWmhhbyAmbHQ7emhhb2d1b2hhbkBreWxpbm9zLmNuJmd0
OyAmZ3Q7ICZndDsgV2hlbiBwYXNzd29yZC1zZWNyZXQgaXMgdXNlZCwgY3Vy
bF9vcGVuKCkgcmVzb2x2ZXMgaXQgd2l0aCAmZ3Q7IHFjcnlwdG9fc2VjcmV0
X2xvb2t1cF9hc191dGY4KCkgYW5kIHN0b3JlcyB0aGUgcmV0dXJuZWQgYnVm
ZmVyIGluICZndDsgcy0mZ3Q7cGFzc3dvcmQuICZndDsgJmd0OyBVbmxpa2Ug
cy0mZ3Q7cHJveHlwYXNzd29yZCwgcy0mZ3Q7cGFzc3dvcmQgaXMgbm90IGZy
ZWVkIGVpdGhlciBpbiB0aGUgb3BlbiAmZ3Q7IGZhaWx1cmUgcGF0aCBvciBp
biBjdXJsX2Nsb3NlKCksIHNvIHRoZSByZXNvbHZlZCBzZWNyZXQgbGVha3Mg
b25jZSBpdCAmZ3Q7IGhhcyBiZWVuIGFsbG9jYXRlZC4gJmd0OyAmZ3Q7IEZy
ZWUgcy0mZ3Q7cGFzc3dvcmQgaW4gYm90aCBjbGVhbnVwIHBhdGhzLiAmZ3Q7
ICZndDsgU2lnbmVkLW9mZi1ieTogR3VvSGFuIFpoYW8gJmx0O3poYW9ndW9o
YW5Aa3lsaW5vcy5jbiZndDsgJmd0OyAtLS0gJmd0OyBibG9jay9jdXJsLmMg
fCAyICsrICZndDsgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSAm
Z3Q7ICZndDsgZGlmZiAtLWdpdCBhL2Jsb2NrL2N1cmwuYyBiL2Jsb2NrL2N1
cmwuYyAmZ3Q7IGluZGV4IDY2YWVjZmIyMGVjNi4uNDE5ZGY3ODI1OGJjIDEw
MDY0NCAmZ3Q7IC0tLSBhL2Jsb2NrL2N1cmwuYyAmZ3Q7ICsrKyBiL2Jsb2Nr
L2N1cmwuYyAmZ3Q7IEBAIC05MDMsNiArOTAzLDcgQEAgb3V0X25vY2xlYW46
ICZndDsgZ19mcmVlKHMtJmd0O2Nvb2tpZSk7ICZndDsgZ19mcmVlKHMtJmd0
O3VybCk7ICZndDsgZ19mcmVlKHMtJmd0O3VzZXJuYW1lKTsgJmd0OyArIGdf
ZnJlZShzLSZndDtwYXNzd29yZCk7ICZndDsgZ19mcmVlKHMtJmd0O3Byb3h5
dXNlcm5hbWUpOyAmZ3Q7IGdfZnJlZShzLSZndDtwcm94eXBhc3N3b3JkKTsg
Jmd0OyBpZiAocy0mZ3Q7c29ja2V0cykgeyBTaG91bGQgd2UgZGlyZWN0bHkg
Y2FsbCBjdXJsX2Nsb3NlKCkgaGVyZSBpbnN0ZWFkPyBPdGhlcndpc2UgZmFj
dG9yIGEgY29tbW9uIGN1cmxfY2xlYW51cCgpIG91dCBhbmQgcmV1c2U/ICZn
dDsgQEAgLTEwMTQsNiArMTAxNSw3IEBAIHN0YXRpYyB2b2lkIGN1cmxfY2xv
c2UoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpICZndDsgZ19mcmVlKHMtJmd0O2Nv
b2tpZSk7ICZndDsgZ19mcmVlKHMtJmd0O3VybCk7ICZndDsgZ19mcmVlKHMt
Jmd0O3VzZXJuYW1lKTsgJmd0OyArIGdfZnJlZShzLSZndDtwYXNzd29yZCk7
ICZndDsgZ19mcmVlKHMtJmd0O3Byb3h5dXNlcm5hbWUpOyAmZ3Q7IGdfZnJl
ZShzLSZndDtwcm94eXBhc3N3b3JkKTsgJmd0OyB9ICZsdDsvemhhb2d1b2hh
bkBreWxpbm9zLmNuJmd0OyZsdDsvemhhb2d1b2hhbkBreWxpbm9zLmNuJmd0
OzwvZGl2Pgo8L2Rpdj4KPHA+Jm5ic3A7PC9wPgo8cD4mbmJzcDs8L3A+Cjxk
aXYgaWQ9InNpZ25hdHVyZUJvbSI+CjxkaXY+CjxwPiZuYnNwOzwvcD4KPGJy
Pgo8cCBzdHlsZT0iY29sb3I6ICMwMDA7IGZvbnQtc2l6ZTogMTZweDsiPi0t
LTwvcD4KPGRpdiBpZD0iY3MyY19tYWlsX3NpZ2F0dXJlIiBzdHlsZT0iY29s
b3I6ICMwMDA7IGZvbnQtc2l6ZTogMTZweDsgZm9udC1mYW1pbHk6IE1pY3Jv
c29mdCBZYUhlaTsiPjwvZGl2Pgo8cD4mbmJzcDs8L3A+CjwvZGl2Pgo8L2Rp
dj48L2Rpdj4=

--nsmail-79t7y6ferb14-79tcwtxtaeu1--

